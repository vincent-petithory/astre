package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class SetUpITest extends BaseMockTest
{
	
	public function SetUpITest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
		this.addAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
