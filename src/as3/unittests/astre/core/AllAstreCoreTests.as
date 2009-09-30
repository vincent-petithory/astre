package astre.core 
{
	import astre.async.AllAstreAsyncTests;
	import astre.conditions.AllAstreConditionsTests;
	import astre.processor.AllAstreProcessorTests;
	import astre.runner.AllAstreRunnerTests;
	import astre.util.AllAstreUtilTests;

public class AllAstreCoreTests extends TestList
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AllAstreCoreTests() 
	{
		this.addTestClass(AssertionTest);
		this.addTestClass(AtomicResultTest);
		this.addTestClass(EResultTypeTest);
		this.addTestClass(TestListTest);
		this.addTestClass(TestTest);
	}
	
	
}
	
}
