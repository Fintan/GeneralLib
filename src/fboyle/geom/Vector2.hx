// Ported FVector2 class from Frocessing and also added some methods from
// Shane McCartney's org.animation.geom.Vector22D
// --------------------------------------------------------------------------
// Project Frocessing
// ActionScript 3.0 drawing library like Processing.
// --------------------------------------------------------------------------
//
// This library is based on Processing.(http://processing.org)
// Copyright (c) 2004-08 Ben Fry and Casey Reas
// Copyright (c) 2001-04 Massachusetts Institute of Technology
// 
// Frocessing drawing library
// Copyright (C) 2008-10  TAKANAWA Tomoaki (http://nutsu.com) and
//					   	  Spark project (www.libspark.org)
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//
// contact : face(at)nutsu.com
//
package fboyle.geom;

class Vector2 {
	
	public var x:Float;
	public var y:Float;
	
	public static var ZERO = new Vector2(0, 0);

	public function new( x:Float=0, y:Float=0 ) {
		this.x = x;
		this.y = y;
	}
		
	public function round() {
		return new Vector2(Std.int(x), Std.int(y));
	}
	
	/**
	*  length of Vector2
	*  Calculate the magnitude of the Vector2
	*/
	inline public function getLength():Float {
		
		return Math.sqrt(x*x + y*y);
	}
	
	inline public function getLengthSquared():Float {
		
		return x*x + y*y;
	}
	
	/**
	* normalized Vector2 copy;
	*/
	public function normal():Vector2 {
		
		var v:Vector2 = clone();
		v.normalize(1.0);
		return v;
	}
	
	/**
	* clone
	*/
	inline public function clone():Vector2 {
		
		return new Vector2(x,y);
	}
	
	/**
	* Adds x, y components to a Vector2, one Vector2 to another, or two independent Vector2s
	*/
	inline public function add(v:Vector2):Vector2 {
		
		x += v.x;
		y += v.y;
		return this;
	}
	
	inline public function addScalar(x:Float=0, y:Float=0) {
		
		x += x;
		y += y;
		return this;
		
	}
	
	inline public function setScalar(x:Float=0, y:Float=0) {
		
		this.x = x;
		this.y = y;
		
	}
	
	
	/** 
	 * Returns the value of the given Vector2 added to this.
	 */
	inline public function addNew(v:Vector2):Vector2 {
		
		return new Vector2(x + v.x, y + v.y);
	}
	
	/**
	* Subtract x, y, and z components from a Vector2, one Vector2 from another, or two independent Vector2s
	*/
	inline public function subtract( v:Vector2 ):Vector2 {
		
		x -= v.x;
		y -= v.y;
		return this;
	}
	
	/**
	 * Returns the value of the given Vector2 subtracted from this.
	 */
	inline public function subtractNew(v:Vector2):Vector2 {
		
		return new Vector2(x - v.x, y - v.y);
	}
	
	/**
	* Multiply a Vector2 by a scalar or one Vector2 by another
	*/
	inline public function multiply( v:Vector2 ):Vector2 {
		
		x *= v.x;
		y *= v.y;
		return this;
	}
	
	/**
	* Multiply a Vector2 by a scalar or one Vector2 by another
	*/
	inline public function multiplyScalar( value:Float ):Vector2 {
		
		x *= value;
		y *= value;
		return this;
	}
	
	/**
	 * Returns a copy of this Vector2 scaled the given value.
	 */
	inline public function multiplyNew(value:Float):Vector2 {
		
		return new Vector2(x * value, y * value);
	}
	
	/**
	* Divide a Vector2 by another Vector2
	*/
	inline public function divide( v:Vector2 ):Vector2 {
		
		x /= v.x;
		y /= v.y;
		
		return this;
	}
	
	/**
	* Divide a Vector2 by a scalar
	*/
	inline public function divideScalar( value:Float ):Vector2 {
		
		x /= value;
		y /= value;
		
		return this;
	}
	
	public function perpendicular():Vector2 {
		
		var tmpX:Int = Std.int(x);
		x = -y;
		y = tmpX;
		
		return this;
	}
	
	/**
	 * Zero all the components of the Vector2.
	 */
	public function clear():Vector2 { 
		
		x = y = 0;
		
		return this;
	}
	
	/**
	 * Flips all the components of the Vector2.
	 */
	public function invert():Vector2 {
		
		x = -x;
		y = -y;
		
		return this;
	}
	
	/**
	* Normalize
	* @param	target length
	*/
	public function normalize(len:Float = 1.0):Void {
		
		var s:Float = len / getLength();
		x *= s;
		y *= s;
	}
	
	/**
	*  Calculate angle between Vector2s (in Radians)
	**/  
	inline public function angleTo(vec:Vector2):Float {
		return Math.atan2(y - vec.y, x - vec.x);
	}
	
	/**
	*  Calculate angle between Vector2s (in Degrees)
	**/
	inline public function degreesTo(Vector2:Vector2):Float {
		return angleTo(Vector2) * 180 / Math.PI;
	}
	
	public function angle():Float {
	    
		var angle = Math.atan2(y, x);

	    if (angle < 0) {
	    	angle += Math.PI * 2;
	    }

	    return angle;
	}
	
