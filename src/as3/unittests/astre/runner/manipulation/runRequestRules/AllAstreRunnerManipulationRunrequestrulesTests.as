package astre.runner.manipulation.runRequestRules 
{
	import astre.core.TestList;

public class AllAstreRunnerManipulationRunrequestrulesTests extends TestList
{

	public function AllAstreRunnerManipulationRunrequestrulesTests()
	{
		super();
		this.addTestClass(TestDescriptionSortRuleTest);
		this.addTestClass(TestPackageFilterRuleTest);
	}
	
}

}
