xquery version "1.0-ml";

module namespace syntax = "http://lds.org/code/shared/xqtest/tests/syntax";

import module namespace assert = "http://lds.org/code/shared/xqtest/assert" at "../../assert.xqy";
import module namespace html = "http://lds.org/code/shared/xqtest/html" at "../../html.xqy";
import module namespace iv = "http://lds.org/code/shared/xqtest/invoke" at "../../invoke-lib.xqy";
import module namespace testng = "http://lds.org/code/shared/xqtest/testng" at "../../testng.xqy";
import module namespace unittest = "http://lds.org/code/shared/xqtest/unittest" at "../../unittest.xqy";

declare option xdmp:mapping "false";

declare function (:TEST:) syntax:validate() as empty-sequence() {
  ()
};