package astre.runner.manipulation.resultRules 
{

import astre.core.Assertion;
import astre.core.AtomicResult;
import astre.core.EResultType;
import astre.runner.Result;
import astre.core.Test;
	

public class ResultTypeSortRuleTest extends Test
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


	public function ResultTypeSortRuleTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function resultTypeSortRule():void
	{
		result = new Result();
		
		result.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		result.addAtomicResult(new AtomicResult(EResultType.FAILURE, null));
		result.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		result.addAtomicResult(new AtomicResult(EResultType.FAILURE, null));
		result.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		result.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		result.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		result.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		
		result.sort(new ResultTypeSortRule());
		
		var expectedResult:Result = new Result();
		expectedResult.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.FAILURE, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.FAILURE, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		expectedResult.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		
		var resultArray:Array = result.toArray();
		var expectedResultArray:Array = expectedResult.toArray();
		
		assertEquals(expectedResultArray.length, resultArray.length);
		var l:uint = resultArray.length;
		
		for (var i:uint = 0 ; i < l ; i++)
		{
			assertEquals(
				(expectedResultArray[i] as AtomicResult).type, 
				(resultArray[i] as AtomicResult).type
			);
		}
		expectedResult = null;
	}
	
	
}

}
