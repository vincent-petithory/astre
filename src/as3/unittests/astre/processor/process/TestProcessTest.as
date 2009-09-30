package astre.processor.process 
{
	import astre.core.Assertion;
	import astre.core.Test;
	import astre.processor.ITestProcess;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

public class TestProcessTest extends Test
{
	private var time:int;
	private var process:ITestProcess;
	
	public function TestProcessTest(name:String) 
	{
		super(name);
	}
	
	public function eventsTest():void
	{
		time = getTimer();
		process = new XTestProcess();
		this.addAsync(750, process, TestProcessEvent.TEST_PROCESS_START, onProcess);
		this.addAsync(2500, process, TestProcessEvent.TEST_PROCESS_END, onProcess);
		process.run();
	}
	
	private function onProcess(e:TestProcessEvent):void 
	{
		if (e.type == TestProcessEvent.TEST_PROCESS_START)
		{
			assertTrue(e.testProcess.isRunning);
		}
		else if (e.type == TestProcessEvent.TEST_PROCESS_END)
		{
			assertFalse(e.testProcess.isRunning);
			var timeElapsed:int = getTimer() - time;
			assertApproximate(
				e.testProcess.testProcessResult.runtime, 
				timeElapsed, 
				200
			);
		}
	}
	
}
	
}
import astre.core.Assertion;
import astre.core.Test;
import astre.processor.process.TestProcess;

internal class XTest extends Test
{
	public function XTest(name:String)
	{
		super(name);
	}
	
	public function xMethod():void
	{
		for (var i:uint = 0 ; i < 5000000 ; i++)
		{
		}
		assertFalse(false);
	}
}

internal class XTestProcess extends TestProcess
{
	
	public function XTestProcess()
	{
		super(new XTest("xMethod"), null);
	}
	
	override public function run():void 
	{
		super.run();
		runEnd();
	}
}