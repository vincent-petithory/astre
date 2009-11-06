package astre.runner.manipulation.resultRules 
{

import astre.core.Assertion;
import astre.core.AtomicResult;
import astre.core.EResultType;
import astre.runner.Result;
import astre.runner.runnerTestClasses.packageone.POneFakeTest;
import astre.runner.runnerTestClasses.packagethree.PThreeFakeTest;
import astre.runner.runnerTestClasses.packagetwo.PTwoFakeTest;
import astre.runner.runnerTestClasses.TopFakeTest;
import astre.core.Test;
	

public class TestDescriptionSortRuleTest extends Test
{
	
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var result:Result;
	
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
	
	public function testDescriptionSortRule():void
	{
		result = new Result();
		
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, new POneFakeTest().description));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, new PTwoFakeTest().description));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, new PThreeFakeTest().description));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, new TopFakeTest().description));
		
		result.sort(new TestDescriptionSortRule());
		
		var expectedResult:Result = new Result();
		expectedResult.addAtomicResult(new AtomicResult(EResultType.PASSED, new TopFakeTest().description));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.PASSED, new POneFakeTest().description));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.PASSED, new PThreeFakeTest().description));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.PASSED, new PTwoFakeTest().description));
		
		var resultArray:Array = result.toArray();
		var expectedResultArray:Array = expectedResult.toArray();
		
		assertEquals(expectedResultArray.length, resultArray.length);
		var l:uint = resultArray.length;
		
		for (var i:uint = 0 ; i < l ; i++)
		{
			assertEquals(
				(expectedResultArray[i] as AtomicResult).testDescription.getDisplay(), 
				(resultArray[i] as AtomicResult).testDescription.getDisplay()
			);
		}
		expectedResult = null;
	}
	
	
}

}
