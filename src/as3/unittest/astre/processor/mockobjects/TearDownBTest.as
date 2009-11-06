package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class TearDownBTest extends BaseMockTest
{
	
	public function TearDownBTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function tearDown():void 
	{
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
