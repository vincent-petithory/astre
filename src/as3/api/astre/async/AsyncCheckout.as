////////////////////////////////////////////////////////////////////////////
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
// 
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
// 
// The Original Code is Astre framework.
// 
// The Initial Developer of the Original Code is 
// Vincent Petithory   "vincent.petithory@gmail.com".
// Portions created by the Initial Developer are Copyright (C) 2008-2009 
// the Initial Developer. All Rights Reserved.
// 
// Contributor(s): 
////////////////////////////////////////////////////////////////////////////

package astre.async 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

/**
 * The <code class="prettyprint">AsnycCheckout</code> class 
 * is the only class that implements the 
 * <code class="prettyprint">IAsyncCheckout</code> interface.
 * 
 * <p>Once the <code class="prettyprint">startCheckout()</code> method 
 * is called, the <code class="prettyprint">AsyncCheckout</code> object waits 
 * either until the specified timeout ends, or until the expected event 
 * is dispatched on the expected targe, or until the 
 * <code class="prettyprint">cancelCheckout()</code></p> method is called.
 * 
 * <p>It is used internally by asynchronous processes run by a processor, 
 * to handle asynchronous calls. It provides the result of the 
 * asynchronous checkout to its asynchronous process owner.
 * <br/>
 * You do not need to use this class in your tests.</p>
 * 
 * @see astre.processor.process.AsyncProcess
 * 
 * @author lunar
 * 
 */
public class AsyncCheckout 	extends EventDispatcher 
							implements IAsyncCheckout 
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _id:uint;
	
	/**
	 * @inheritDoc
	 */
	public function get id():uint
	{
		return _id;
	}
	
	/**
	 * @private
	 */
	private var _eventType:String;
	
	/**
	 * @inheritDoc
	 */
	public function get eventType():String
	{
		return _eventType;
	}
	
	/**
	 * @private
	 */
	private var asyncFunction:Function;
	
	/**
	 * @private
	 */
	private var failFunction:Function;
	
	/**
	 * @private
	 */
	private var dispatcher:IEventDispatcher;
	
	/**
	 * @private
	 */
	private var eventCapture:Boolean;
	
	/**
	 * @private
	 */
	private var eventPriority:uint;
	
	/**
	 * @private
	 */
	private var data:Object;
	
	/**
	 * @private
	 */
	private var failData:Object;
	
	/**
	 * @private
	 */
	private var timer:Timer;
	
	/**
	 * @inheritDoc
	 */
	public function get isRunning():Boolean
	{
		return timer != null ? timer.running : false;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get timeout():int
	{
		return timer != null ? timer.delay : 0;
	}
	
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * @param id The id of this 
	 * <code class="prettyprint">AsyncCheckout</code>. This 
	 * value will be returned by the 
	 * <code class="prettyprint">IAsyncCheckout.id</code> property.
	 */
	public function AsyncCheckout(id:uint) 
	{
		super();
		this._id = id;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	public function checkout(	
							timeout:uint, 
							dispatcher:IEventDispatcher, 
							type:String, 
							asyncFunction:Function, 
							data:Object = null, 
							failFunction:Function = null, 
							failData:Object = null, 
							useCapture:Boolean = false, 
							priority:int = 0
						):void
	{
		timer = new Timer(timeout, 1);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeoutComplete);
		
		this.dispatcher = dispatcher;
		this._eventType = type;
		this.asyncFunction = asyncFunction;
		this.data = data;
		this.failFunction = failFunction;
		this.failData = failData;
		this.eventCapture = useCapture;
		this.eventPriority = priority;
	}
	
	/**
	 * @inheritDoc
	 */
	public function startCheckout():void
	{
		dispatcher.addEventListener(
						_eventType, 
						asyncHandler, 
						eventCapture, 
						eventPriority, 
						false
					);
		timer.start();
	}
	
	/**
	 * @inheritDoc
	 */
	public function cancelCheckout():void
	{
		this.timer.stop();
		clearListeners();
	}
	
	/**
	 * @private
	 * Called when the timeout ends.
	 */
	private function onTimeoutComplete(event:TimerEvent):void 
	{
		// remove listeners
		this.clearListeners();
		
		if (failFunction != null)
		{
			// if specifying a fail function, we assume 
			// it was expected the async method 
			// has not to be called
			this.dispatchEvent(new AsyncCheckoutEvent(
					AsyncCheckoutEvent.EXPECTED_ASYNC_NOT_EXECUTED, 
					new AsyncData(
						failFunction, 
						null, 
						failData, 
						this)
					)
			);
		}
		else
		{
			this.dispatchEvent(new AsyncCheckoutEvent(
					AsyncCheckoutEvent.ASYNC_NOT_EXECUTED, 
					new AsyncData(
						null, 
						null, 
						null, 
						this)
					)
			);
		}
	}
	
	/**
	 * @private
	 * Called when the expected event is successfully 
	 * dispatched on the expected target and the 
	 * timeout is not finished.
	 */
	private function asyncHandler(event:Event):void
	{
		// remove listeners
		cancelCheckout();
		
		this.dispatchEvent(new AsyncCheckoutEvent(
				AsyncCheckoutEvent.ASYNC_EXECUTED, 
				new AsyncData(
					asyncFunction, 
					event, 
					data, 
					this)
				)
		);
		
	}
	
	/**
	 * @private
	 * Removes the event listener on the dispatcher and the latter 
	 * is set to <code class="prettyprint">null</code>.
	 */
	private function removeAsyncEventListener():void
	{
		if (dispatcher)
			dispatcher.removeEventListener(
							_eventType, 
							asyncHandler, 
							eventCapture
						);
		// Remove reference of the dispatcher to allow it to be possibly gc.
		this.dispatcher = null;
	}
	
	/**
	 * @private
	 * Removes all event listeners 
	 * registered for this <code class="prettyprint">AsyncCheckout</code>.
	 */
	private function clearListeners():void
	{
		removeAsyncEventListener();
		timer.removeEventListener(
							TimerEvent.TIMER_COMPLETE, 
							onTimeoutComplete
						);
	}

}
	
}
