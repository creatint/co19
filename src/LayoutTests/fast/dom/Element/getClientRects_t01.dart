/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description 
 */
import "dart:html";
import "../../../../Utils/expect.dart";
import "../../../testcommon.dart";

main() {
  var style = new Element.html('''
    <style>
        #base {
            width: 300px;
            height: 100px;
        }

        #border {
            border: 10px solid #999;
            width: 300px;
            height: 100px;
        }

        #margin {
            margin: 10px;
            width: 300px;
            height: 100px;
        }

        #transform {
            -webkit-transform: translateX(50px) rotate(45deg);
            width: 100px;
            height: 100px;
        }

        #columns {
            -webkit-column-count: 3;
            width: 300px;
        }

        #inline {
            display: inline;
        }

        #outer {
            width: 100px;
            height: 100px;
        }

        #inner {
            width: 200px;
            height: 200px;
        }

        table {
            width: 300px;
        }

        img {
            width: 100px;
            height: 100px;
        }

        .testBox {
            background-color: green;
        }

        #testArea {
            width: 300px;
        }

        .bbox {
            position:absolute;
            outline: 5px solid rgba(255, 0, 0, .75);
        }

        #console {
            position:absolute;
            left: 500px;
        }
    </style>
    ''', treeSanitizer: new NullTreeSanitizer());
  document.head.append(style);
 
  document.body.setInnerHtml('''
    <div id="console"></div>
    <div id="testArea">

    <p>1. Base</p>                  <div id="base" class="testBox"></div>
    <p>2. Border</p>                <div id="border" class="testBox"></div>
    <p>3. Margin</p>                <div id="margin" class="testBox"></div>
    <p>4. Transform</p>             <div id="transform" class="testBox"></div>
    <p>5. Column</p>                <div id="columns" class="testBox">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
    <p>6. In a column</p>           <div id="columns">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<span id="in-columns" class="testBox knownFailure">In columns</span> Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
    <p>7. Inline</p>                <div id="inline" class="testBox">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
    <p>8. Table</p>                 <table class="testBox"><tr><td>table data</td><td>table data</td></tr><tr><td>table data</td><td>table data</td></tr></table>
    <p>9. Table with Caption</p>    <table class="testBox"><caption>caption</caption><tr><td>table data</td><td>table data</td></tr><tr><td>table data</td><td>table data</td></tr></table>
    <p>10. Table Row</p>            <table><tr class="testBox"><td>table data</td><td>table data</td></tr><tr><td>table data</td><td>table data</td></tr></table>
    <p>11. Table Cell</p>           <table><tr><td class="testBox">table data</td><td>table data</td></tr><tr><td>table data</td><td>table data</td></tr></table>
    <p>12. Big block in little</p>  <div id="outer" class="testBox"><div id="inner"></div></div>
    <p>13. Replaced in inline</p>   <span class="testBox">Lorem<img>ipsum</span>
    <p>14. Block in inline</p>      <span class="testBox">Lorem<div id="inner"></div>ipsum</span>
    <p>15. Float in inline</p>      <span class="testBox"><img style="float:right"></span>

    </div>
    ''', treeSanitizer: new NullTreeSanitizer());

  testClientRects(rects, expectedNumberOfRects)
  {
    Expect.equals(expectedNumberOfRects, rects.length);
  }

  addBBoxOverClientRect(rect)
  {
    var bbox = document.createElement('div');
    bbox.className = "bbox";
    var style = "";
    style += "left: "   + rect.left.toString() + "px;";
    style += "top: "    + rect.top.toString() + "px;";
    style += "width: "  + (rect.right - rect.left).toString() + "px;";
    style += "height: " + (rect.bottom - rect.top).toString() + "px;";
    bbox.setAttribute("style", style);
    document.documentElement.append(bbox);
  }

  addBBoxOverClientRects(rects)
  {
    for (var i = 0; i < rects.length; ++i)
      addBBoxOverClientRect(rects[i]);
  }

  var expectedResults = [
    1,
    1,
    1,
    1,
    1,
    1,
    10,
    1,
    2,
    1,
    1,
    1,
    1,
    3,
    1
  ];

  test(number, element)
  {
    var name = "Client bounding rects for #$number";

    if (element.className.contains("knownFailure")) {
      // Known failure. Skipping
      return;
    }

    try {
      var boundingRects = element.getClientRects();
      addBBoxOverClientRects(boundingRects);
      testClientRects(boundingRects, expectedResults[number - 1]);
    } catch (e) {
      Expect.fail('$name $e');
    }
  }

  var tests = document.getElementsByClassName("testBox");
  for (var i = 0; i < tests.length; ++i)
    test(i + 1, tests[i]);
}
