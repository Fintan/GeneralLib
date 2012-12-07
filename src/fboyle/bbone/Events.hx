/*
Port of Backbone Events object to Haxe
@author Fintan Boyle, fboyle.com

Copyright (c) 2010-2012 Jeremy Ashkenas, DocumentCloud

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package fboyle.bbone;

/**
* A port of the Events object in Backbone.js
*
*/
class Events {
	
	// Regular expression used to split event strings
	//var eventSplitter = /\s+/;
	var eventSplitter:String;
	var _callbacks:Hash<Dynamic>;
	
	// Aliases for backwards compatibility.
	public var bind:String->Dynamic->Dynamic->Events;
	public var unbind:String->Dynamic->Dynamic->Events;
	
	public function new() {
		
		eventSplitter = " ";
		_callbacks = new Hash<Dynamic>();
		
		bind = on;
		unbind = off;
		
	}
	
	// Bind one or more space separated events, `events`, to a `callback`
    // function. Passing `"all"` will bind the callback to all events fired.
	public function on(events_:String, callback_:Dynamic=null, context:Dynamic=null):Events {
		
		var calls:Hash<Dynamic>, event:String, list:Array<Dynamic>;
	    if (callback_ == null) return this;

	    var events:Array<String> = events_.split(eventSplitter);
	    calls = _callbacks != null ? _callbacks : new Hash<Dynamic>();

	    while ((event = events.shift()) != null) {

			if(calls.exists(event)) {
				list = calls.get(event);
			}else{
				list = [];
				calls.set(event, list);
			}

	        list.push(callback_);
	        list.push(context);
	    }

	    return this;
		
    }

	public function off(events_:String=null, callback_:Dynamic=null, context:Dynamic=null):Events {
		
		var event:String, calls:Hash<Dynamic>, list:Array<Dynamic>, i:Int;

		// No events, or removing *all* events.
		calls = _callbacks;
		if(_callbacks == null || Lambda.empty(_callbacks)) {
			return this;
		}

		if (!(events_ != null || callback_ != null || context != null)) {
			//_callbacks = null;
			_callbacks = new Hash<Dynamic>();
			return this;
      	}

		var keys:Array<String> = [];
		
		for(key in calls.keys()){
			keys.push(key);
		}
		
		var events2:Array<String> = events_ != null ? events_.split(eventSplitter) : keys;

      	// Loop through the callback list, splicing where appropriate.
      	while ((event = events2.shift()) != null) {
			
			list = calls.get(event);
			//TODO: strict equality needed I think
			if (((list) != null) || !(callback_ != null || context != null)) {
				//calls.remove(event) will remove all callbacks for an event rather than just the one specified
				if(callback_ != null) {
					for(i in 0...list.length) {
						if(list[i] == callback_){
							list.remove(list[i]);
							if(i < list.length) list.remove(list[i]);
						} 
					}
					calls.set(event, list);
				}else {
					calls.remove(event);
				}
          		continue;
        	}

			i = list.length - 2;
			while(i >= 0) {
				if (!(callback_ != null && list[i] != callback_ || context != null && list[i + 1] != context)) {
					list.splice(i, 2);
	        	}
				i -= 2;
			} 

      	}
		
      	return this;
	      
	}
	
	// Trigger one or many events, firing all bound callbacks. Callbacks are
	// passed the same arguments as `trigger` is, apart from the event name
	// (unless you're listening on `"all"`, which will cause your callback to
	// receive the true name of the event as the first argument).
	public function trigger(events_:String,rest:Array<Dynamic>=null):Events {
		
		var event:String, calls:Hash<Dynamic>, list:Array<Dynamic> = null, i:Int, length:Int, args:Array<Dynamic>, all:Array<Dynamic> = null;
	   	
		if(rest == null) rest = [];//flash target doesn't like null as an arg using Reflect.callMethod
		calls = _callbacks;
		
		if (calls == null) return this;
		
	    var events3:Array<String> = events_.split(eventSplitter);
		
		// For each event, walk through the list of callbacks twice, first to
	    // trigger the event, then to trigger any `"all"` callbacks.
	    while ((event = events3.shift()) != null) {
			// Copy callback lists to prevent modification.
			all = calls.exists("all") ?calls.get("all") : null;
	        if (all != null){
				all = all.slice(0);
			} 
	        
			list = calls.exists(event) ? calls.get(event) : null;
			if (list != null) {
				list = list.slice(0);
			}
	        // Execute event callbacks.
	        if (list != null) {
				length = list.length;
				i = 0;
				while(i < length) {
					//list[i].apply(list[i + 1] != null ? list[i + 1] : this, rest);
					Reflect.callMethod(list[i + 1] != null ? list[i + 1] : this,list[i],rest);
					i += 2;
				}
	        }
			
	        // Execute "all" callbacks.
	        if (all != null) {
				
	          	args = [event].concat(cast rest);
				
				length = all.length;
				i = 0;
				
				while(i < length) {
					//all[i].apply(all[i + 1] != null ? all[i + 1] : this, args);
					Reflect.callMethod(all[i + 1] != null ? all[i + 1] : this, all[i], args);
					i += 2;
				}
	        }
	    }

	    return this;
	}
}