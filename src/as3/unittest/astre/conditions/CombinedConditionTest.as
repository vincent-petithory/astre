package astre.conditions 
{
	import astre.conditions.conditionsTestClasses.NumberEqualsCondition;
	import astre.conditions.conditionsTestClasses.StringEqualsCondition;
	import astre.core.ICondition;
	import astre.core.Test;

public class CombinedConditionTest extends Test
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var c1:ICondition;
	private var c2:ICondition;
	private var c1c2:ICondition;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function CombinedConditionTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function logicalOrOnePass1UnexpectTrueTest():void
	{
		c1 = new NumberEqualsCondition(10, 10);
		c2 = new StringEqualsCondition("value1", "value2");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.OR, c2);
		assertTrue(c1c2.isConditionRespected());
		
		assertEquals(	
			"-10- was the unexpected Number -10-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalOrOnePass2UnexpectTrueTest():void
	{
		c1 = new NumberEqualsCondition(15, 10);
		c2 = new StringEqualsCondition("value1", "value1");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.OR, c2);
		assertTrue(c1c2.isConditionRespected());
		
		assertEquals(	
			"-value1- was the unexpected String -value1-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalOrTwoPassUnexpectTrueTest():void
	{
		c1 = new NumberEqualsCondition(10, 10);
		c2 = new StringEqualsCondition("value1", "value1");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.OR, c2);
		assertTrue(c1c2.isConditionRespected());
		
		assertEquals(	
			"-10- was the unexpected Number -10-\n"+
			"-value1- was the unexpected String -value1-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalOrUnexpectFalseTest():void
	{
		c1 = new NumberEqualsCondition(15, 10);
		c2 = new StringEqualsCondition("value1", "value2");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.OR, c2);
		assertFalse(c1c2.isConditionRespected());
		
		assertEquals(
			"Expected Number -15- but was -10-\n"+
			"Expected String -value1- but was -value2-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalAndUnexpectTrueTest():void
	{
		c1 = new NumberEqualsCondition(10, 10);
		c2 = new StringEqualsCondition("value1", "value1");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.AND, c2);
		assertTrue(c1c2.isConditionRespected());
		
		assertEquals(	
			"-10- was the unexpected Number -10-\n"+
			"-value1- was the unexpected String -value1-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalAndOneFail1UnexpectFalseTest():void
	{
		c1 = new NumberEqualsCondition(15, 10);
		c2 = new StringEqualsCondition("value1", "value1");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.AND, c2);
		assertFalse(c1c2.isConditionRespected());
		
		assertEquals(
			"Expected Number -15- but was -10-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalAndOneFail2UnexpectFalseTest():void
	{
		c1 = new NumberEqualsCondition(10, 10);
		c2 = new StringEqualsCondition("value1", "value2");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.AND, c2);
		assertFalse(c1c2.isConditionRespected());
		
		assertEquals(
			"Expected String -value1- but was -value2-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
	public function logicalAndTwoFailUnexpectFalseTest():void
	{
		c1 = new NumberEqualsCondition(15, 10);
		c2 = new StringEqualsCondition("value2", "value1");
		
		c1c2 = new CombinedCondition(c1, LogicalOperator.AND, c2);
		assertFalse(c1c2.isConditionRespected());
		
		assertEquals(
			"Expected Number -15- but was -10-\n"+
			"Expected String -value2- but was -value1-", 
			c1c2.getUnexpectedResultMessage()
		);
	}
	
}
	
}
