package fboyle.ds;

/**
* 	A simple object pool that is growable.  
*  	Started off as a port of Lee Brimelow's demo code but using generics
*  	(http://gotoandlearn.com/play.php?id=160)
*  
*  	Example:
*  	
*  	var pool:ObjectPool<Sprite> = new ObjectPool(Sprite, 30);
*  
*  	var sprite = pool.retrieve();
*  	container.addChild(sprite);
*  
*  	//an then later
*  	container.removeChild(sprite);
*  	pool.release(sprite);
*  
*/
class ObjectPool<T> {
	
	var pool:Array<T>;
	var totalObjects:Int;
	var clazz :Class<T>;
	var allowToGrow:Bool;
	
	public function new(c:Class<T>, len:Int, grow=true) {
		
		pool = [];
		clazz = c;
		totalObjects = len;
		allowToGrow = grow;
		
		var i = len;
		while(--i > -1) {
			pool[i] = Type.createInstance(c, []);
		}
		
		
	}
	
	/**
	*	get object from pool
	*/
	public function retrieve():T {
		
		//trace("totalObjects "+totalObjects);
		if(totalObjects > 0) {
			
			return pool[--totalObjects];
		
		}else {
			if(allowToGrow) {
				
				trace("no objects in pool, create a new one ");
				//(will get added to pool when it is released)
				return Type.createInstance(clazz, []);
				
			}else {
				
				//trace("You exhausted the pool!");
				throw ("You exhausted the pool!");
			}
		}
	}
	
	/**
	*	return object to pool 
	*/
	public function release(s:T):Void {
		
		pool[totalObjects++] = s;
	}
	
	/**
	 * Unlock all resources for the garbage collector.
	 */
	public function clear() {
		pool = null;
	}
}
