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
	import astre.core.IProgressNotifier;
	import astre.core.processor.process.ETestProcessPhase;
	import astre.api.Test;
	
/**
 * The <code class="prettyprint">ITestListener</code> interface defines 
 * objects that listens the progress of test processes, 
 * tests and test runners.
 * 
 * <p>Generally, you will use the 
 * <code class="prettyprint">astre.runner.AbstractTestListener</code> 
 * class to create your listeners rather than directly implementing the 
 * <code class="prettyprint">ITestListener</code> interface.<br/> 
 * Using the 
 * <code class="prettyprint">ITestRunner.progressNotifier</code> 
 * property is another way to listen to test process events.</p>
 * 
 * 
 * @see ITestRunner
 * @see astre.core.Test
 * @see astre.core.processor.IProgressNotifier
 * 
 * @author lunar
 * 
 */
public interface ITestListener 
{
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a run start by calling its 
	 * <code class="prettyprint">notifyRunStart()</code> method.
	 * 
	 * @param runner The 
	 * <code class="prettyprint">ITestRunner</code> that 
	 * starts processing its requested tests.
	 * 
	 */
	function runStart(runner:ITestRunner):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a run end by calling its 
	 * <code class="prettyprint">notifyRunEnd()</code> method.
	 * 
	 * @param runner The <code class="prettyprint">ITestRunner</code> 
	 * that has just finished running all its 
	 * requested tests.
	 * 
	 */
	function runEnd(runner:ITestRunner):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a pause action by calling its 
	 * <code class="prettyprint">notifyRunPause()</code> method.
	 * 
	 * @param runner The runner that have been paused.
	 * 
	 */
	function runPause(runner:ITestRunner):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a resume action by calling its 
	 * <code class="prettyprint">notifyRunResume()</code> method.
	 * 
	 * @param runner The runner that have been resumed.
	 * 
	 */
	function runResume(runner:ITestRunner):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a test start by calling its 
	 * <code class="prettyprint">notifyTestStarted()</code> method.
	 * 
	 * @param test The test to be processed.
	 * 
	 */
	function testStart(test:Test):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies a test end by calling its 
	 * <code class="prettyprint">notifyTestEnded()</code> method.
	 * 
	 * @param test The test that have been processed.
	 * 
	 * @see astre.core.AtomicResult
	 * 
	 */
	function testEnd(test:Test, result:AtomicResult):void;
	
	/**
	 * This function is called whenever a registered 
	 * <code class="prettyprint">IProgressNotifier</code> 
	 * notifies that a test process has just ended, by calling its 
	 * <code class="prettyprint">notifyTestProgress()</code> method.
	 * 
	 * @param test The test being processed.
	 * @param processPhase The process phase that have just 
	 * been completed.
	 * @param processesRun The number of processes run 
	 * for this test processing.
	 * @param processesTotal The actual total number of processes 
	 * scheduled for this test processing.
	 * 
	 * @see astre.core.processor.process.ETestProcessPhase
	 * 
	 */
	function testProgress(
						test:Test, 
						processPhase:ETestProcessPhase, 
						processesRun:uint, 
						processesTotal:uint
					):void;
	
	/**
	 * Registers to the specified 
	 * <code class="prettyprint">IProgressNotifier</code> so that 
	 * this <code class="prettyprint">ITestListener</code> can be notified.
	 * 
	 * @param notifier The <code class="prettyprint">IProgressNotifier</code> 
	 * to be registered to.
	 * @param priority Indicates the priority of this 
	 * <code class="prettyprint">ITestListener</code> among 
	 * other <code class="prettyprint">ITestListener</code> that 
	 * share the specified <code class="prettyprint">IProgressNotifier</code>.
	 * <code class="prettyprint">ITestListener</code> objects 
	 * which have registered a 
	 * <code class="prettyprint">IProgressNotifier</code> with a high priority 
	 * value will be notified before those with a low priority value.
	 */
	function registerToNotifier(notifier:IProgressNotifier, priority:int = 0):void;
	
	/**
	 * Unregisters from the specified 
	 * <code class="prettyprint">IProgressNotifier</code> so that 
	 * this <code class="prettyprint">ITestListener</code> is not 
	 * notified anymore.
	 * 
	 * @param notifier The <code class="prettyprint">IProgressNotifier</code> 
	 * to be unregistered from.
	 * 
	 */
	function unregisterFromNotifier(notifier:IProgressNotifier):void;
	
	/**
	 * Checks the specified 
	 * <code class="prettyprint">IProgressNotifier</code> is 
	 * registered by this <code class="prettyprint">ITestListener</code>.
	 * 
	 * @param notifier The notifier to be checked for registration.
	 * @return <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">IProgressNotifier</code> is
	 * registered by this <code class="prettyprint">ITestListener</code>.
	 * Otherwise, <code class="prettyprint">false</code>.
	 */
	function isRegisteredTo(notifier:IProgressNotifier):Boolean;
	
}
	
}
