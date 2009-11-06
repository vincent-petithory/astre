package astre.runner.manipulation.resultRules  
{
	import astre.core.TestList;

public class AllAstreRunnerManipulationResultrulesTests extends TestList
{

	public function AllAstreRunnerManipulationResultrulesTests()
	{
		super();
		this.addTestClass(ResultTypeSortRuleTest);
		this.addTestClass(TestDescriptionSortRuleTest);
	}
	
}

}
