xquery version "1.0-ml";

module namespace assert = "http://lds.org/code/shared/xqtest/assert";

import module namespace iv = "http://lds.org/code/shared/xqtest/invoke" at "invoke-lib.xqy";

declare option xdmp:mapping "false";

declare function assert:notEqual($actual as item()*, $expected as item()*) as xs:string? {
  assert:notEqual($actual, $expected, "")
};

declare function assert:notEqual($actual as item()*, $expected as item()*, $msg as xs:string?) as xs:string? {
  if (assert:equal($actual, $expected)) then
    ()
  else
    fn:concat($msg, " - expected: ", xdmp:quote($expected), ", actual: ", xdmp:quote($actual))
};

declare function assert:equal($actual as item()*, $expected as item()*) as xs:string? {
  assert:equal($actual, $expected, "")
};

declare function assert:equal($actual as item()*, $expected as item()*, $msg as xs:string?) as xs:string? {
  if (fn:deep-equal($actual, $expected)) then
    ()
  else
    fn:concat($msg, " - expected: ", xdmp:quote($expected), ", actual: ", xdmp:quote($actual))
};

declare function assert:empty($val as item()*) as xs:string? {
  assert:empty($val, "")
};

declare function assert:empty($val as item()*, $msg as xs:string?) as xs:string? {
  if (fn:empty($val)) then
    ()
  else
    fn:concat($msg, " - expected: (), actual: ", $val[1], "...")
};

declare function exists($val as item()*) as xs:string? {
  assert:exists($val, "")
};

declare function assert:exists($val as item()*, $msg as xs:string?) as xs:string?
{
  if (fn:exists($val)) then
    ()
  else
    fn:concat($msg, " - expected: ", $val[1], "... actual: ()")
};

(:~
  Asserts if the specified function will throw an error, allowing
  a custom message if it doesn't.

  @param $function A function value of the function you want to
      test
  @param $params The parameters to pass to the function
  @param $msg The message to include if the function does not
      throw an error
  @return nothing if the function throws an error, specified message
      if it doesn't
:)
declare function assert:error($func as xdmp:function?, $params as item()*, $msg as xs:string?) as xs:string? {
  try {
    let $noop :=
      if ($params) then
        xdmp:apply($func, $params)
      else
        xdmp:apply($func)
    return $msg
  } catch ($e) {
    xdmp:log($e),
    ()
  }
};

declare function assert:true($assertion as item()*, $msg as xs:string?) as xs:string? {
  if ($assertion eq fn:true()) then
    ()
  else
    $msg
};

declare function assert:true($assertion as item()*) as xs:string? {
  assert:true($assertion, "Assertion Failed!")
};

declare function assert:false($assertion as item()*, $msg as xs:string?) as xs:string? {
  if ($assertion eq fn:false()) then
    ()
  else
    $msg
};

declare function assert:false($assertion as item()*) as xs:string? {
  assert:false($assertion, "Assertion Failed!")
};

declare function assert:uriExists($db as xs:string?, $uri as xs:string?) as xs:string? {
  if (iv:invoke($db, xdmp:function(xs:QName("cts:uri-match")), $uri)) then
    ()
  else
    fn:concat($uri, " doesn't exist")
};

declare function assert:uriNotExists($db as xs:string?, $uri as xs:string?) as xs:string? {
  if (iv:invoke($db, xdmp:function(xs:QName("cts:uri-match")), $uri)) then
    fn:concat($uri, " exists when it shouldn't")
  else
    ()
};

(:~
  Asserts if the specified file exists on the file system.
  NOTE: MarkLogic 5.0+ only

  @param $file The path of the file to check
  @return nothing if the the file exists, error message if it doesn't
:)
declare function assert:fileExists($file as xs:string?) as xs:string? {
  if (xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-exists")), $file)) then
    ()
  else
    fn:concat($file, " doesn't exist")
};

(:~
  Asserts if the specified file does not exist on the file system.
  NOTE: MarkLogic 5.0+ only

  @param $file The path of the file to check
  @return nothing if the the file doesn't exist, error message if it does
:)
declare function assert:fileNotExists($file as xs:string?) as xs:string? {
  if (xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-exists")), $file)) then
    fn:concat($file, " exists when it shouldn't")
  else
    ()
};

(:~
  Asserts if the specified file exists on the file system and is the size
  specified.
  NOTE: MarkLogic 5.0+ only

  @param $file The path of the file to check
  @param $size The expected size of the file
  @return nothing if the the file exists and is the correct size, error message
  if it doesn't
:)
declare function assert:fileSize($file as xs:string?, $size as xs:unsignedInt) as xs:string? {
  let $exists as xs:string? := assert:fileExists($file)
  return if (fn:exists($exists)) then
    $exists
  else if (xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-length")), $file) ne $size) then
    fn:concat($file, " isn't the correct size - expected: ", $size, " bytes, actual: ", xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-length")), $file), " bytes")
  else ()
};

(:~
  Asserts if the specified file exists on the file system and is NOT the size
  specified.
  NOTE: MarkLogic 5.0+ only

  @param $file The path of the file to check
  @param $size The expected size of the file
  @return nothing if the the file exists and is the correct size, error message
  if it doesn't
:)
declare function assert:fileNotSize($file as xs:string?, $size as xs:unsignedInt) as xs:string? {
  let $exists as xs:string? := assert:fileExists($file)
  return if (fn:exists($exists)) then
    $exists
  else if (xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-length")), $file) eq $size) then
    fn:concat($file, " was equal to the specified size - specified: ", $size, " bytes, actual: ", xdmp:apply(xdmp:function(xs:QName("xdmp:filesystem-file-length")), $file), " bytes")
  else
    ()
};