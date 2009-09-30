package astre.conditions 
{
	import astre.conditions.conditionsTestClasses.NumberEqualsCondition;
	import astre.core.ICondition;
	import astre.core.Test;

public class ConditionTest extends Test
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function ConditionTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function getUnexpectedConditionTrueMessageTest():void
	{
		
		var cT:ICondition = new NumberEqualsCondition(10, 10);
		assertTrue(cT.isConditionRespected());
		assertEquals("-10- was the unexpected Number -10-", cT.getUnexpectedResultMessage());
	}
	
	public function getUnexpectedConditionFalseMessageTest():void
	{
		var cF:ICondition = new NumberEqualsCondition(10, 11);
		assertFalse(cF.isConditionRespected());
		assertEquals("Expected Number -10- but was -11-", cF.getUnexpectedResultMessage());
	}
	
}
	
}
