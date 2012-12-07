package tests;
import fboyle.bbone.Events;
import utest.Assert;


class TestEvents {
	
	public function new() {}
	
	public function testOptionalArgumentsPassing() {
		
		var e = new Events();
		
		e.on("all", function(event, arg1, arg2) {
				
			Assert.equals(arg1, 'hello', 'second arg on "all" handler should be the first custom value.');
			Assert.equals(arg2, 'fintan', 'third arg on "all" handler should be the second custom value.');
		});
		e.on("alert", function(arg1, arg2) {
			
			Assert.equals(arg1, 'hello', 'first arg on "all" handler should be the first custom value.');
			Assert.equals(arg2, 'fintan', 'second arg on "all" handler should be the second custom value.');
		});

		e.trigger("alert", ["hello", "fintan"]);
		
	}
	
	public function testOnandTrigger() {
		
		var obj = { counter: 0 };
		
		var e = new Events();
		
		e.on('event', function() { obj.counter += 1; });
	    e.trigger('event');
	    Assert.equals(obj.counter,1,'counter should be incremented.');
	    e.trigger('event');
	    e.trigger('event');
	    e.trigger('event');
	    e.trigger('event');
	    Assert.equals(obj.counter, 5, 'counter should be incremented five times.');
	
	}
	
	public function testBindingAndTriggeringMultipleEvents() {
	    var obj = cast { counter: 0 };
	    
		var e = new Events();
		
	    e.on('a b c', function() { obj.counter += 1; });

	    e.trigger('a');
	    Assert.equals(obj.counter, 1);

	    e.trigger('a b');
	    Assert.equals(obj.counter, 3);

	    e.trigger('c');
	    Assert.equals(obj.counter, 4);

	    e.off('a c');
	    e.trigger('a b c');
	    Assert.equals(obj.counter, 5);
	    
	}
	
	public function testTriggerAllForEachEvent() {
	    var a=false, b=false, obj = { counter: 0 };
	    
		var e = new Events();
		
		e.on('all', function(event) {
		
	      obj.counter++;
	      if (event == 'a') a = true;
	      if (event == 'b') b = true;
	    });
	
		e.trigger('a b');
	    //Assert.isTrue(a);
	    //Assert.isTrue(b);
	    Assert.equals(obj.counter, 2);
	}
	
	public function testOnThenUnbindAllFunctions() {
	    var obj = { counter: 0 };
	    
		var e = new Events();
		//var _callback = function() { obj.counter += 1; };
	    //obj.on('event', _callback);
	    e.on('event', function() { obj.counter += 1; });
	    e.trigger('event');
	    e.off('event');
	    e.trigger('event');
	    Assert.equals(obj.counter, 1, 'counter should have only been incremented once.');
	}
	
	public function testBindTwoCallbacksUnbindOnlyOne() {
	    var obj = { counterA: 0, counterB: 0 };
	    
		var e = new Events();
		
	    //var callback_ = function() { obj.counterA += 1; };
	    var callback_ = function() { Reflect.setField(obj, "counterA",Reflect.getProperty(obj, "counterA")+1); };
	    e.on('event', callback_);
	    //obj.on('event', function() { obj.counterA += 1; });
	    e.on('event', function() { obj.counterB += 1; });
	    e.trigger('event');
	    e.off('event', callback_);
	   // obj.off('event');
	    e.trigger('event');
	    Assert.equals(obj.counterA, 1, 'counterA should have only been incremented once.');
	    Assert.equals(obj.counterB, 2, 'counterB should have been incremented twice.');
	}
	

	var callback_:Void->Void;
	
	public function testUnbindACallbackInTheMidstOfItFiring() {
	    var obj = cast {counter: 0};
	    
		var e = new Events();
		
	    //var callback = function() {
	    //  obj.counter += 1;
	    //  obj.off('event', callback);
	    //};
	    callback_ = function() {
			Reflect.setField(obj, "counter",Reflect.getProperty(obj, "counter")+1);
			e.off('event', callback_);
	    };
		
	    e.on('event', callback_);
	    e.trigger('event');
	    e.trigger('event');
	    e.trigger('event');
	    Assert.equals(obj.counter, 1, 'the callback should have been unbound.');
	}
	
