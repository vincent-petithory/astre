package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class TearDownITest extends BaseMockTest
{
	
	public function TearDownITest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function tearDown():void 
	{
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
