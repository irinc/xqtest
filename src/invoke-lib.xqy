xquery version "1.0-ml";

module namespace iv = "http://lds.org/code/shared/xqtest/invoke";

declare variable $invokeLocation := "invoke.xqy";
declare variable $null := element iv:null {};

declare option xdmp:mapping "false";

(: TODO:DJS we cannot currently pass sequences as paramteters to invoke! Fix this! :)
(: TODO:DJS This doesn't pass loggin parameters like the old one did! Fix this! :)

(:~
	Invoke into a database and call some function in some module passing 0 to 9 parameters.
	Example call:
		iv:invoke("DatabaseName",xdmp:function(xs:QName('namespace:functionName'),'/some/accessible/path/module.xqy'), $param1, $param2)
		
	@param $db - The name of the database into which to invoke 
	@param $fn - The xdmp:function describing the module and function to be invoked 
	@param $p1 to $p9 (optional) parameters to make the call to the function being invoked. 

	@returns whatever the invoked function returns 
~:)
declare function iv:invoke($db as xs:string,$fn as xdmp:function) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"),   0,
      xs:QName("p1"), 0,
      xs:QName("p2"), 0,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 1,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), 0,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 2,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 3,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 4,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 5,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 6,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 7,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 8,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), if(fn:exists($p8)) then $p8 else $null,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:invoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:false(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 8,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), if(fn:exists($p8)) then $p8 else $null,
      xs:QName("p9"), if(fn:exists($p9)) then $p9 else $null
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

(:==========================================================================================:)
(:~
	Invoke into a database and call some function in some module passing 0 to 9 parameters.
	Example call:
		iv:timeInvoke("DatabaseName",xdmp:function(xs:QName('namespace:functionName'),'/some/accessible/path/module.xqy'), $param1, $param2)
		
	@param $db - The name of the database into which to invoke 
	@param $fn - The xdmp:function describing the module and function to be invoked 
	@param $p1 to $p9 (optional) parameters to make the call to the function being invoked. 

	@returns sequence of the elapsed time duration and whatever the invoked function returns 
~:)
declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"),   0,
      xs:QName("p1"), 0,
      xs:QName("p2"), 0,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 1,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), 0,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 2,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), 0,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 3,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), 0,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 4,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), 0,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 5,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), 0,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 6,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), 0,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 7,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), 0,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 8,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), if(fn:exists($p8)) then $p8 else $null,
      xs:QName("p9"), 0
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

declare function iv:timeInvoke($db as xs:string,$fn as xdmp:function,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9) {
	xdmp:invoke($invokeLocation,
    (
      xs:QName("time"), fn:true(),
      xs:QName("fn"), $fn,
      xs:QName("c"), 8,
      xs:QName("p1"), if(fn:exists($p1)) then $p1 else $null,
      xs:QName("p2"), if(fn:exists($p2)) then $p2 else $null,
      xs:QName("p3"), if(fn:exists($p3)) then $p3 else $null,
      xs:QName("p4"), if(fn:exists($p4)) then $p4 else $null,
      xs:QName("p5"), if(fn:exists($p5)) then $p5 else $null,
      xs:QName("p6"), if(fn:exists($p6)) then $p6 else $null,
      xs:QName("p7"), if(fn:exists($p7)) then $p7 else $null,
      xs:QName("p8"), if(fn:exists($p8)) then $p8 else $null,
      xs:QName("p9"), if(fn:exists($p9)) then $p9 else $null
    ),
    <options xmlns="xdmp:eval">
      <database>{ xdmp:database($db) }</database>
      <isolation>different-transaction</isolation>
    </options>
  )
};

