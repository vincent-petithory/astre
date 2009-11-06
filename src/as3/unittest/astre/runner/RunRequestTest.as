package astre.runner 
{
	import astre.core.Assertion;
	import astre.runner.manipulation.RunRequestFilterRule;
	import astre.runner.manipulation.runRequestRules.TestDescriptionSortRule;
	import astre.runner.runnerTestClasses.packageone.POneFakeTest;
	import astre.runner.runnerTestClasses.packagethree.PThreeFakeTest;
	import astre.runner.runnerTestClasses.packagetwo.PTwoFakeTest;
	import astre.runner.runnerTestClasses.TopFakeTest;
	import astre.core.Test;
	import astre.core.TestError;
	import astre.core.TestList;

public class RunRequestTest extends Test
{
	private var runRequest:RunRequest;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function RunRequestTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function testConstructorTest():void
	{
		runRequest = RunRequest.create(
					new TopFakeTest(), 
					new POneFakeTest(), 
					new PTwoFakeTest(), 
					new PThreeFakeTest()
				);
				
		assertEquals(4, runRequest.numTests);
	}
	
	public function testListConstructorTest():void
	{
		var list1:TestList = new TestList();
		list1.addTest(new TopFakeTest());
		list1.addTest(new POneFakeTest());
		list1.addTest(new PTwoFakeTest());
		list1.addTest(new PThreeFakeTest());
		
		var list2:TestList = new TestList();
		list2.addTest(new TopFakeTest());
		list2.addTest(new POneFakeTest());
		list2.addTest(new PTwoFakeTest());
		list2.addTest(new PThreeFakeTest());
		
		runRequest = RunRequest.create(list1, list2);
		
		assertEquals(8, runRequest.numTests);
	}
	
	public function testClassConstructorTest():void
	{
		runRequest = RunRequest.create(
					TopFakeTest, 
					POneFakeTest, 
					PTwoFakeTest, 
					PThreeFakeTest
				);
				
		assertEquals(4, runRequest.numTests);
	}
	
	public function badConstructorArgumentTest():void
	{
		var flag:Boolean = false;
		try
		{
			runRequest = RunRequest.create(new TestError("about to fail", null));
		} catch (ae:ArgumentError)
		{
			flag = true;
		}
		finally
		{
			assertTrue(flag, "Exception in RunRequest constructor was not caught");
		}
		
	}
	
	public function heterogeneousConstructorTest():void
	{
		var list:TestList = new TestList();
		list.addTest(new PThreeFakeTest());
		list.addTestClass(POneFakeTest);
		runRequest = RunRequest.create(
					new TopFakeTest(), 
					list, 
					PTwoFakeTest);
		
		assertEquals(4, runRequest.numTests);
	}
	
	public function cloneTest():void
	{
		runRequest = RunRequest.create(new TopFakeTest());
		var cloneRunRequest:RunRequest = runRequest.clone();
		
		assertEquals(runRequest.tests.length, cloneRunRequest.tests.length);
	}
	
	public function filterTest():void
	{
		var list:TestList = new TestList();
		list.addTest(new PThreeFakeTest());
		list.addTestClass(POneFakeTest);
		runRequest = RunRequest.create(
					new TopFakeTest(), 
					list, 
					PTwoFakeTest);
					
		var filteredRequest:RunRequest = runRequest.filter(
			new RunRequestFilterRule() /* this filter does nothing*/
		);
		
		var tests:Array = runRequest.tests;
		var filteredTests:Array = filteredRequest.tests;
		assertEquals(tests.length, filteredTests.length);
		
		var length:uint = tests.length;
		for (var i:uint = 0 ; i < length ; i++)
		{
			assertEquals(tests[i].toString(), filteredTests[i].toString());
		}
	}
	
}
	
}
