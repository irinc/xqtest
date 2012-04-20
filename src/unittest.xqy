xquery version "1.0-ml";

module namespace unittest = "http://lds.org/code/shared/xqtest/unittest";

import module namespace iv = "http://lds.org/code/shared/xqtest/invoke" at "invoke-lib.xqy";

declare namespace xhtml = "http://www.w3.org/1999/xhtml";

declare option xdmp:mapping "false";

declare variable $DEFAULT_TESTS_DIR := "/test/tests/";

declare function test ( 
  $run as xdmp:function,
  $render as xdmp:function,
  $testsDir as xs:string?
) as element()* {
  let $debug := xdmp:trace("xqtest", "##################################### Executing XQuery Unit Test Suite #######################################")
  let $debug := xdmp:trace("xqtest", fn:concat("runner: ", $run, ", renderer: ", $render, ", testsDir: ", $testsDir))
  let $testsDir := unittest:getTestsDir($testsDir)
  let $testRoot := unittest:getTestsRoot($testsDir)
  let $testRelPath := unittest:getTestsDirRelativePath($testsDir)
  let $testFiles := unittest:makeRelativePaths($testRoot, $testRelPath, unittest:findTestModules($testRoot))
  let $log :=
    for $test in $testFiles
    return xdmp:trace("xqtest", fn:concat("Test file: ", $test))
  let $suite := xdmp:apply($run, $testFiles)
  return xdmp:apply($render, $suite)
};

declare function getTestsDir($testsDir as xs:string?) as xs:string {
  unittest:absoluteUriPath(
    if ($testsDir) then
      $testsDir
    else
      $DEFAULT_TESTS_DIR
  )
};

declare function getTestsRoot($testsDir as xs:string) as xs:string {
  let $debug := xdmp:trace("xqtest", fn:concat("Modules root: ", fn:replace(xdmp:modules-root(), "\\", "/")))
  let $testRoot := unittest:mergeUriPaths(xdmp:modules-root(), $testsDir)
  let $log := xdmp:trace("xqtest", fn:concat("Test directory: ", $testRoot))
  return $testRoot
};

declare function getTestsDirRelativePath($testsDir as xs:string) as xs:string {
  let $relPath := fn:substring($testsDir, 1)
  let $log := xdmp:trace("xqtest", fn:concat("Test directory under root: ", $relPath))
  return $relPath
};

declare function unittest:findTestModules($testRoot as xs:string?) as xs:string* {
  if (xdmp:modules-database() eq 0) then
    for $doc in xdmp:filesystem-directory($testRoot)/dir:entry
    return if ($doc/dir:type eq 'directory') then
      if (isHiddenDirectory($doc)) then
        ()
      else
        unittest:findTestModules($doc/dir:pathname)
    else if ($doc/dir:type eq 'file' and unittest:hasXQYextension($doc/dir:pathname/text())) then
      $doc/dir:pathname/text()
    else
      ()
  else
    iv:invoke("Modules", xdmp:function(xs:QName("unittest:findModulesInModulesDb")), $testRoot)
};

declare function findModulesInModulesDb($modRoot as xs:string) {
  cts:uri-match(fn:concat($modRoot, "*.xqy"))
};

declare function isHiddenDirectory($doc as element()) {
  fn:starts-with($doc/dir:filename, '.')
};

declare function unittest:hasXQYextension($file) {
  fn:tokenize($file, "\.")[fn:last()] eq "xqy"
};

declare function unittest:makeRelativePaths( 
  $testRoot as xs:string?,
  $testRunRelPath as xs:string?,
  $modules as xs:string*
) as xs:string* {
  for $module in $modules
  return unittest:mergeUriPaths($testRunRelPath, fn:substring-after($module, $testRoot))
};

declare function unittest:run($modules as xs:string*) {
  let $mods :=
    element modules {
      for $m in $modules
      return element module {
        attribute name { $m }
      }
    }
  return unittest:runInternal($mods)
};

declare function unittest:createSuite($modules as element(modules)) {
  element suite {
    for $m in $modules/module
    let $module := fn:string($m/@name)
    return element module {
      attribute moduleName { $module },
      let $text := unittest:getModuleFile($module)
      let $user := xdmp:get-current-user()
      let $ns := fn:substring-before(fn:substring-after($text, 'module namespace '), ';')
      let $pre := fn:normalize-space(fn:substring-before($ns, '='))
      let $after := fn:normalize-space(fn:substring-after($ns, '='))
      let $ns := fn:substring($after , 2, fn:string-length($after) - 2)
      return (
        attribute ns { $ns } ,
        for $test at $i in fn:tokenize($text,'\(:TEST:\)')
        return if($i > 1) then
          element test {
              attribute name { fn:normalize-space(fn:substring-before($test, '(')) }
          }
        else
          ()
      )
    }
  }
};

