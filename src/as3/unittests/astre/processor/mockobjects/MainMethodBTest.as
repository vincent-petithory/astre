package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class MainMethodBTest extends BaseMockTest
{
	
	public function MainMethodBTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function triggerNothing():void 
	{
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerImmediate():void 
	{
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerDeferred():void 
	{
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerBoth():void 
	{
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
