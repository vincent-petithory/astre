package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class TearDownDTest extends BaseMockTest
{
	
	public function TearDownDTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function tearDown():void 
	{
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
	
}
	
}
