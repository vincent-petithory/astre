package astre.runner 
{
	import astre.core.Test;
	import astre.processor.IProgressNotifier;
	import flash.utils.setTimeout;

public class TestRunnerTest extends Test
{
	private var runner:ITestRunner;
	private var expectedTestsRun:uint = 0;
	
	public function TestRunnerTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	// Overrides
	//------------------------------
	
	override public function setUp():void 
	{
		runner = new TestRunner();
	}
	
	override public function tearDown():void 
	{
		runner = null;
	}
	
	//------------------------------
	// isRunningTest
	//------------------------------
	
	public function isRunningTest():void
	{
		assertFalse(runner.isRunning);
		runner.runWith(RunRequest.testClass(RunnerFakeTest));
		assertTrue(runner.isRunning);
		runner.pause();
		assertFalse(runner.isRunning);
		runner.resume();
		assertTrue(runner.isRunning);
		runner.terminate();
		assertFalse(runner.isRunning);
	}
	
	//------------------------------
	// numTestsRunAndNumTestsTest
	//------------------------------
	
	public function numTestsRunAndNumTestsTest():void
	{
		var pn:IProgressNotifier = runner.progressNotifier;
		this.addAsync(4000, pn, TestEvent.TEST_END, onTestEnd);
		this.addDeferredAsync(10000, pn, RunEvent.RUN_END, onRunEndWhoCheckNumTestsRun);
		runner.runWith(RunRequest.testClass(RunnerFakeTest));
	}
	
	private function onRunEndWhoCheckNumTestsRun(event:RunEvent):void
	{
		assertEquals(runner.numTests, runner.numTestsRun);
	}
	
	private function onTestEnd(event:TestEvent):void 
	{
		expectedTestsRun++;
		assertEquals(expectedTestsRun, runner.numTestsRun);
		if (runner.numTestsRun < runner.numTests)
		{
			this.addAsync(4000, runner.progressNotifier, TestEvent.TEST_END, onTestEnd);
		}
	}
	
	//------------------------------
	// pauseTest
	//------------------------------
	
	public function pauseTest():void
	{
		var pn:IProgressNotifier = runner.progressNotifier;
		this.addDeferredAsync(7000, pn, RunEvent.RUN_END, onRunEndExpectedNotCalled, null, runEndNotCalledFunction);
		runner.runWith(RunRequest.testClass(RunnerFakeTest));
		setTimeout(applyRunnerMethod, 500, "pause");
	}
	
	private function onRunEndExpectedNotCalled(event:RunEvent):void
	{
		fail("I should not have been called");
	}
	
	private function runEndNotCalledFunction():void
	{
		runner.terminate();
	}
	
	//------------------------------
	// resumeTest
	//------------------------------
	
	public function resumeTest():void
	{
		var pn:IProgressNotifier = runner.progressNotifier;
		this.addDeferredAsync(9000, pn, RunEvent.RUN_END, onRunEndWhoCheckNumTestsRun);
		runner.runWith(RunRequest.testClass(RunnerFakeTest));
		setTimeout(applyRunnerMethod, 500, "pause");
		setTimeout(applyRunnerMethod, 2000, "resume");
	}
	
	//------------------------------
	// terminateTest
	//------------------------------
	
	public function terminateTest():void
	{
		var pn:IProgressNotifier = runner.progressNotifier;
		this.addAsync(2000, pn, RunEvent.RUN_END, onRunEndNotComplete);
		runner.runWith(RunRequest.testClass(RunnerFakeTest));
		setTimeout(applyRunnerMethod, 500, "terminate");
	}
	
	private function onRunEndNotComplete(event:RunEvent):void
	{
		assertNotEquals(runner.numTests, runner.numTestsRun);
	}
	
	//------------------------------
	// Shared functions
	//------------------------------
	
	private function applyRunnerMethod(method:String, args:Array = null):void
	{
		(runner[method] as Function).apply(runner, args);
	}
	
}
	
}

import astre.core.Test;
import flash.events.Event;

//------------------------------
//
// Internal classes
//
//------------------------------

internal class RunnerFakeTest extends Test
{
	
	public function RunnerFakeTest(name:String)
	{
		super(name);
	}
	
	override public function clone():Test 
	{
		return new RunnerFakeTest(this.description.method);
	}
	
	public function testThatFails():void
	{
		fail("I want to fail");
	}
	
	public function testThatHasAnError():void
	{
		var array:Array;
		array.push("this won't work");
	}
	
	public function doesNothing():void
	{
		
	}
	
	public function doesNothingButTakesALongTimeToDoIt():void
	{
		this.addDeferredAsync(3000, this.helpDispatcher, "neverDispatchEvent", onEventMiraculouslyDispatched);
	}
	
	private function onEventMiraculouslyDispatched(event:Event):void
	{
		
	}
	
}

