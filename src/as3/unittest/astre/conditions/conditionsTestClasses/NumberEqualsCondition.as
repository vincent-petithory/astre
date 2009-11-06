package astre.conditions.conditionsTestClasses 
{

import astre.conditions.Condition;

public class NumberEqualsCondition extends Condition
{
	
	private var reference:Number;
	private var actual:Number;
	
	public function NumberEqualsCondition(reference:Number, actual:Number)
	{
		this.reference = reference;
		this.actual = actual;
	}
	
	override protected function processCondition():Boolean 
	{
		if (reference == actual)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	override protected function getUnexpectedConditionTrueMessage():String 
	{
		return "-"+actual+"- was the unexpected Number -"+reference+"-";
	}
	
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		return "Expected Number -"+reference+"- but was -"+actual+"-";
	}
	
}

}
