package 
{
	
	import astre.api.*;

	public class AllTests
	{
		public static function suite():TestSuite
		{
			var suite:TestSuite = new TestSuite();
			var n:int = 500;
			while (--n>-1)
				suite.add(new SimpleTest("testAddOk"));
			
			return suite;
		}
	
	}

}
