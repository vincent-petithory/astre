package astre.processor 
{
	import astre.processor.process.AllAstreProcessorProcessTests;
	import astre.core.TestList;

public class AllAstreProcessorTests extends TestList
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AllAstreProcessorTests() 
	{
		super();
		this.addTestClass(TestProcessorTest);
		this.addTestList(new AllAstreProcessorProcessTests());
	}
	
}
	
}