declare function unittest:runInternal($modules as element(modules)) {
  let $suite := unittest:createSuite($modules)
  let $temp := xdmp:trace("xqtest", xdmp:quote($suite))
  let $sstart := xdmp:elapsed-time()
  let $ret :=
  for $module in $suite/module
  let $moduleName := unittest:absoluteUriPath(fn:string($module/@moduleName))
  let $mstart := xdmp:elapsed-time()
  let $mret :=
    for $test in $module/test/@name
    let $debug := xdmp:trace("xqtest", fn:concat("Executing test [", $moduleName, ":", $test, "]"))
    return
      let $ns := $module/@ns
      let $tstart := xdmp:elapsed-time()
      let $tret :=
        try {
          let $r :=
            iv:timeInvoke(
              xdmp:database-name(xdmp:database()),
              xdmp:function(fn:QName($ns, $test), $moduleName)
            )
          let $innerTime := $r[1]
          let $result := $r[2]
          return (
            attribute result { if ($result) then 'failed' else 'success' },
            attribute innerTime { $innerTime },
            if ($result) then
              element message { $result }
            else ()
          )
        } catch($x) {
          attribute result { 'failed' },
          attribute innerTime { 'PT0S' },
          element error { $x }
        }
      let $tend := xdmp:elapsed-time()
      return element test {
        attribute testName { $test },
        attribute testElapsed { $tend - $tstart },
        $tret
      }
    let $mend := xdmp:elapsed-time()
    return element module {
      attribute moduleName { $moduleName },
      attribute moduleElapsed { $mend - $mstart },
      $mret
    }
  let $send:= xdmp:elapsed-time()
  return element suite { attribute suiteElapsed { $send - $sstart }, $ret }
};

declare function unittest:seconds($t)  as xs:double {
  unittest:calculateSeconds($t)
};

declare function unittest:ms($t) as xs:double {
  unittest:calculateSeconds($t) * 1000
};

declare function unittest:calculateSeconds($t) as xs:double {
  (:
      TODO Update this by declaring types for variables and fixing calculation
      when the "minutes" actually exist
  :)
  let $seconds := fn:substring-after(fn:substring-before($t, 'S'), 'PT')
  let $minutes := fn:substring-after(fn:substring-before($t, 'M'), 'PT')
  return xs:double(
    if ($minutes) then
      ($minutes * 60) + $seconds
    else
      $seconds
  )
};

declare function unittest:getModuleFile($files as xs:string*) {
  unittest:getModuleFile($files, fn:false())
};

declare function unittest:getModuleFile($files as xs:string*, $inModulesDB as xs:boolean) {
  let $doc := ()
  let $modulesRoot := xdmp:modules-root()
  let $compute :=
    if (fn:not($inModulesDB)) then
      let $moddb := xdmp:modules-database()
      return if ($moddb eq 0) then
        for $file in $files
        let $filename := unittest:mergeUriPaths($modulesRoot, $file)
        let $debug := xdmp:trace("xqtest", fn:concat("Test file full path: ", $filename))
        return if ($doc) then
          $doc
        else
          xdmp:set($doc, xdmp:document-get($filename))
      else
        xdmp:set($doc, iv:invoke(xdmp:database-name($moddb), xdmp:function(xs:QName("unittest:getModuleFile")), $files, fn:true()))
    else
      for $file in $files
      let $filename := unittest:mergeUriPaths($modulesRoot, $file)
      let $debug := xdmp:trace("xqtest", fn:concat("Test file full path: ", $filename))
      return if($doc) then
        $doc
      else
        xdmp:set($doc, fn:doc($filename) )
  return $doc
};


declare private function unittest:mergeUriPaths($p1 as xs:string?, $p2 as xs:string?) as xs:string? {
  fn:replace(fn:replace(fn:concat($p1, $p2), "\\", "/"), "//", "/")
};

declare private function unittest:absoluteUriPath($path as xs:string?) as xs:string? {
  let $path :=
    if (fn:ends-with($path, "/") or fn:ends-with($path, ".xqy")) then
      $path
    else
      fn:concat($path, "/")
  let $path :=
    if (fn:starts-with($path, "/")) then
      $path
    else
      fn:concat("/", $path)
  return fn:replace(fn:replace($path, "\\", "/"), "//", "/")
};

(: @see http://www.xqueryfunctions.com/xq/functx_substring-before-last.html :)
declare private function substring-before-last($arg as xs:string?, $delim as xs:string) as xs:string {
  if (fn:matches($arg, escape-for-regex($delim))) then
    fn:replace($arg, fn:concat('^(.*)', escape-for-regex($delim), '.*'), '$1')
  else
    ''
};

(: @see http://www.xqueryfunctions.com/xq/functx_escape-for-regex.html :)
declare private function escape-for-regex($arg as xs:string?) as xs:string {
  fn:replace($arg, '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))', '\\$1')
} ;