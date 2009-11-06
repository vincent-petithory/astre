package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class SetUpDTest extends BaseMockTest
{
	
	public function SetUpDTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
