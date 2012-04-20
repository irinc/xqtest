xquery version "1.0-ml";

module namespace asserts = "http://lds.org/code/shared/xqtest/tests/asserts";

import module namespace assert = "http://lds.org/code/shared/xqtest/assert"
    at "../../assert.xqy";

declare option xdmp:mapping "false";

declare function (:TEST:) asserts:notEquals() as item()* {
  if (assert:notEqual(1, 2)) then
    fn:concat("Not equal assertion should pass: ", assert:notEqual(1, 2))
  else
    ()
  ,
  if (assert:notEqual(1, 1)) then
    ()
  else
    fn:concat("Not equal assertion should fail: ", assert:notEqual(1, 1))
};

declare function (:TEST:) asserts:equals() as item()* {
  if (assert:equal(1, 1)) then
    fn:concat("Equal assertion should pass: ", assert:equal(1, 1))
  else
    ()
  ,
  if (assert:equal(1, 2)) then
    ()
  else
    fn:concat("Equal assertion should fail: ", assert:equal(1, 2))
};

declare function (:TEST:) asserts:empty() as item()* {
  if (assert:empty(())) then
    fn:concat("Empty assertion should pass: ", assert:empty(()))
  else
    ()
  ,
  if (assert:empty(1)) then
    ()
  else
    fn:concat("Empty assertion should fail: ", assert:empty(1))
};

declare function (:TEST:) asserts:exists() as item()* {
  if (assert:exists(1)) then
    fn:concat("Exists assertion should pass: ", assert:exists(1))
  else
    ()
  ,
  if (assert:exists(())) then
    ()
  else
    fn:concat("Exists assertion should fail: ", assert:exists(()))
};

declare function (:TEST:) asserts:true() as item()* {
  if (assert:true(1 eq 1)) then
    fn:concat("True assertion should pass: ", assert:true(1 eq 1))
  else
    ()
  ,
  if (assert:true(1 eq 2)) then
    ()
  else
    fn:concat("True assertion should fail: ", assert:true(1 eq 2))
};

declare function (:TEST:) asserts:error() as item()* {
  if (assert:error(xdmp:function(xs:QName("asserts:throwError")), (), "test")) then
    fn:concat("Error assertion should pass: ", assert:error(xdmp:function(xs:QName("asserts:throwError")), (), "test"))
  else
    ()
  ,
  if (assert:error(xdmp:function(xs:QName("asserts:noError")), (), "test")) then
    ()
  else
    fn:concat("Error assertion should fail: ", assert:error(xdmp:function(xs:QName("asserts:noError")), (), "test"))
  ,
  if (assert:error(xdmp:function(xs:QName("asserts:noError")), "hi", "test")) then
    ()
  else
    fn:concat("Error assertion should fail on parameter function: ", assert:error(xdmp:function(xs:QName("asserts:noError")), "hi", "test"))
  ,
  if (assert:error(xdmp:function(xs:QName("asserts:noError")), (), "test") ne "test") then
    fn:concat("Failed assertion doesn't use custom message: ", assert:error(xdmp:function(xs:QName("asserts:noError")), (), "test"))
  else
    ()
};

declare function asserts:noError() as item()* {
  ()
};

declare function asserts:noError($param as item()*) as item()* {
  ()
};

declare function asserts:throwError() as item()* {
  fn:error()
};