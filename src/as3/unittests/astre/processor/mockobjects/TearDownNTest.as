package astre.processor.mockobjects 
{
	import flash.utils.setTimeout;

public class TearDownNTest extends BaseMockTest
{
	
	public function TearDownNTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		setTimeout(dispatch, 421);
	}
	
	override public function tearDown():void 
	{
		// nothing
	}
	
}
	
}
