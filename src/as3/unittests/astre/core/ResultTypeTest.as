package astre.core 
{
	import astre.core.Assertion;
	import astre.core.ResultType;
	import astre.core.Test;

public class ResultTypeTest extends Test
{
	
	public function ResultTypeTest(name:String) 
	{
		super(name);
	}
	
	public function ordinalsTest():void
	{
		assertEquals(0, ResultType.PASSED.compareTo(ResultType.PASSED))
		assertEquals(-1, ResultType.PASSED.compareTo(ResultType.FAILURE));
		assertEquals(-2, ResultType.PASSED.compareTo(ResultType.UNEXPECTED_ERROR));
		assertEquals(1, ResultType.FAILURE.compareTo(ResultType.PASSED));
		assertEquals(0, ResultType.FAILURE.compareTo(ResultType.FAILURE));
		assertEquals(-1, ResultType.FAILURE.compareTo(ResultType.UNEXPECTED_ERROR));
		assertEquals(2, ResultType.UNEXPECTED_ERROR.compareTo(ResultType.PASSED));
		assertEquals(1, ResultType.UNEXPECTED_ERROR.compareTo(ResultType.FAILURE));
		assertEquals(0, ResultType.UNEXPECTED_ERROR.compareTo(ResultType.UNEXPECTED_ERROR));
	}
	
}
	
}
