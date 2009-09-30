package astre.runner.manipulation.runRequestRules 
{

import astre.core.Assertion;
import astre.runner.runnerTestClasses.packageone.POneFakeTest;
import astre.runner.runnerTestClasses.packagethree.PThreeFakeTest;
import astre.runner.runnerTestClasses.packagetwo.PTwoFakeTest;
import astre.runner.runnerTestClasses.TopFakeTest;
import astre.core.Test;
import astre.runner.RunRequest;
import astre.core.TestList;
	

public class TestDescriptionSortRuleTest extends Test
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


	public function TestDescriptionSortRuleTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function testDescriptionSortRulesortTest():void
	{
		var list:TestList = new TestList();
		list.addTestClass(POneFakeTest);
		list.addTestClass(PTwoFakeTest);
		list.addTestClass(PThreeFakeTest);
		list.addTestClass(TopFakeTest);
					
		runRequest = RunRequest.testList(list);
		
		runRequest.sort(new TestDescriptionSortRule());
		
		
		var expectedList:TestList = new TestList();
		expectedList.addTestClass(TopFakeTest);
		expectedList.addTestClass(POneFakeTest);
		expectedList.addTestClass(PThreeFakeTest);
		expectedList.addTestClass(PTwoFakeTest);
		var expectedSortedTests:Array = expectedList.getTests();
		
		var afterSortTests:Array = runRequest.tests;
		
		assertEquals(expectedSortedTests.length, afterSortTests.length);
		
		var length:uint = expectedSortedTests.length;
		for (var i:uint = 0 ; i < length ; i++)
		{
			assertEquals(expectedSortedTests[i].toString(), 
								afterSortTests[i].toString());
		}
	}
	
}

}
