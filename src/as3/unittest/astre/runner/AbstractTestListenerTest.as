package astre.runner 
{
	import astre.core.Test;
	import astre.processor.IProgressNotifier;
	import flash.events.Event;
	import flash.utils.setTimeout;

public class AbstractTestListenerTest extends Test
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var runner:ITestRunner;
	private var listener:ITestListener;
	private var functionCalled:Object;
	private var notifier:IProgressNotifier;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AbstractTestListenerTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	//------------------------------
	// Overrides
	//------------------------------
	
	override public function setUp():void 
	{
		runner = new TestRunner();
		notifier = runner.progressNotifier;
		functionCalled = {};
		functionCalled[RunEvent.RUN_START] = false;
		functionCalled[RunEvent.RUN_END] = false;
		functionCalled[RunEvent.RUN_PAUSE] = false;
		functionCalled[RunEvent.RUN_RESUME] = false;
		functionCalled[TestEvent.TEST_START] = false;
		functionCalled[TestEvent.TEST_END] = false;
		functionCalled[TestProgressEvent.TEST_PROGRESS] = false;
		
		listener = new TestListenerTest(this.functionCalled);
	}
	
	override public function tearDown():void 
	{
		runner = null;
		listener = null;
		functionCalled = null;
		notifier = null;
	}
	
	//------------------------------
	// Test methods
	//------------------------------
	
	public function checkAllListenerMethodsCalledTest():void
	{
		listener.registerToNotifier(notifier, 10);
		
		this.addAsync(1000, notifier, RunEvent.RUN_START, generalAsyncFunction, true);
		this.addAsync(15000, notifier, RunEvent.RUN_END, generalAsyncFunction, true);
		this.addAsync(4000, notifier, RunEvent.RUN_PAUSE, generalAsyncFunction, true);
		this.addAsync(8000, notifier, RunEvent.RUN_RESUME, generalAsyncFunction, true);
		this.addAsync(1000, notifier, TestEvent.TEST_START, generalAsyncFunction, true);
		this.addAsync(7000, notifier, TestEvent.TEST_END, generalAsyncFunction, true);
		this.addAsync(2000, notifier, TestProgressEvent.TEST_PROGRESS, generalAsyncFunction, true);
		
		setTimeout(pauseOrResume, 3000, true);
		
		runner.runWith(RunRequest.tests(
				new FakeTest("doesNothingButTakesALongTimeToDoIt"), 
				new FakeTest("doesNothingButTakesALongTimeToDoIt"), 
				new FakeTest("doesNothing")
			));
	}
	
	public function checkAllListenerMethodsNotCalledTest():void
	{
		listener.registerToNotifier(notifier, 10);
		listener.unregisterToNotifier(notifier);
		
		this.addAsync(1000, notifier, RunEvent.RUN_START, generalAsyncFunction, false);
		this.addAsync(15000, notifier, RunEvent.RUN_END, generalAsyncFunction, false);
		this.addAsync(4000, notifier, RunEvent.RUN_PAUSE, generalAsyncFunction, false);
		this.addAsync(8000, notifier, RunEvent.RUN_RESUME, generalAsyncFunction, false);
		this.addAsync(1000, notifier, TestEvent.TEST_START, generalAsyncFunction, false);
		this.addAsync(7000, notifier, TestEvent.TEST_END, generalAsyncFunction, false);
		this.addAsync(2000, notifier, TestProgressEvent.TEST_PROGRESS, generalAsyncFunction, false);
		
		setTimeout(pauseOrResume, 3000, true);
		
		runner.runWith(RunRequest.tests(
				new FakeTest("doesNothingButTakesALongTimeToDoIt"), 
				new FakeTest("doesNothingButTakesALongTimeToDoIt"), 
				new FakeTest("doesNothing")
			));
	}
	
	
	//------------------------------
	// Listeners
	//------------------------------
	
	private function pauseOrResume(pause:Boolean):void
	{
		if (pause)
		{
			this.runner.pause();
			setTimeout(pauseOrResume, 2500, false);
		}
		else
		{
			this.runner.resume();
		}
	}
	
	
	private function generalAsyncFunction(event:Event, shouldBeTrue:Boolean):void
	{
		if (shouldBeTrue)
		{
			assertTrue(
					functionCalled[event.type], 
					event.type+" has not been called and that's not what I want"
				);
		}
		else
		{
			assertFalse(
					functionCalled[event.type], 
					event.type+" has been called and I don't want it to"
				);
		}
	}
	
}
	
}

//------------------------------
//
// Internal classes
//
//------------------------------

import astre.core.AtomicResult;
import astre.core.Test;
import astre.processor.process.ETestProcessPhase;
import astre.runner.AbstractTestListener;
import astre.runner.ITestRunner;
import astre.runner.RunEvent;
import astre.runner.TestEvent;
import astre.runner.TestProgressEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

internal class TestListenerTest extends AbstractTestListener
{
	
	private var functionCalled:Object;
	
	public function TestListenerTest(functionCalled:Object)
	{
		super();
		this.functionCalled = functionCalled;
	}
	
	override public function runStart(runner:ITestRunner):void 
	{
		this.functionCalled[RunEvent.RUN_START] = true;
	}
	
	override public function runEnd(runner:ITestRunner):void 
	{
		this.functionCalled[RunEvent.RUN_END] = true;
	}
	
	override public function runPause(runner:ITestRunner):void 
	{
		this.functionCalled[RunEvent.RUN_PAUSE] = true;
	}
	
	override public function runResume(runner:ITestRunner):void 
	{
		this.functionCalled[RunEvent.RUN_RESUME] = true;
	}
	
	override public function testStart(test:Test):void 
	{
		this.functionCalled[TestEvent.TEST_START] = true;
	}
	
	override public function testEnd(test:Test, result:AtomicResult):void 
	{
		this.functionCalled[TestEvent.TEST_END] = true;
	}
	
	override public function testProgress(test:Test, processPhase:ETestProcessPhase, processesRun:uint, processesTotal:uint):void 
	{
		this.functionCalled[TestProgressEvent.TEST_PROGRESS] = true;
	}
	
}

internal class FakeTest extends Test
{
	private var timer:Timer;
	
	public function FakeTest(name:String)
	{
		super(name);
	}
	
	override public function clone():Test 
	{
		return new FakeTest(this.description.method);
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
		timer = new Timer(5000, 1);
		this.addDeferredAsync(6000, timer, TimerEvent.TIMER_COMPLETE, onTimerComplete);
	}
	
	private function onTimerComplete(event:TimerEvent):void
	{
		
	}
	
}