	public function getAngle():Float {
		return Math.atan2(y, x);
	}
	
	public function setAngle(radians:Float):Void {

		x = getLength() * Math.cos(radians);
		y = getLength() * Math.sin(radians);
	}
	
	public function rotateInRadians(radians:Float):Void {

		var ca:Float = Math.cos(radians);
		var sa:Float = Math.sin(radians);

		x = x * ca - y * sa;
		y = y * ca + x * sa;
	}
	
	public function rotate(degrees:Float):Void {
		
		rotateInRadians(degrees * Math.PI / 180);
		
	}
	
	/**
	* Compare x, y, and z components of (this) Vector2 to another Vector2 (v)
	*/
	inline public function equals( v:Vector2 ):Bool {
		
		return ( x==v.x && y==v.y );
	}
	
	/**
	*  Don't allow magnitude of the Vector2 to exceed a max value
	**/  
	public function limit(maxVal:Float) {
		
		if (this.getLength() >= maxVal) {
			this.normalize();
		    this.multiplyScalar(maxVal);
		}
		
	}
	
	/**
	*  Calculate the angle of rotation for this Vector2 (only 2D Vector2s)
	*  
	*  (the same result as getAngle() from what I can see)
	*  
	**/  
	public function heading2D():Float {
		return (-Math.atan2(-this.y, this.x));
	}
	
	/**
	 * toString
	 */
	public function toString():String {
		
		return "{" + x + ", " + y + "}";
	}
	
	#if flash
	inline public function render(graphics:flash.display.Graphics) {
		
		graphics.drawCircle(x, y, 5);
		graphics.moveTo(-5 + x, y);
		graphics.lineTo(x + 5, y);
		graphics.moveTo(x, y - 5);
		graphics.lineTo(x, y + 5);
		
	}
	#end
		//--------------------------------------------------------------------------------------------------- STATIC

		/**
		* Calculate the distance between two points
		* @param	Vector 0
		* @param	Vector 1
		* @return	Distance
		*/
		inline public static function dist( v0:Vector2 , v1:Vector2 ):Float {

			return Math.sqrt( (v1.x-v0.x)*(v1.x-v0.x) + (v1.y-v0.y)*(v1.y-v0.y) );
		}

		/**
		* Normalize the vector to a length of 1
		* @param	Vector 0
		* @param	Vector 1
		* @return	Norm L1
		*/
		inline public static function normL1( v0:Vector2 , v1:Vector2 ):Float {

			return ( Math.abs( v1.x-v0.x ) + Math.abs( v1.y-v0.y ) );
		}

		/**
		* Calculate the dot product of two vectors
		* @param	Vector 0
		* @param	Vector 1
		* @return	dot product
		*/
		inline public static function dot( v0:Vector2 , v1:Vector2 ):Float {

			return ( v0.x*v1.x + v0.y*v1.y );
		}

		/**
		* 外積
		* @param	Vector 0
		* @param	Vector 1
		* @return	cross product
		*/
		inline public static function cross( v0:Vector2 , v1:Vector2 ):Vector2 {

			//U x V = Ux*Vy-Uy*Vx
			return new Vector2(0, v0.x*v1.y - v0.y*v1.x);
			//return new Vector( v0.y*v1.z - v0.z*v1.y , v0.z*v1.x - v0.x*v1.z , v0.x*v1.y - v0.y*v1.x);
		}

		/**
		* Cos
		*/
		inline public static function cos( v0:Vector2 , v1:Vector2 ):Float {

			return ( Vector2.dot( v0 , v1 )/(v0.getLength() * v1.getLength()) );
		}
		/**
		* Sin
		*/
		inline public static function sin( v0:Vector2 , v1:Vector2 ):Float {

			return ( (Vector2.cross( v0 , v1 )).getLength()/(v0.getLength() * v1.getLength()) );
		}
		/**
		* Angle
		*/
		inline public static function angle2( v0:Vector2 , v1:Vector2 ):Float {

			return Math.acos( Vector2.cos( v0 , v1 ) );
		}

		inline public static function angleBetween( v1:Vector2 , v2:Vector2 ):Float {

			return Math.acos(Vector2.dot(v1, v2) / (v1.getLength() * v2.getLength()));
		}
		
		/*
		public function getRotate(rad:Number):Vector {
			return new Vector(Math.cos(rad) * this.x - Math.sin(rad) * this.y, Math.sin(rad) * this.x + Math.cos(rad) * this.y);
		}
		*/
		/**
		* Interpolate
		* @param	Vector0
		* @param	Vector1
		* @param	f
		* @return	Vector
		*/
		public static function interpolate( v0:Vector2 , v1:Vector2 , f:Float):Vector2 {

			var v = new Vector2( v1.x-v0.x, v1.y-v0.y );
			v.normalize( v.getLength() * f );
			v.add( v0 );
			return v;
		}

		/**
		* Random Vector
		* @param	length
		* @return	Vector
		*/
		public static function randomVector(len:Float = 1.0):Vector2 {

			var v = new Vector2( Math.random()-0.5 , Math.random()-0.5 );
			v.normalize(len);
			return v;
		}
	
}