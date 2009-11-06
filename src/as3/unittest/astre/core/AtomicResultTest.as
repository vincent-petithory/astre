package astre.core 
{
	import astre.core.Assertion;
	import astre.core.Test;
	import flash.display.Sprite;

public class AtomicResultTest extends Test
{
	private var resultPassed:AtomicResult;
	private var resultFailure:AtomicResult;
	private var resultError:AtomicResult;
	
	public function AtomicResultTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		resultPassed = new AtomicResult(EResultType.PASSED, null);
		resultFailure = new AtomicResult(EResultType.FAILURE, null);
		resultError = new AtomicResult(EResultType.UNEXPECTED_ERROR, null);
	}
	
	override public function tearDown():void 
	{
		resultPassed = null;
		resultFailure = null;
		resultError = null;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function bestMergePTest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.PASSED, null);
		result.bestMerge(resultPassed);
		assertEquals(result.type, EResultType.PASSED);
		result.bestMerge(resultFailure);
		assertEquals(result.type, EResultType.PASSED);
		result.bestMerge(resultError);
		assertEquals(result.type, EResultType.PASSED);
	}
	
	public function bestMergeFTest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.FAILURE, null);
		result.bestMerge(resultFailure);
		assertEquals(result.type, EResultType.FAILURE);
		result.bestMerge(resultError);
		assertEquals(result.type, EResultType.FAILURE);
		result.bestMerge(resultPassed);
		assertEquals(result.type, EResultType.PASSED);
	}
	
	public function bestMergeETest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.UNEXPECTED_ERROR, null);
		result.bestMerge(resultError);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
		result.bestMerge(resultFailure);
		assertEquals(result.type, EResultType.FAILURE);
		result.bestMerge(resultPassed);
		assertEquals(result.type, EResultType.PASSED);
	}
	
	public function worstMergePTest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.PASSED, null);
		result.worstMerge(resultPassed);
		assertEquals(result.type, EResultType.PASSED);
		result.worstMerge(resultFailure);
		assertEquals(result.type, EResultType.FAILURE);
		result.worstMerge(resultError);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
	}
	
	public function worstMergeFTest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.FAILURE, null);
		result.worstMerge(resultPassed);
		assertEquals(result.type, EResultType.FAILURE);
		result.worstMerge(resultFailure);
		assertEquals(result.type, EResultType.FAILURE);
		result.worstMerge(resultError);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
	}
	
	public function worstMergeETest():void
	{
		var result:AtomicResult = new AtomicResult(EResultType.UNEXPECTED_ERROR, null);
		result.worstMerge(resultPassed);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
		result.worstMerge(resultFailure);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
		result.worstMerge(resultError);
		assertEquals(result.type, EResultType.UNEXPECTED_ERROR);
	}
	
}
	
}
