package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class SetUpBTest extends BaseMockTest
{
	
	public function SetUpBTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
		this.addAsync(100, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, TriggerKind.NOTHING);
		this.addDeferredAsync(1000, helpDispatcher, BaseMockTest.TRIGGER, sharedAsync, triggerKind);
	}
	
}
	
}