	var incrA:Void->Void;
	var incrB:Void->Void;
	
	public function testTwoBindsThatUnbindThemselves() {
	    var obj = { counterA: 0, counterB: 0 };
	    
		var e = new Events();
	
		//var incrA = function(){ obj.counterA += 1; obj.off('event', incrA); };
	    //var incrB = function(){ obj.counterB += 1; obj.off('event', incrB); };
	    incrA = function(){ 
			Reflect.setField(obj, "counterA",Reflect.getProperty(obj, "counterA")+1);
			e.off('event', incrA);
		};
	    incrB = function(){ 
			Reflect.setField(obj, "counterB",Reflect.getProperty(obj, "counterB")+1);
			e.off('event', incrB);
		};
	    e.on('event', incrA);
	    e.on('event', incrB);
	    e.trigger('event');
	    e.trigger('event');
	    e.trigger('event');
	    Assert.equals(obj.counterA, 1, 'counterA should have only been incremented once.');
	    Assert.equals(obj.counterB, 1, 'counterB should have only been incremented once.');
	
	}
	
	var assertTrue:Void->Void;
	
	public function testBindACallbackWithASuppliedContext() {
	    
	    assertTrue = function () {
	      Assert.isTrue(true, '`this` was bound to the callback');
	    };

	    var e = new Events();
	    e.on('event', function () { this.assertTrue(); }, e);
	    e.trigger('event');
	}
	
	var incr1:Void->Void;
	var incr2:Void->Void;
	
	public function testNestedTriggerWithUnbind() {
	    var obj = { counter: 0 };
	    var e = new Events();
//	    var incr1 = function(){ obj.counter += 1; obj.off('event', incr1); obj.trigger('event'); };
//	    var incr2 = function(){ obj.counter += 1; };
	    incr1 = function(){ 
		
			Reflect.setField(obj, "counter", Reflect.getProperty(obj, "counter")+1);
			e.off('event', incr1);
			e.trigger('event');
			
		};
	    incr2 = function(){ 
			Reflect.setField(obj, "counter", Reflect.getProperty(obj, "counter")+1);
		};
	    e.on('event', incr1)
	    	.on('event', incr2)
	    	.trigger('event');
	    Assert.equals(obj.counter, 3, 'counter should have been incremented three times');
	}
	
	public function testCallbackListIsNotAlteredDuringTrigger() {
		
	    var counter = 0;
		var obj = {};
	 	var e = new Events();
	    var incr = function(){ counter++; };
	
		e.on('event', function(){ 
			e.on('event', incr);
			e.on('all', incr); 
		});
	    e.trigger('event');
	    
		Assert.equals(counter, 0, 'bind does not alter callback list');

	    //e.off('event');
	    //e.off('all');
	    //e.off(null, incr);
		e.off();
		
		e.on('event', function(){ 
			e.off('event', incr);
			e.off('all', incr); 
		});
		
	    e.on('event', incr);
	    e.on('all', incr);
	    e.trigger('event');
		Assert.equals(counter, 2, 'unbind does not alter callback list');
	
	}
	
	public function testAllCallbackListIsRetrievedAfterEachEvent () {
	    var counter = 0;
		var obj = {};
	    
		var e = new Events();
	
	    var incr = function(){ counter++; };
	    e.on('x', function() {
	      	e.on('y', incr);
			e.on('all', incr);
	    });
	    e.trigger('x y');
	    Assert.equals(counter, 2);
	}
	
	public function testRemoveAllEventsForASpecificCallback() {
	    var obj = {};
	    
		var e = new Events();
	
	    var success = function() { Assert.isTrue(true); };
	    var fail = function() { 
			Assert.isTrue(false); 
		};
	    e.on('x y all', success);
	    e.on('x y all', fail);
	    e.off(null, fail); 
		e.trigger('x y');
	}
	
	
	
}