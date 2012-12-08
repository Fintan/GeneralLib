package tests;
import fboyle.geom.Vector2;
import utest.Assert;

class TestVector2 {
	
	public function new() {
		
	}
	
	function testNewVector() {
		var vec:Vector2 = new Vector2(10, 20);
		Assert.equals(vec.toString(), '{10, 20}', "expecting 10,20 but got "+vec.toString());
	}
	
	function testNormaliseLength() {
		var vec:Vector2 = new Vector2(0, 10);
		vec.normalize(20);
		Assert.equals(vec.toString(), '{0, 20}', "expecting 0,20 but got "+vec.toString());
	}
	
	function testGetAngle() {
		var angle = new Vector2(0, 10).getAngle();
		Assert.equals(angle, Math.PI/2, "expecting "+(Math.PI/2)+" but got "+angle);
	}
	
	function testSetAngle() {
		var vec:Vector2 = new Vector2(10, 20);
		vec.setAngle(Math.PI);
		Assert.equals(vec.getAngle(), Math.PI, "expecting Math.PI but got "+vec.getAngle());
	}
	
	function testSetAngle2() {
		var vec:Vector2 = new Vector2(10, 20);
		vec.setAngle(92 * Math.PI/180);
		Assert.equals(Math.round(vec.getAngle()* 180/Math.PI), 92, "expecting 92 but got "+Math.round(vec.getAngle()* 180/Math.PI));
	}
	
	function testMagnitude() {
		
		var v = new Vector2(3, 4);
		Assert.equals(v.getLength(), 5, "expecting "+5+" but got "+v.getLength());
	}
	
	function testDistance() {
		
		var v1 = new Vector2(10, 20);
		var v2 = new Vector2(60, 80); 
		var d = Vector2.dist(v1, v2);
		Assert.equals(Math.round(d), 78, "expecting "+78+ " but got "+ Math.round(d));
		
	}
	
	function testAdd() {
		
		var v1 = new Vector2(40, 20);
		var v2 = new Vector2(25, 50); 
		v2.add(v1);

		Assert.equals(v2.x, 65);
		Assert.equals(v2.y, 70);
		
	}
	
	function testDivide() {
		
		var v1 = new Vector2(40, 20);
		var v2 = new Vector2(25, 50); 
		v2.divide(v1);

		Assert.equals(v2.x, 0.625);
		Assert.equals(v2.y, 2.5);
	}
	
	function testMultiply() {
		
		var v1 = new Vector2(15, 80.5);
		var v2 = new Vector2(20, 15); 

		v2.multiply(v1);

		Assert.equals(v2.x, 300.0);
		Assert.equals(v2.y, 1207.5);
	}
	
	/*
	function testAngleBetween() {
		
		var v1 = new Vector2(10, 20);
		var v2 = new Vector2(60, 80); 
		//var a = v1.degreesTo(v2);
		var a = Vector2.angleBetween(v1, v2);
		Assert.equals(a * 180.0/Math.PI, 49, "expecting " + 49 + " but got " + (a *180.0/Math.PI));
	}
	*/
	
	
	function testRotate() {
		var vec:Vector2 = new Vector2(2, 3);
		vec.rotate(180);
		Assert.equals(vec.round().toString(), '{-2, -3}', "expecting -2,-3 but got "+vec.round().toString());
	}
	
}