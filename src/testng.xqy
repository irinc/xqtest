xquery version "1.0-ml";

module namespace testng = "http://lds.org/code/shared/xqtest/testng";

import module namespace unittest = "http://lds.org/code/shared/xqtest/unittest" at "unittest.xqy";

declare option xdmp:mapping "false";

declare function testng:test() {
  unittest:test(xdmp:function(xs:QName("unittest:run")), xdmp:function(xs:QName("testng:render")), ())
};

declare function testng:test($testDir as xs:string?) {
    unittest:test(xdmp:function(xs:QName("unittest:run")), xdmp:function(xs:QName("testng:render")), $testDir)
};

declare function testng:tests($modules as xs:string*) as element() {
  xdmp:trace("xqtest", "##################################### Executing XQuery Unit Test Suite #######################################"),
  testng:render(unittest:run($modules))
};

declare function testng:render($suite as element()*) as element() {
	element testng-results {
    element reporter-output {},
    element suite {
      attribute name { 'XQuery Unit Tests' },
      for $m in $suite/module
      return (
        element groups {},
        element test {
          attribute name { $m/@moduleName },
          element class {
            attribute name { 'Module Tests' },
            for $t in $m/test
            return element test-method {
              attribute status { if ($t/@result eq 'success') then 'PASS' else 'FAIL' },
              attribute signature { fn:concat($t/@testName, '()') },
              attribute name { $t/@testName },
              attribute is-config { 'true' },
              attribute duration-ms { unittest:ms($t/@innerTime) },
              $t/message,
              $t/error
            }
          }
        }
      )
    }
  }
};

