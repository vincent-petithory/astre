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
import astre.core.Test;
import astre.core.AtomicResult;
import astre.runner.TestEvent;
import astre.runner.TestProgressEvent;
import flash.events.EventDispatcher;

/**
 * A <code class="prettyprint">ProgressNotifier</code> is an 
 * implementation of the 
 * <code class="prettyprint">IProgressNotifier</code> interface.
 * 
 * @see astre.runner.IProgressNotifier See astre.runner.IProgressNotifier 
 * for more information on how to use this class.
 * 
 * @author lunar
 * 
 */
public class ProgressNotifier extends EventDispatcher implements IProgressNotifier
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function ProgressNotifier() 
	{
		super();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	public function notifyTestStarted(test:Test):void
	{
		this.dispatchEvent(new TestEvent(TestEvent.TEST_START, test, null));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyTestEnded(test:Test, result:AtomicResult):void
	{
		this.dispatchEvent(new TestEvent(TestEvent.TEST_END, test, result));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyTestProgress(	test:Test, 
										processPhase:ETestProcessPhase, 
										processesRun:uint, 
										processesTotal:uint
									):void
	{
		this.dispatchEvent(new TestProgressEvent(
									TestProgressEvent.TEST_PROGRESS, 
									test, processPhase, 
									processesRun, processesTotal
								));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyRunEnd(runner:ITestRunner):void
	{
		this.dispatchEvent(new RunEvent(RunEvent.RUN_END, runner));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyRunStart(runner:ITestRunner):void
	{
		this.dispatchEvent(new RunEvent(RunEvent.RUN_START, runner));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyRunPause(runner:ITestRunner):void
	{
		this.dispatchEvent(new RunEvent(RunEvent.RUN_PAUSE, runner));
	}
	
	/**
	 * @inheritDoc
	 */
	public function notifyRunResume(runner:ITestRunner):void
	{
		this.dispatchEvent(new RunEvent(RunEvent.RUN_RESUME, runner));
	}
	
}

}