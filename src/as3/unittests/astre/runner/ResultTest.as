package astre.runner 
{
	import astre.core.Assertion;
	import astre.core.AtomicResult;
	import astre.core.EResultType;
	import astre.runner.manipulation.resultRules.ResultTypeSortRule;
	import astre.runner.manipulation.resultRules.TestDescriptionSortRule;
	import astre.core.Test;

public class ResultTest extends Test
{
	private var result:Result;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function ResultTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	override public function setUp():void 
	{
		result = new Result();
	}
	
	override public function tearDown():void 
	{
		result = null;
	}
	
	public function addAtomicResultTest():void
	{
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		assertEquals(result.numResults, 1);
	}
	
	public function isSuccessfulTest():void
	{
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.IGNORED, null));
		
		assertTrue(result.isSuccessful);
		
		result.addAtomicResult(new AtomicResult(EResultType.FAILURE, null));
		
		assertFalse(result.isSuccessful);
		
		result = result.getResults(Result.PASSED | Result.IGNORED);
		assertTrue(result.isSuccessful);
		result.addAtomicResult(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
		assertFalse(result.isSuccessful);
	}
	
	public function totalRuntimeTest():void
	{
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 200));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 400));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 300));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 250));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 150));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null, null, 950));
		
		assertEquals(2250, result.totalRuntime);
	}
	
	public function numResultsTest():void
	{
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		result.addAtomicResult(new AtomicResult(EResultType.PASSED, null));
		
		assertEquals(6, result.numResults);
	}
	
	public function getResultsTest():void
	{
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
		
		var nothing:Result = result.getResults(Result.NOTHING);
		assertEquals(0, nothing.numResults);
		
		var all:Result = result.getResults();
		assertEquals(10, all.numResults);
		
		var pfe:Result = result.getResults(Result.PASSED | Result.FAILURES | Result.ERRORS);
		assertEquals(6, pfe.numResults);
		assertFalse(pfe.isSuccessful);
		
		var pfi:Result = result.getResults(Result.PASSED | Result.FAILURES | Result.IGNORED);
		assertEquals(7, pfi.numResults);
		assertFalse(pfi.isSuccessful);
		
		var pei:Result = result.getResults(Result.PASSED | Result.ERRORS | Result.IGNORED);
		assertEquals(8, pei.numResults);
		assertFalse(pei.isSuccessful);
		
		var fei:Result = result.getResults(Result.FAILURES | Result.ERRORS | Result.IGNORED);
		assertEquals(9, fei.numResults);
		assertFalse(fei.isSuccessful);
		
		var pf:Result = result.getResults(Result.PASSED | Result.FAILURES);
		assertEquals(3, pf.numResults);
		assertFalse(pf.isSuccessful);
		
		var pe:Result = result.getResults(Result.PASSED | Result.ERRORS);
		assertEquals(4, pe.numResults);
		assertFalse(pe.isSuccessful);
		
		var pi:Result = result.getResults(Result.PASSED | Result.IGNORED);
		assertEquals(5, pi.numResults);
		assertTrue(pi.isSuccessful);
		
		var fe:Result = result.getResults(Result.FAILURES | Result.ERRORS);
		assertEquals(5, fe.numResults);
		assertFalse(fe.isSuccessful);
		
		var fi:Result = result.getResults(Result.FAILURES | Result.IGNORED);
		assertEquals(6, fi.numResults);
		assertFalse(fi.isSuccessful);
		
		var ei:Result = result.getResults(Result.ERRORS | Result.IGNORED);
		assertEquals(7, ei.numResults);
		assertFalse(ei.isSuccessful);
		
		var p:Result = result.getResults(Result.PASSED);
		assertEquals(1, p.numResults);
		assertTrue(p.isSuccessful);
		
		var f:Result = result.getResults(Result.FAILURES);
		assertEquals(2, f.numResults);
		assertFalse(f.isSuccessful);
		
		var e:Result = result.getResults(Result.ERRORS);
		assertEquals(3, e.numResults);
		assertFalse(e.isSuccessful);
		
		var i:Result = result.getResults(Result.IGNORED);
		assertEquals(4, i.numResults);
		assertTrue(i.isSuccessful);
	}
	
}
	
}
