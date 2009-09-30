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

package astre.core 
{
	import astre.api.Test;
	import astre.core.processor.process.ETestProcessPhase;
	import flash.events.IEventDispatcher;

/**
 * The <code class="prettyprint">IProgressNotifier</code> interface 
 * specifies the behavior of objects that notifies the progress of a 
 * test processing.
 * 
 * 
 * <p>The notification is available at different scales :
 * <ul>
 * <li>The process scale : each process of a test that ends is notified.</li>
 * <li>The test scale : each test that starts or ends is notified.</li>
 * <li>The run scale : beginning, ending, pausing and resuming actions 
 * for a run are notified</li>
 * </ul>
 * </p>
 * 
 * @example
 * This example shows how to use the 
 * <code class="prettyprint">IProgressNotifier</code> 
 * to listen to some test and run events dispatched during the tests 
 * processing. Each time a test processing ends, the result type is checked.
 * If it is an error or a failure, a bip sound is played.
 * <pre class="prettyprint">
 * 
 * package  
 * {
 * 	import astre.core.EResultType;
 * 	import astre.core.processor.IProgressNotifier;
 * 	import astre.runner.ITestRunner;
 * 	import astre.runner.RunRequest;
 * 	import astre.runner.TestEvent;
 * 	import astre.runner.TestRunner;
 * 	import flash.display.Sprite;
 * 	import flash.media.Sound;
 * 	import flash.net.URLRequest;
 * 
 * public class ProgressNotifierExample extends Sprite
 * {
 * 	
 * 	private static const TEST_CLASS:Class = MyTestClass;
 * 	private static var bip:String = "bip.mp3";
 * 	
 * 	public function ProgressNotifierExample() 
 * 	{
 * 		var runner:ITestRunner = new TestRunner();
 * 		var notifier:IProgressNotifier = runner.progressNotifier;
 * 		notifier.addEventListener(TestEvent.TEST_END, onTestEnd);
 * 		
 * 		runner.runWith(RunRequest.testClass(TEST_CLASS));
 * 		
 * 	}
 * 	
 * 	private function onTestEnd(e:TestEvent):void 
 * 	{
 * 		if (e.result.type == EResultType.FAILURE || 
 * 			e.result.type == EResultType.UNEXPECTED_ERROR)
 * 		{
 * 			var s:Sound = new Sound(new URLRequest(bip))
 * 			s.play();
 * 		}
 * 	}
 * 	
 * 	
 * }
 * 	
 * }
 * 
 * </pre>
 * 
 * <p>When designing your own <code class="prettyprint">ITestProcessor</code> 
 * implementation class, you should consider using the  
 * <code class="prettyprint">IProgressNotifier</code> related to 
 * the <code class="prettyprint">ITestRunner</code> to handle 
 * notifications of the test processings.</p>
 * 
 * @see astre.core.Test
 * @see ITestProcess
 * @see ITestProcessor
 * @see astre.runner.ProgressNotifier
 * @see astre.runner.ITestSuiteener
 * 
 * @author lunar
 * 
 */
public interface IProgressNotifier extends IEventDispatcher
{
	
	/**
	 * Notifies that a test starts being processed.
	 * 
	 * @param test The test to be processed.
	 * 
	 * @see astre.core.Test
	 * 
	 */
	function notifyTestStarted(test:Test):void;
	
	/**
	 * Notifies that a test has finished being processed.
	 * 
	 * @param test The test that have been processed.
	 * @param result The result of the process.
	 * 
	 * @see astre.core.Test
	 * @see astre.core.AtomicResult
	 * 
	 */
	function notifyTestEnded(test:Test, result:AtomicResult):void;
	
	/**
	 * Notifies that an internal process of a test processing has 
	 * been completed.
	 * 
	 * @param test The test being processed.
	 * @param processPhase The process phase that have just 
	 * been completed.
	 * @param processesRun The number of processes run 
	 * for this test processing.
	 * @param processesTotal The actual total number of processes 
	 * scheduled for this test processing.
	 * 
	 * @see astre.core.Test
	 * @see astre.core.processor.process.ETestProcessPhase
	 * 
	 */
	function notifyTestProgress(	
						test:Test, 
						processPhase:ETestProcessPhase, 
						processesRun:uint, 
						processesTotal:uint
					):void;
	
	/**
	 * Notifies that the specified 
	 * <code class="prettyprint">ITestRunner</code> has run all its 
	 * requested tests.
	 * 
	 * @param runner The <code class="prettyprint">ITestRunner</code> 
	 * that has just finished running all its 
	 * requested tests.
	 * 
	 * @see astre.runner.ITestRunner
	 * 
	 */
	function notifyRunEnd(runner:ITestRunner):void;
	
	/**
	 * Notifies that the specified 
	 * <code class="prettyprint">ITestRunner</code> starts processing its 
	 * requested tests.
	 * 
	 * @param runner The 
	 * <code class="prettyprint">ITestRunner</code> that 
	 * starts processing its requested tests.
	 * 
	 * @see astre.runner.ITestRunner
	 * 
	 */
	function notifyRunStart(runner:ITestRunner):void;
	
	/**
	 * Notifies that the specified 
	 * <code class="prettyprint">ITestRunner</code> has being paused 
	 * while processing its tests.
	 * 
	 * @param runner The runner that have been paused.
	 * 
	 * @see astre.runner.ITestRunner
	 * 
	 */
	function notifyRunPause(runner:ITestRunner):void;
	
	/**
	 * Notifies that the specified 
	 * <code class="prettyprint">ITestRunner</code> has being resumed 
	 * after having been paused.
	 * 
	 * @param runner The runner that have been resumed.
	 * 
	 * @see astre.runner.ITestRunner
	 * 
	 */
	function notifyRunResume(runner:ITestRunner):void;
	
}
	
}
