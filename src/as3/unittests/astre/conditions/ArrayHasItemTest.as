package astre.conditions 
{
	import astre.core.ICondition;
	import astre.core.Test;

public class ArrayHasItemTest extends Test
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function ArrayHasItemTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function hasItemTest():void
	{
		var c:ICondition = new ArrayHasItem(new Array(1, 2, 3), 1);
		assertTrue(c.isConditionRespected());
	}
	
	public function hasNotItemTest():void
	{
		var c:ICondition = new ArrayHasItem(new Array(1, 2, 3), 5);
		assertFalse(c.isConditionRespected());
	}
	
}
	
}
