package astre 
{
	import astre.async.AllAstreAsyncTests;
	import astre.conditions.AllAstreConditionsTests;
	import astre.core.AllAstreCoreTests;
	import astre.processor.AllAstreProcessorTests;
	import astre.runner.AllAstreRunnerTests;
	import astre.util.AllAstreUtilTests;
	import astre.core.TestList;

public class AllAstreTests extends TestList
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AllAstreTests() 
	{
		this.addTestList(new AllAstreAsyncTests());
		this.addTestList(new AllAstreConditionsTests());
		this.addTestList(new AllAstreCoreTests());
		this.addTestList(new AllAstreProcessorTests());
		this.addTestList(new AllAstreRunnerTests());
		this.addTestList(new AllAstreUtilTests());
	}
	
	
}
	
}
