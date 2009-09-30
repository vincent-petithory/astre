////////////////////////////////////////////////////////////////////////////
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
// 
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
// 
// The Original Code is Astre framework.
// 
// The Initial Developer of the Original Code is 
// Vincent Petithory   "vincent.petithory@gmail.com".
// Portions created by the Initial Developer are Copyright (C) 2008-2009 
// the Initial Developer. All Rights Reserved.
// 
// Contributor(s): 
////////////////////////////////////////////////////////////////////////////

package astre.runner 
{
	
	import astre.processor.IProgressNotifier;
	import astre.processor.process.ETestProcessPhase;
	import astre.runner.ITestRunner;
	import astre.core.AtomicResult;
	import astre.core.Test;
	import astre.runner.TestEvent;
	import astre.runner.TestProgressEvent;

/**
 * The <code class="prettyprint">AbstractTestListener</code> is 
 * the base class for all classes that may listen to the tests progress.
 * 
 * <p>In order to listen to one or more events that may occure while 
 * running tests, you create a class that extends 
 * <code class="prettyprint">astre.runner.AbstractTestListener</code> and 
 * you override the appropriate methods.</p>
 * 
 * @example Here is a simple example of a class that logs some informations : 
 * <pre class="prettyprint">
 * 
 * package 
 * {
 * 	import astre.runner.AbstractTestListener;
 * 	import astre.core.AtomicResult;
 * 	import astre.core.Test;
 * 	import astre.runner.ITestRunner;
 * 
 * public class LogListener extends AbstractTestListener
 * {
 * 	
 * 	public function LogListener() 
 * 	{
 * 		super();
 * 	}
 * 	
 * 	override public function runStart(runner:ITestRunner):void 
 * 	{
 * 		trace("Runner is started and is about to run "+
 * 				runner.numTests+".");
 * 	}
 * 	
 * 	override public function runEnd(runner:ITestRunner):void 
 * 	{
 * 		trace("Runner has finished and has run "+
 * 				runner.numTestsRun+" out of "+runner.numTests+".");
 * 	}
 * 	
 * 	override public function runResume(runner:ITestRunner):void 
 * 	{
 * 		trace("Runner has been resumed.");
 * 	}
 * 	
 * 	override public function runPause(runner:ITestRunner):void 
 * 	{
 * 		trace("Runner has been paused.");
 * 	}
 * 	
 * 	override public function testStart(test:Test):void 
 * 	{
 * 		trace("The process of the "+
 * 				test.description.getDisplay()+" test has begun");
 * 	}
 * 	
 * 	override public function testEnd(test:Test, result:AtomicResult):void 
 * 	{
 * 		trace("The process of the "+
 * 				test.description.getDisplay()+" test has ended with a "+
 * 				result.type.name.toUpperCase()+" result");
 * 	}
 * 	
 * }
 * 	
 * }
 * 
 * </pre>
 * Then, you just need to create an instance of it and register it to 
 * the <code class="prettyprint">IProgressNotifier</code> of the chosen 
 * <code class="prettyprint">ITestRunner</code>.
 * 
 * <pre class="prettyprint">
 * 
 * var runner:ITestRunner = new TestRunner();
 * 
 * var logListener:ITestListener = new LogListener();
 * logListener.registerToNotifier(runner.progressNotifier);
 * 
 * </pre>
 * 
 * <p>You have another way to listen to what is happening while running tests 
 * by creating unit listeners. This way is more interesting when you want to 
 * listen to a specific event and not a great part of them.
 * For more information, see the 
 * <code class="prettyprint">astre.runner.ProgressNotifier</code> class.</p>
 * 
 * @see astre.runner.ProgressNotifier
 * 
 * @author lunar
 * 
 */
public class AbstractTestListener implements ITestListener
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _registeredProgressNotifiers:Array; /* of IProgressNotifier */
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function AbstractTestListener() 
	{
		super();
		_registeredProgressNotifiers = new Array();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	public function runStart(runner:ITestRunner):void {}
	
	/**
	 * @inheritDoc
	 */
	public function runEnd(runner:ITestRunner):void {}
	
	/**
	 * @inheritDoc
	 */
	public function runPause(runner:ITestRunner):void {}
	
	/**
	 * @inheritDoc
	 */
	public function runResume(runner:ITestRunner):void {}
	
	/**
	 * @inheritDoc
	 */
	public function testStart(test:Test):void {}
	
	/**
	 * @inheritDoc
	 */
	public function testEnd(test:Test, result:AtomicResult):void {}
	
	/**
	 * @inheritDoc
	 */
	public function testProgress(
								test:Test, 
								processPhase:ETestProcessPhase, 
								processesRun:uint, 
								processesTotal:uint
							):void {}
							
	/**
	 * @inheritDoc
	 */
	public function registerToNotifier(notifier:IProgressNotifier, priority:int = 0):void
	{
		if (!isRegisteredTo(notifier))
		{
			notifier.addEventListener(TestEvent.TEST_START, onTestStart, 
										false, priority);
			notifier.addEventListener(TestEvent.TEST_END, onTestEnd, 
										false, priority);
			notifier.addEventListener(
										TestProgressEvent.TEST_PROGRESS, 
										onTestProgress, 
										false, priority
									);
			notifier.addEventListener(RunEvent.RUN_START, onRunEvent, 
										false, priority);
			notifier.addEventListener(RunEvent.RUN_END, onRunEvent, 
										false, priority);
			notifier.addEventListener(RunEvent.RUN_PAUSE, onRunEvent, 
										false, priority);
			notifier.addEventListener(RunEvent.RUN_RESUME, onRunEvent, 
										false, priority);
			_registeredProgressNotifiers.push(notifier);
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function unregisterFromNotifier(notifier:IProgressNotifier):void
	{
		if (isRegisteredTo(notifier))
		{
			notifier.removeEventListener(TestEvent.TEST_START, onTestStart);
			notifier.removeEventListener(TestEvent.TEST_END, onTestEnd);
			notifier.removeEventListener(
										TestProgressEvent.TEST_PROGRESS, 
										onTestProgress
									);
			notifier.removeEventListener(RunEvent.RUN_START, onRunEvent);
			notifier.removeEventListener(RunEvent.RUN_END, onRunEvent);
			notifier.removeEventListener(RunEvent.RUN_PAUSE, onRunEvent);
			notifier.removeEventListener(RunEvent.RUN_RESUME, onRunEvent);
			removeNotifier(notifier);
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function isRegisteredTo(progressNotifier:IProgressNotifier):Boolean
	{
		for each (var notifier:IProgressNotifier in _registeredProgressNotifiers)
		{
			if (progressNotifier == notifier)
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * @private
	 */
	private function removeNotifier(progressNotifier:IProgressNotifier):void
	{
		var index:int = _registeredProgressNotifiers.indexOf(progressNotifier);
		while (index != -1)
		{
			_registeredProgressNotifiers.splice(index, 1);
			index = _registeredProgressNotifiers.indexOf(progressNotifier);
		}
	}
	
	/**
	 * @private
	 */
	private function onTestStart(event:TestEvent):void
	{
		testStart(event.test);
	}
	
	/**
	 * @private
	 */
	private function onTestEnd(event:TestEvent):void
	{
		testEnd(event.test, event.result);
	}
	
	/**
	 * @private
	 */
	private function onTestProgress(event:TestProgressEvent):void 
	{
		testProgress(event.test, event.processPhase, event.processesRun, event.processesTotal);
	}
	
	/**
	 * @private
	 */
	private function onRunEvent(event:RunEvent):void
	{
		// RunEvents don't happen as often as TestEvents
		// so it's better to gather all of them in one listener
		if (event.type == RunEvent.RUN_START)
		{
			runStart(event.runner);
		}
		else if (event.type == RunEvent.RUN_END)
		{
			runEnd(event.runner);
		}
		else if (event.type == RunEvent.RUN_PAUSE)
		{
			runPause(event.runner);
		}
		else if (event.type == RunEvent.RUN_RESUME)
		{
			runResume(event.runner);
		}
	}
	
}
	
}
