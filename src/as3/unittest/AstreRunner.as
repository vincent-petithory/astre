package 
{
	import astre.api.TextRunner;
	import astre.core.TestList;
	import astre.core.TestListTest;
	import astre.core.TestTest;
	import astre.printer.ResultPrinter;
	import astre.runner.ITestListener;
	import astre.runner.ITestRunner;
	import astre.runner.manipulation.runRequestRules.TestDescriptionSortRule;
	import astre.runner.RunEvent;
	import astre.runner.RunRequest;
	import astre.runner.TestRunner;
	import astre.runner.TestRunnerTest;
	import astre.util.AllAstreUtilTests;
	import flash.display.Sprite;

public class AstreRunner extends Sprite
{
	
	private var runner:ITestRunner;
	
	public function AstreRunner() 
	{
		super();
		var obj:Object = AllTopLevelTests;
		CLITestRunner.run(new AllTopLevelTests());
	}
	
}
	
}
