package astre.async 
{
	import astre.core.Assertion;
	import astre.core.Test;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;

public class AsyncCheckoutTest extends Test
{
	private var checkout:IAsyncCheckout;
	private var sprite:Sprite;
	
	public function AsyncCheckoutTest(name:String) 
	{
		super(name);
	}
	
	//------------------
	
	override public function setUp():void 
	{
		checkout = new AsyncCheckout(5);
		sprite = new Sprite();
	}
	
	override public function tearDown():void 
	{
		checkout = null;
		sprite = null;
	}
	
	public function asyncExecutedTest():void
	{
		this.addAsync(1500, checkout, AsyncCheckoutEvent.ASYNC_EXECUTED, onCheckoutExecuted);
		
		checkout.checkout(2000, sprite, "asyncTask", func);
		checkout.startCheckout();
		setTimeout(dispatchAsync, 1000, sprite);
	}
	
	private function onCheckoutExecuted(e:AsyncCheckoutEvent):void {}
	
	//----------------------
	
	public function asyncNotExecutedNoFailFuncTest():void
	{
		this.addAsync(4000, checkout, AsyncCheckoutEvent.ASYNC_NOT_EXECUTED, onCheckoutNotExecuted);
		
		checkout.checkout(2000, sprite, "asyncTask", func);
		checkout.startCheckout();
		setTimeout(dispatchAsync, 3000, sprite);
	}
	
	private function onCheckoutNotExecuted(e:AsyncCheckoutEvent):void {}
	
	//------------------------
	
	public function asyncNotExecutedWithFailFuncTest():void
	{
		this.addAsync(4000, checkout, AsyncCheckoutEvent.EXPECTED_ASYNC_NOT_EXECUTED, onCheckoutNotExecutedWithFailFunc);
		
		checkout.checkout(2000, sprite, "asyncTask", funcNotExpected, null, failFunc);
		checkout.startCheckout();
		setTimeout(dispatchAsync, 3000, sprite);
	}
	
	private function funcNotExpected(event:Event):void
	{
		Assertion.fail("Async method not expected but was called");
	}
	private function onCheckoutNotExecutedWithFailFunc(e:AsyncCheckoutEvent):void {}
	
	//------------------------
	
	private function dispatchAsync(dispatcher:IEventDispatcher):void
	{
		dispatcher.dispatchEvent(new Event("asyncTask"));
	}
	
	private function func(event:Event = null, data:Object = null):void {}
	private function failFunc(event:Event = null, data:Object = null):void {}
	
}
	
}
