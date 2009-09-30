package astre.conditions 
{
	import astre.core.TestList;

public class AllAstreConditionsTests extends TestList
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AllAstreConditionsTests() 
	{
		this.addTestClass(ConditionTest);
		this.addTestClass(CombinedConditionTest);
		this.addTestClass(ArrayHasItemTest);
	}
	
}
	
}
