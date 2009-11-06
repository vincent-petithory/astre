package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class MainMethodNTest extends BaseMockTest
{
	
	public function MainMethodNTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	
}
	
}
