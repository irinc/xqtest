xquery version "1.0-ml";

declare namespace iv = "http://lds.org/code/shared/xqtest/invoke";

declare variable $fn external;
declare variable $c external;
declare variable $p1 external;
declare variable $p2 external;
declare variable $p3 external;
declare variable $p4 external;
declare variable $p5 external;
declare variable $p6 external;
declare variable $p7 external;
declare variable $p8 external;
declare variable $p9 external;
declare variable $time external;

declare option xdmp:update "true";

let $p1 := typeswitch($p1) case element(iv:null) return () default return $p1
let $p2 := typeswitch($p2) case element(iv:null) return () default return $p2
let $p3 := typeswitch($p3) case element(iv:null) return () default return $p3
let $p4 := typeswitch($p4) case element(iv:null) return () default return $p4
let $p5 := typeswitch($p5) case element(iv:null) return () default return $p5
let $p6 := typeswitch($p6) case element(iv:null) return () default return $p6
let $p7 := typeswitch($p7) case element(iv:null) return () default return $p7
let $p8 := typeswitch($p8) case element(iv:null) return () default return $p8
let $p9 := typeswitch($p9) case element(iv:null) return () default return $p9
let $start := xdmp:elapsed-time()
return
	if ($time) then
		let $start := xdmp:elapsed-time()
		let $result := typeswitch (element {concat("c",string($c))}{})
			case element(c1) return xdmp:apply($fn, $p1)
			case element(c2) return xdmp:apply($fn, $p1, $p2)
			case element(c3) return xdmp:apply($fn, $p1, $p2, $p3)
			case element(c4) return xdmp:apply($fn, $p1, $p2, $p3, $p4)
			case element(c5) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5)
			case element(c6) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6)
			case element(c7) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7)
			case element(c8) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7, $p8)
			case element(c9) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7, $p8, $p9)
			default return xdmp:apply($fn)
		let $time :=  xdmp:elapsed-time() - $start
		return ($time,$result)
	else
		typeswitch (element {concat("c",string($c))}{})
			case element(c1) return xdmp:apply($fn, $p1)
			case element(c2) return xdmp:apply($fn, $p1, $p2)
			case element(c3) return xdmp:apply($fn, $p1, $p2, $p3)
			case element(c4) return xdmp:apply($fn, $p1, $p2, $p3, $p4)
			case element(c5) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5)
			case element(c6) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6)
			case element(c7) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7)
			case element(c8) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7, $p8)
			case element(c9) return xdmp:apply($fn, $p1, $p2, $p3, $p4, $p5, $p6, $p7, $p8, $p9)
			default return xdmp:apply($fn)

