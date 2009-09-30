package astre.core 
{
	import astre.core.Assertion;
	import astre.core.EResultType;
	import astre.core.Test;

public class EResultTypeTest extends Test
{
	
	public function EResultTypeTest(name:String) 
	{
		super(name);
	}
	
	public function ordinalsTest():void
	{
		assertEquals(0, EResultType.PASSED.compareTo(EResultType.PASSED))
		assertEquals(-1, EResultType.PASSED.compareTo(EResultType.FAILURE));
		assertEquals(-2, EResultType.PASSED.compareTo(EResultType.UNEXPECTED_ERROR));
		assertEquals(1, EResultType.FAILURE.compareTo(EResultType.PASSED));
		assertEquals(0, EResultType.FAILURE.compareTo(EResultType.FAILURE));
		assertEquals(-1, EResultType.FAILURE.compareTo(EResultType.UNEXPECTED_ERROR));
		assertEquals(2, EResultType.UNEXPECTED_ERROR.compareTo(EResultType.PASSED));
		assertEquals(1, EResultType.UNEXPECTED_ERROR.compareTo(EResultType.FAILURE));
		assertEquals(0, EResultType.UNEXPECTED_ERROR.compareTo(EResultType.UNEXPECTED_ERROR));
	}
	
}
	
}
