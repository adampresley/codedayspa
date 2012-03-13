/**
 * Class: ap
 * Defines the primary ap namespace object. Includes basic functions
 * for all to use. Setup as a singleton.
 *
 * Author:
 * 	Adam Presley
 *
 *
 * Section: Variables
 *
 * Public Variables:
 * 	debug - True/false to enable JS debugging
 * 	listeners - Object containing observable events
 *
 *
 * Section: Functions
 */
ap = function() {
	return {
		debug: false,
		listeners: {},

		/**
		 * Function: log
		 * Sends a message to the console, if it is available.
		 *
		 * Author:
		 * 	Adam Presley
		 *
		 * Parameters:
		 * 	msg - Message to display
		 */
		log: function(msg) {
			if ("console" in window) {
				console.log(msg);
			}
		}
	};
}();


/**
 * Class: ap.util
 * Provides simple utility methods. Setup to be used
 * as a singleton.
 *
 * Author:
 * 	Adam Presley
 */
ap.util = function() {
	return {

		/**
		 * Function: compare
		 * Compares two values and returns the difference.
		 *
		 * Parameters:
		 * 	a - First item to compare
		 * 	b - Second item to compare
		 *
		 * Returns:
		 * 	- -1 for a being less than b
		 * 	- 0 for a being the same as b
		 * 	- 1 for a being greater than b
		 */
		compare: function(a, b) {
			if (a > b) {
				return 1;
			}
			else if (a < b) {
				return -1;
			}
			else {
				return 0;
			}
		},

		/**
		 * Function: map
		 * Executes a function for each key in an object. The original object is 
		 * modified.
		 *
		 * Parameters:
		 * 	o - Object to be modified/traversed
		 * 	callback - Method to be called for each key found
		 * 	scope - Scope this callback method is to be called in
		 */
		map: function(o, callback, scope) {
			var item = 0, index = 0;

			if (scope === undefined) scope = this;

			if ("length" in o) {
				for (index = 0; index < o.length; index++) {
					o[index] = callback.call(scope, o[index]);
				}
			}
			else if (typeof o === "object") {
				for (item in o) {
					if (typeof o[item] !== "function") {
						o[item] = callback.call(scope, item, o[item]);
					}
				}
			}
		}
	};
}();


/**
 * Class: ap.arrayUtil
 * Provides useful Array utilities. Setup as a singleton.
 *
 * Author:
 * 	Adam Presley
 */
ap.arrayUtil = function() {
	return {

		integerSortComparator: function(a, b) {
			return ap.util.compare(window.parseInt(a), window.parseInt(b));
		},

		floatSortComparator: function(a, b) {
			return ap.util.compare(window.parseFloat(a), window.parseFloat(b));
		},

		simpleDedupeComparator: function(a, b) {
			return a === b;
		},

		sort: function(a, comparator) {
			var top = a.length;
			var newTop = 0, index = 0, temp = 0;

			do {
				newTop = 0;

				for (index = 0; index < top; index++) {
					if ((comparator.call(this, a[index - 1], a[index])) > 0) {
						temp = a[index];
						a[index] = a[index - 1];
						a[index - 1] = temp;

						newTop = index;
					}
				}

				top = newTop;
			} while (top > 0);
		},


		/**
		 * Removes duplicates from an array of items. Does not return any
		 * value as it removes duplicates from the original array itself. Use
		 * of a comparator allows for comparing complex items. For example:
		 *
		 * <code>
		 * var a = [ 2, 1, 1, 5 ];
		 * ap.arrayUtil.dedupe(a, {
		 *  sortComparator: function(a, b) {
		 *      if (a > b)
		 *          return 1;
		 *      else if (a < b)
		 *          return -1;
		 *      else
		 *          return 0;
		 *  },
		 *  dedupeComparator: function(a, b) {
		 *      return a === b;
		 *  }
		 * });
		 * </code>
		 * @author Adam Presley
		 *
		 * @param a An array of items to remove duplicates from
		 * @param comparators An object containing two keys: sortComparator and
		 *  dedupeComparator. Both are functions taking two arguments. See
		 *  the sort method for information on the sortComparator. The 
		 *  dedupeComparator takes two arguments, and expects a true/false
		 *  return on if the items are the same or not.
		 */
		dedupe: function(a, comparators) {
			this.sort(a, comparators.sortComparator);

			var length = a.length, index = 0;
			var spliceStart = 0, spliceLen = 0;
			var item = 0, compareResult = 0, temp = 0;

			if (length > 1) {
				while (index < length - 1) {
					item = a[index];

					if (index + 1 < length) {
						spliceStart = index + 1;
						spliceLen = 0;
						temp = a[spliceStart];

						while ((compareResult = comparators.dedupeComparator.call(this, item, temp))) {
							spliceLen++;

							if (spliceStart + spliceLen >= length - 1) break;
							temp = a[spliceStart + spliceLen];
						}

						if (spliceLen > 0) {
							a.splice(spliceStart, spliceLen);
							length -= spliceLen;
						}
					}

					index++;
				}
			}
		}
	};
}();


/**
 * Class: ap.Ovservable
 * Basic implementation of the Observer pattern.
 *
 * Author:
 * 	Adam Presley
 */
ap.Observable = function() {
	/**
	 * Function: subscribe
	 * This method registers a handler for a specified event.
	 *
	 * Author:
	 * 	Adam Presley
	 *
	 * Parameters:
	 * 	eventName - String name of the event to subscribe to
	 * 	handler - Function called to handle published events of this type
	 * 	scope - The scope in which to call the handler function
	 */
	this.subscribe = function(eventName, handler, scope) {
		var def = {
			eventName: eventName,
			handler: handler,
			scope: (scope || undefined)
		};

		if (eventName in ap.listeners) {
			ap.listeners[eventName].push(def);
		}
		else {
			ap.listeners[eventName] = [ def ];
		}

		if (ap.debug) { ap.log("Listener for " + eventName + " pushed to stack: " + def); }
	};


	/**
	 * Function: publish
	 * Tells the object to publish an event by name, sending a series of parameters
	 * along with the message for any subscribers to pick up.
	 *
	 * Author:
	 * 	Adam Presley
	 *
	 * Parameters:
	 * 	eventName - String name of the event to publish
	 * 	params - An object of optional parameters to send with the message
	 */
	this.publish = function(eventName, params) {
		var i = 0, params = (params || {});

		if (eventName in ap.listeners) {
			for (i = 0; i < ap.listeners[eventName].length; i++) {
				if (ap.debug) { ap.log("Calling listener for " + eventName); }

				if ("scope" in ap.listeners[eventName][i] && ap.listeners[eventName].scope !== undefined) {
					ap.listeners[eventName][i].handler.call(ap.listeners[eventName][i].scope, params);
				}
				else {
					ap.listeners[eventName][i].handler(params);
				}
			}
		}
	};
};
