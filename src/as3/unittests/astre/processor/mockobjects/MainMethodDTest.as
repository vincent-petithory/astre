package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class MainMethodDTest extends BaseMockTest
{
	
	public function MainMethodDTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function triggerNothing():void 
	{
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerImmediate():void 
	{
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerDeferred():void 
	{
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerBoth():void 
	{
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
