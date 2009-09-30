package astre.async 
{
	import astre.core.TestList;

public class AllAstreAsyncTests extends TestList
{
	
	public function AllAstreAsyncTests() 
	{
		super();
		this.addTestClass(AsyncCheckoutTest);
		this.addTestClass(AsyncHandlerTest);
		this.addTestClass(TestWithAsyncsTest);
	}
	
}
	
}
