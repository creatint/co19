/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Tests that program compiling/linking/using works correctly.
 */
import "dart:html";
import "dart:web_gl" as wgl;
import 'dart:typed_data';
import "../../../testcommon.dart";
import "resources/webgl-test.dart";
import "resources/webgl-test-utils.dart" as wtu;
import "resources/desktop-gl-constants.dart";
import "../../../../Utils/async_utils.dart";

main() {
  document.body.setInnerHtml('''
      <div id="console"></div>
      <canvas id="canvas" width="2" height="2"> </canvas>
      <div>PASS</div>
      ''', treeSanitizer: new NullTreeSanitizer());

  go() {
    debug("");
    debug("Canvas.getContext");

    var gl = create3DContext(document.getElementById("canvas"));
    if (gl == null) {
      testFailed("context does not exist");
      return;
    }

    testPassed("context exists");

    gl.clearColor(0.0, 0.0, 0.0, 0.0);
    gl.clear(wgl.COLOR_BUFFER_BIT | wgl.DEPTH_BUFFER_BIT);

    doArraysHaveSameContents(a, b) {
      var aset = new Set.from(a);
      var bset = new Set.from(b);
      return aset.difference(bset).isEmpty && bset.difference(aset).isEmpty;
    }

    /////// Check compileShader() /////////////////////////////

    var vs = gl.createShader(wgl.VERTEX_SHADER);
    gl.shaderSource(vs, "attribute vec4 aVertex; attribute vec4 aColor; varying vec4 vColor; void main() { vColor = aColor; gl_Position = aVertex; }");
    gl.compileShader(vs);

    assertMsg(gl.getShaderParameter(vs, wgl.COMPILE_STATUS) == true,
        "good vertex shader should compile");

    var vs2 = gl.createShader(wgl.VERTEX_SHADER);
    gl.shaderSource(vs2, "attribute vec4 aVertex; attribute vec4 aColor; varying vec4 vColor; void main() { vColor = aColor; gl_Position = aVertex * 0.5; }");
    gl.compileShader(vs2);

    assertMsg(gl.getShaderParameter(vs2, wgl.COMPILE_STATUS) == true,
        "good vertex shader #2 should compile");

    var vsBad = gl.createShader(wgl.VERTEX_SHADER);
    gl.shaderSource(vsBad, "WILL NOT COMPILE;");
    gl.compileShader(vsBad);

    assertMsg(gl.getShaderParameter(vsBad, wgl.COMPILE_STATUS) == false,
        "bad vertex shader should fail to compile");

    var fs = gl.createShader(wgl.FRAGMENT_SHADER);
    gl.shaderSource(fs, "precision mediump float; varying vec4 vColor; void main() { gl_FragColor = vColor; }");
    gl.compileShader(fs);

    assertMsg(gl.getShaderParameter(fs, wgl.COMPILE_STATUS) == true,
        "good fragment shader should compile");

    var fs2 = gl.createShader(wgl.FRAGMENT_SHADER);
    gl.shaderSource(fs2, "precision mediump float; varying vec4 vColor; void main() { gl_FragColor = vColor * 0.5; }");
    gl.compileShader(fs2);

    assertMsg(gl.getShaderParameter(fs2, wgl.COMPILE_STATUS) == true,
        "good fragment shader #2 should compile");

    var fsBad = gl.createShader(wgl.FRAGMENT_SHADER);
    gl.shaderSource(fsBad, "WILL NOT COMPILE;");
    gl.compileShader(fsBad);

    assertMsg(gl.getShaderParameter(fsBad, wgl.COMPILE_STATUS) == false,
        "bad fragment shader should fail to compile");

    glErrorShouldBe(gl, wgl.NO_ERROR, "should be no errors at this point");

    /////// Check attachShader() /////////////////////////////

    checkAttachShader(already_attached_shaders, shader, expected_error_code, errmsg) {
      var prog = gl.createProgram();
      for (var i = 0; i < already_attached_shaders.length; ++i)
        gl.attachShader(prog, already_attached_shaders[i]);
      if(gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in attachShader()");
      gl.attachShader(prog, shader);
      glErrorShouldBe(gl, expected_error_code, errmsg);
    }

    checkAttachShader([], vs, wgl.NO_ERROR, "attaching a vertex shader should succeed");
    checkAttachShader([vs], vs, wgl.INVALID_OPERATION,
        "attaching an already attached vertex shader should generate INVALID_OPERATION");
    checkAttachShader([], fs, wgl.NO_ERROR, "attaching a fragment shader should succeed");
    checkAttachShader([fs], fs, wgl.INVALID_OPERATION,
        "attaching an already attached fragment shader should generate INVALID_OPERATION");
    checkAttachShader([vs], vs2, wgl.INVALID_OPERATION,
        "attaching shaders of the same type to a program should generate INVALID_OPERATION");
    checkAttachShader([fs], fs2, wgl.INVALID_OPERATION,
        "attaching shaders of the same type to a program should generate INVALID_OPERATION");

    /////// Check detachShader() /////////////////////////////

    checkDetachShader(already_attached_shaders, shader, expected_error_code, errmsg) {
      var prog = gl.createProgram();
      for (var i = 0; i < already_attached_shaders.length; ++i)
        gl.attachShader(prog, already_attached_shaders[i]);
      if(gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in attachShader()");
      gl.detachShader(prog, shader);
      glErrorShouldBe(gl, expected_error_code, errmsg);
    }

    checkDetachShader([vs], vs, wgl.NO_ERROR, "detaching a vertex shader should succeed");
    checkDetachShader([fs], vs, wgl.INVALID_OPERATION,
        "detaching a not already attached vertex shader should generate INVALID_OPERATION");
    checkDetachShader([fs], fs, wgl.NO_ERROR, "detaching a fragment shader should succeed");
    checkDetachShader([vs], fs, wgl.INVALID_OPERATION,
        "detaching a not already attached fragment shader should generate INVALID_OPERATION");

    /////// Check getAttachedShaders() /////////////////////////////

    checkGetAttachedShaders(shaders_to_attach, shaders_to_detach, expected_shaders, errmsg) {
      var prog = gl.createProgram();
      for (var i = 0; i < shaders_to_attach.length; ++i)
        gl.attachShader(prog, shaders_to_attach[i]);
      if(gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in attachShader()");
      for (var i = 0; i < shaders_to_detach.length; ++i)
        gl.detachShader(prog, shaders_to_detach[i]);
      if(gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in detachShader()");
      assertMsg(doArraysHaveSameContents(gl.getAttachedShaders(prog), expected_shaders), errmsg);
    }
    checkGetAttachedShaders([], [], [], "getAttachedShaders should return an empty list by default");
    checkGetAttachedShaders([fs], [], [fs], "attaching a single shader should give the expected list");
    checkGetAttachedShaders([fs, vs], [], [fs, vs],
        "attaching some shaders should give the expected list");
    checkGetAttachedShaders([fs], [fs], [], "attaching a shader and detaching it shoud leave an empty list");
    checkGetAttachedShaders([fs, vs], [fs, vs], [],
        "attaching some shaders and detaching them in same order shoud leave an empty list");
    checkGetAttachedShaders([fs, vs], [vs, fs], [],
        "attaching some shaders and detaching them in random order shoud leave an empty list");
    checkGetAttachedShaders([fs, vs], [vs], [fs],
        "attaching and detaching some shaders should leave the difference list");
    checkGetAttachedShaders([fs, vs], [fs], [vs],
        "attaching and detaching some shaders should leave the difference list");
    checkGetAttachedShaders([fsBad], [], [fsBad],
        "attaching a shader that failed to compile should still show it in the list");
    checkGetAttachedShaders([fs, vsBad], [], [fs, vsBad],
        "attaching shaders, including one that failed to compile, should still show the it in the list");

    /////// Check linkProgram() and useProgram /////////////////////////////

    checkLinkAndUse(shaders, deleteShaderAfterAttach, expected_status, errmsg) {
      var prog = gl.createProgram();
      for (var i = 0; i < shaders.length; ++i) {
        gl.attachShader(prog, shaders[i]);
        if (deleteShaderAfterAttach)
          gl.deleteShader(shaders[i]);
      }
      gl.bindAttribLocation(prog, 0, "aVertex");
      gl.bindAttribLocation(prog, 1, "aColor");
      gl.linkProgram(prog);
      if (gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in linkProgram()");
      assertMsg(gl.getProgramParameter(prog, wgl.LINK_STATUS) == expected_status, errmsg);
      if (expected_status == true && gl.getProgramParameter(prog, wgl.LINK_STATUS) == false)
        debug(gl.getProgramInfoLog(prog));
      if (gl.getError() != wgl.NO_ERROR)
        assertMsg(false, "unexpected error in getProgramParameter()");
      gl.useProgram(prog);
      if (expected_status == true)
        glErrorShouldBe(gl, wgl.NO_ERROR, "using a valid program should succeed");
      if (expected_status == false)
        glErrorShouldBe(gl, wgl.INVALID_OPERATION, "using an invalid program should generate INVALID_OPERATION");
      return prog;
    }

    var progGood1 = checkLinkAndUse([vs, fs], false, true, "valid program should link");
    var progGood2 = checkLinkAndUse([vs, fs2], false, true, "valid program #2 should link");
    var progBad1 = checkLinkAndUse([vs], false, false, "program with no fragment shader should fail to link");
    var progBad2 = checkLinkAndUse([fs], false, false, "program with no vertex shader should fail to link");
    var progBad3 = checkLinkAndUse([vsBad, fs], false, false, "program with bad vertex shader should fail to link");
    var progBad4 = checkLinkAndUse([vs, fsBad], false, false, "program with bad fragment shader should fail to link");
    var progBad5 = checkLinkAndUse([vsBad, fsBad], false, false, "program with bad shaders should fail to link");

    gl.useProgram(progGood1);
    glErrorShouldBe(gl, wgl.NO_ERROR, "using a valid program shouldn't generate a GL error");

    var vbuf = gl.createBuffer();
    gl.bindBuffer(wgl.ARRAY_BUFFER, vbuf);
    gl.bufferData(wgl.ARRAY_BUFFER,
        new Float32List.fromList([
          0.0, 0.0, 0.0, 1.0,
          1.0, 0.0, 0.0, 1.0,
          1.0, 1.0, 0.0, 1.0,
          0.0, 1.0, 0.0, 1.0]),
        wgl.STATIC_DRAW);
    gl.vertexAttribPointer(0, 4, wgl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(0);
    gl.vertexAttrib3f(1, 1.0, 0.0, 0.0);

    glErrorShouldBe(gl, wgl.NO_ERROR, "should be no errors at this point #2");

    gl.useProgram(progGood1);
    gl.drawArrays(wgl.TRIANGLES, 0, 3);
    glErrorShouldBe(gl, wgl.NO_ERROR, "drawing with a valid program shouldn't generate a GL error");

    gl.useProgram(progBad1);
    glErrorShouldBe(gl, wgl.INVALID_OPERATION, "using an invalid program should generate INVALID_OPERATION");
    gl.drawArrays(wgl.TRIANGLES, 0, 3);
    glErrorShouldBe(gl, wgl.NO_ERROR, "Try to use an invalid program should not change the current rendering state");

    gl.useProgram(progGood2);
    gl.drawArrays(wgl.TRIANGLES, 0, 3);
    glErrorShouldBe(gl, wgl.NO_ERROR, "drawing with a valid program shouldn't generate a GL error");
    gl.detachShader(progGood2, fs2);
    gl.attachShader(progGood2, fsBad);
    gl.linkProgram(progGood2);
    assertMsg(gl.getProgramParameter(progGood2, wgl.LINK_STATUS) == false,
        "linking should fail with in-use formerly good program, with new bad shader attached");

    gl.useProgram(progGood1);
    gl.drawArrays(wgl.TRIANGLES, 0, 4);
    glErrorShouldBe(gl, wgl.NO_ERROR, "drawing with a valid when last used program shouldn't generate a GL error");

    progGood1 = checkLinkAndUse([vs, fs], true, true, "delete shaders after attaching them and before linking program should not affect linkProgram");
    gl.useProgram(progGood1);
    gl.drawArrays(wgl.TRIANGLES, 0, 4);
    glErrorShouldBe(gl, wgl.NO_ERROR, "drawing with a valid when last used program shouldn't generate a GL error");

    /////// Check deleteProgram() and deleteShader() /////////////////////////////

    gl.useProgram(progGood1);
    gl.deleteProgram(progGood1);
    gl.drawArrays(wgl.TRIANGLES, 0, 4);
    glErrorShouldBe(gl, wgl.NO_ERROR, "delete the current program shouldn't change the current rendering state");

    gl.linkProgram(progGood1);
    glErrorShouldBe(gl, wgl.NO_ERROR, "The current program shouldn't be deleted");

    var fs3 = gl.createShader(wgl.FRAGMENT_SHADER);
    gl.shaderSource(fs3, "precision mediump float; varying vec4 vColor; void main() { gl_FragColor = vColor; }");
    gl.compileShader(fs3);

    assertMsg(gl.getShaderParameter(fs3, wgl.COMPILE_STATUS) == true,
        "good fragment shader should compile");

    gl.deleteShader(fs3);
    gl.compileShader(fs3);
    glErrorShouldBe(gl, wgl.INVALID_VALUE, "an unattached shader should be deleted immediately");

    fs3 = gl.createShader(wgl.FRAGMENT_SHADER);
    gl.shaderSource(fs3, "precision mediump float; varying vec4 vColor; void main() { gl_FragColor = vColor; }");
    gl.compileShader(fs3);

    assertMsg(gl.getShaderParameter(fs3, wgl.COMPILE_STATUS) == true,
        "good fragment shader should compile");

    gl.detachShader(progGood1, fs);
    gl.attachShader(progGood1, fs3);

    gl.deleteShader(fs3);
    gl.compileShader(fs3);
    assertMsg(gl.getShaderParameter(fs3, wgl.COMPILE_STATUS) == true,
        "an attached shader shouldn't be deleted");

    gl.useProgram(null);
    gl.linkProgram(progGood1);
    glErrorShouldBe(gl, wgl.INVALID_VALUE, "a delete-marked program should be deleted once it's no longer the current program");

    gl.compileShader(fs3);
    glErrorShouldBe(gl, wgl.INVALID_VALUE, "a delete-marked shader should be deleted once all its attachments are removed");
  }

  debug("");
  go();
}