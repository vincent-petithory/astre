package astre.conditions.conditionsTestClasses 
{
	import astre.conditions.Condition;

public class StringEqualsCondition extends Condition
{
	
	private var reference:String;
	private var actual:String;
	
	public function StringEqualsCondition(reference:String, actual:String)
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
		return "-"+actual+"- was the unexpected String -"+reference+"-";
	}
	
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		return "Expected String -"+reference+"- but was -"+actual+"-";
	}
	
}

}
