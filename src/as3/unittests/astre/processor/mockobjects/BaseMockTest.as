package astre.processor.mockobjects 
{
	import astre.core.Test;
	import flash.events.Event;
	import flash.utils.setTimeout;

public class BaseMockTest extends Test
{
	
	protected var triggerKind:String;
	
	public static const TRIGGER:String = "mockTrigger";
	
	public static const TRIGGER_NOTHING:String = "triggerNothing";
	public static const TRIGGER_DEFERRED:String = "triggerDeferred";
	public static const TRIGGER_IMMEDIATE:String = "triggerImmediate";
	public static const TRIGGER_BOTH:String = "triggerBoth";
	
	public function BaseMockTest(name:String) 
	{
		super(name);
		switch (name)
		{
			case "triggerNothing": 
				triggerKind = TriggerKind.NOTHING;
				break;
			case "triggerDeferred": 
				triggerKind = TriggerKind.DEFERRED;
				break;
			case "triggerImmediate":
				triggerKind = TriggerKind.IMMEDIATE;
				break;
			case "triggerBoth":
				triggerKind = TriggerKind.BOTH;
				break;
		}
	}
	
	protected function dispatch():void
	{
		helpDispatcher.dispatchEvent(new Event(BaseMockTest.TRIGGER));
	}
	
	public function triggerNothing():void {}
	public function triggerDeferred():void {}
	public function triggerImmediate():void {}
	public function triggerBoth():void {}
	
	protected function sharedAsync(event:Event, triggerKind:String):void
	{
		switch (triggerKind)
		{
			case TriggerKind.NOTHING: 
				break;
			case TriggerKind.DEFERRED: 
				this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
				break;
			case TriggerKind.IMMEDIATE:
				this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
				break;
			case TriggerKind.BOTH:
				this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
				this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
				break;
		}
		setTimeout(dispatch, 421);
	}
	
}
	
}
