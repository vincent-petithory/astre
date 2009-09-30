package astre.core 
{
	import astre.async.FunctionToken;
	import astre.core.Test;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

public class TestTest extends Test
{
	private var token:FunctionToken;
	
	public function TestTest(name:String)
	{
		super(name);
	}
	
	//------------------
	
	public function deferredAsyncCheckoutNotCalledBecauseEventDisptachedBeforeStartTest():void
	{
		this.addDeferredAsync(2000, helpDispatcher, "asyncEvent", asyncDispatcher, "asyncEvent2");
		this.addDeferredAsync(2500, helpDispatcher, "asyncEvent2", doesNothingFunction, null, failFunction, true);
		this.addAsync(4000, helpDispatcher, FunctionEvent.VALIDATE_FUNC, validateAsyncData, failFunction);
		setTimeout(dispatch, 1000, helpDispatcher);
	}
	
	public function deferredAsyncCheckoutNotCalledBecauseEventDisptachedBeforeStartTest2():void
	{
		this.addDeferredAsync(2000, helpDispatcher, "asyncEvent", asyncDispatcher, "asyncEvent2");
		this.addDeferredAsync(2500, helpDispatcher, "asyncEvent2", doesNothingFunction, null, failFunction2);
		token = this.checkFunctionWillBeCalled(4000, "failFunction2");
		setTimeout(dispatch, 1000, helpDispatcher);
	}
	
	private function failFunction2():void
	{
		this.markFunctionAsCalled(token);
	}
	
	private function doesNothingFunction(e:Event):void {}
	
	private function asyncDispatcher(e:Event, type:String):void
	{
		(e.target as IEventDispatcher).dispatchEvent(new Event(type));
	}
	
	//------------------
	
	public function checkFunctionWillBeCalledTest():void
	{
		token = this.checkFunctionWillBeCalled(2000, "iWillBeCalled");
		setTimeout(iWillBeCalled, 1000);
	}
	
	private function iWillBeCalled():void
	{
		this.markFunctionAsCalled(token);
	}
	
	public function variousDeferredAsyncCheckoutsTest():void
	{
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent1", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent2", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent3", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent4", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent5", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent6", doesNothingFunction);
		this.addDeferredAsync(3000, helpDispatcher, "asyncEvent7", doesNothingFunction);
		setTimeout(dispatch, 1000, helpDispatcher, "asyncEvent1");
		setTimeout(dispatch, 3000, helpDispatcher, "asyncEvent2");
		setTimeout(dispatch, 5000, helpDispatcher, "asyncEvent3");
		setTimeout(dispatch, 7000, helpDispatcher, "asyncEvent4");
		setTimeout(dispatch, 9000, helpDispatcher, "asyncEvent5");
		setTimeout(dispatch, 11000, helpDispatcher, "asyncEvent6");
		setTimeout(dispatch, 13000, helpDispatcher, "asyncEvent7");
	}
	
	public function instantAsyncCheckoutNotLateTest():void
	{
		this.addAsync(2000, helpDispatcher, "asyncEvent", asyncFunction, true, null, null);
		this.addDeferredAsync(2500, helpDispatcher, FunctionEvent.VALIDATE_FUNC, validateAsyncData, asyncFunction);
		setTimeout(dispatch, 1000, helpDispatcher);
	}
	
	public function instantAsyncCheckoutTooLateTest():void
	{
		this.addAsync(2000, helpDispatcher, "asyncEvent", asyncFunction, false, failFunction, true);
		this.addDeferredAsync(3500, helpDispatcher, FunctionEvent.VALIDATE_FUNC, validateAsyncData, failFunction);
		setTimeout(dispatch, 3000, helpDispatcher);
	}
	
	//------------------
	
	public function asyncCheckoutAsyncFunctionDataTest():void
	{
		this.addAsync(2000, helpDispatcher, "asyncEvent", asyncFunctionWithData, {shouldBeCalled: true, point: new Point(10, 20)}, null, null);
		setTimeout(dispatch, 1000, helpDispatcher);
	}
	
	public function asyncCheckoutFailFunctionDataTest():void
	{
		this.addAsync(2000, helpDispatcher, "asyncEvent", asyncFunctionWithData, {shouldBeCalled: false, point: new Point(10, 20)}, failFunctionWithData, {shouldBeCalled: true, point: new Point(10, 20)});
		setTimeout(dispatch, 3000, helpDispatcher);
	}
	
	public function asyncCheckoutNestedAsyncFunctionDataTest():void
	{
		this.addAsync(2000, helpDispatcher, "asyncEvent", nestAsyncFunctionWithData, helpDispatcher, failFunction, false);
		setTimeout(dispatch, 1000, helpDispatcher);
	}
	
	//------------------------------
	// Helpers & listeners
	//------------------------------
	
	private function dispatch(dispatcher:IEventDispatcher, type:String = "asyncEvent"):void
	{
		dispatcher.dispatchEvent(new Event(type));
	}
	
	private function asyncFunction(e:Event, shouldBeCalled:Boolean):void
	{
		if (shouldBeCalled)
		{
			helpDispatcher.dispatchEvent(new FunctionEvent(FunctionEvent.VALIDATE_FUNC, asyncFunction));
		}
		else
		{
			fail("I should not have been called");
		}
	}
	
	private function failFunction(shouldBeCalled:Boolean):void
	{
		if (shouldBeCalled)
		{
			helpDispatcher.dispatchEvent(new FunctionEvent(FunctionEvent.VALIDATE_FUNC, failFunction));
		}
		else
		{
			fail("I should not have been called");
		}
	}
	
	private function failFunctionWithData(data:Object):void
	{
		if (data.shouldBeCalled)
		{
			assertTrue(data.point.equals(new Point(10, 20)));
		}
		else
		{
			fail("I should not have been called");
		}
	}
	
	private function asyncFunctionWithData(event:Event, data:Object):void
	{
		if (data.shouldBeCalled)
		{
			assertTrue(data.point.equals(new Point(10, 20)));
		}
		else
		{
			fail("I should not have been called");
		}
	}
	
	private function nestAsyncFunctionWithData(event:Event, data:IEventDispatcher):void
	{
		this.addAsync(2000, data, "asyncEvent2", asyncFunctionWithData, {shouldBeCalled: true, point: new Point(10, 20)});
		setTimeout(dispatch, 1000, data, "asyncEvent2");
	}
	
	private function validateAsyncData(event:FunctionEvent, whichFunction:Function):void
	{
		assertEquals(whichFunction, event.func);
	}
	
	//------------------
	
}

}
import flash.events.Event;

internal class FunctionEvent extends Event
{
	
	
	public static const VALIDATE_FUNC:String = "validateFunc";
	
	public var func:Function;
	
	public function FunctionEvent(type:String, func:Function)
	{
		super(type, false, false);
		this.func = func;
	}
	
	override public function clone():Event 
	{
		return new FunctionEvent(type, func);
	}
	
}