package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class SetUpNTest extends BaseMockTest
{
	
	public function SetUpNTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
}
	
}
