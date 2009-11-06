package
{
	
	import flash.display.Sprite;
	import astre.api.CLITestRunner;
	import astre.api.TestSuite;
	import tests.SampleTest;
	
	public class SamplesRunner extends Sprite
	{
		public function SamplesRunner()
		{
		    var suite:TestSuite = new TestSuite();
			suite.addTest(SampleTest);
			
			CLITestRunner.run(suite);
		}
	}

}
