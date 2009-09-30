package astre.runner 
{
	import astre.core.TestList;
	import astre.runner.manipulation.AllAstreRunnerManipulationTests;

public class AllAstreRunnerTests extends TestList
{
	
	public function AllAstreRunnerTests() 
	{
		super();
		this.addTestClass(ResultTest);
		this.addTestClass(RunRequestTest);
		this.addTestClass(AbstractTestListenerTest);
		this.addTestClass(TestRunnerTest);
		this.addTestList(new AllAstreRunnerManipulationTests());
	}
	
	
}
	
}
