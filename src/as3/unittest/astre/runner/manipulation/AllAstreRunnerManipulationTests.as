package astre.runner.manipulation 
{
	import astre.runner.manipulation.resultRules.AllAstreRunnerManipulationResultrulesTests;
	import astre.runner.manipulation.runRequestRules.AllAstreRunnerManipulationRunrequestrulesTests;
	import astre.core.TestList;


public class AllAstreRunnerManipulationTests extends TestList
{

	public function AllAstreRunnerManipulationTests()
	{
		super();
		this.addTestList(new AllAstreRunnerManipulationResultrulesTests());
		this.addTestList(new AllAstreRunnerManipulationRunrequestrulesTests());
	}
	
}

}
