package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class MainMethodITest extends BaseMockTest
{
	
	public function MainMethodITest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function triggerNothing():void 
	{
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerImmediate():void 
	{
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerDeferred():void 
	{
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	override public function triggerBoth():void 
	{
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	
	
}
	
}
