xquery version "1.0-ml";

module namespace content = "http://lds.org/code/shared/xqtest/content";

import module namespace inv = "http://lds.org/code/shared/xqtest/invoke" at "invoke-lib.xqy";

declare function content:insertXML($filePath as xs:string, $xml as node()*)  as item()* {
  content:insertXML(xdmp:database-name(xdmp:database()), $filePath, $xml)
};

declare function content:insertXML($db as xs:string, $filePath as xs:string, $xml as node()*)  as item()* {
  inv:invoke($db, xdmp:function(xs:QName("xdmp:document-insert")), $filePath, $xml)
};

declare function delete($path as xs:string) as item()* {
   delete(xdmp:database-name(xdmp:database()), $path)
};

declare function content:delete($db as xs:string, $path as xs:string) as item()* {
  inv:invoke($db, xdmp:function(xs:QName("xdmp:document-delete")), $path)
};

declare function content:deleteDirectory($path as xs:string) as item()* {
  content:deleteDirectory(xdmp:database-name(xdmp:database()), $path)
};

declare function content:deleteDirectory($db as xs:string, $path as xs:string) as item()* {
  inv:invoke($db, xdmp:function(xs:QName("xdmp:directory-delete")), $path)
};

declare function content:getFile($path as xs:string?) as element()* {
  let $modulesDb := xdmp:modules-database()
  return if ($modulesDb eq 0) then
    xdmp:unquote(xdmp:filesystem-file(fn:concat(xdmp:modules-root(), $path)))/element()
  else
    inv:invoke(
      xdmp:database-name($modulesDb),
      xdmp:function(xs:QName("fn:doc")), fn:concat(xdmp:modules-root(), $path)
    )/element()
};
