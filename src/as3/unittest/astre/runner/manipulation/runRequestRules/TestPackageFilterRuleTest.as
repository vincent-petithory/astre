package astre.runner.manipulation.runRequestRules 
{

import astre.core.Assertion;
import astre.runner.RunRequest;
import astre.runner.runnerTestClasses.packageone.POneFakeTest;
import astre.runner.runnerTestClasses.packagethree.PThreeFakeTest;
import astre.runner.runnerTestClasses.packagetwo.PTwoFakeTest;
import astre.runner.runnerTestClasses.TopFakeTest;
import astre.core.Test;
import astre.core.TestList;
	

public class TestPackageFilterRuleTest extends Test
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var runRequest:RunRequest;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------


	public function TestPackageFilterRuleTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function filter1Test():void
	{
		var list:TestList = new TestList();
		list.addTest(new PThreeFakeTest());
		list.addTestClass(POneFakeTest);
		runRequest = RunRequest.create(
					new TopFakeTest(), 
					list, 
					PTwoFakeTest);
					
		var filteredRequest:RunRequest = runRequest.filter(
			new TestPackageFilterRule("packagetwo")
		);
		
		var tests:Array = runRequest.tests;
		var filteredTests:Array = filteredRequest.tests;
		assertEquals(1, filteredTests.length);
		assertEquals(tests[3].toString(), filteredTests[0].toString());
	}
	
	public function filter2Test():void
	{
		var list:TestList = new TestList();
		list.addTest(new PThreeFakeTest());
		list.addTestClass(POneFakeTest);
		runRequest = RunRequest.create(
					new TopFakeTest(), 
					list, 
					PTwoFakeTest);
					
		var filteredRequest:RunRequest = runRequest.filter(
			new TestPackageFilterRule("astre.runner.runnerTestClasses")
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
