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

package astre.core.processor 
{
	import astre.core.Astre;
	import astre.core.AtomicResult;
	import astre.api.Test;
	import astre.core.IProgressNotifier;
	import flash.events.EventDispatcher;

/**
 * The <code class="prettyprint">AbstractTestProcessor</code> is the base 
 * implementation of the <code class="prettyprint">ITestProcessor</code> 
 * interface. It helps creating test processor classes by providing implemented 
 * methods and empty stubs.
 * 
 * @see ITestProcessor
 * 
 * @author lunar
 * 
 */
public class AbstractTestProcessor extends EventDispatcher implements ITestProcessor
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private static var hasRunningProcessesFilter:Function = function(
																item:*, 
																index:int, 
																array:Array
															):Boolean
	{
		return (item as ITestProcess).isRunning;
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">Test</code> this 
	 * <code class="prettyprint">AbstractTestProcessor</code> is 
	 * processing.
	 */
	protected var _test:Test;
	
	/**
	 * The <code class="prettyprint">IProgressNotifier</code> used by this 
	 * <code class="prettyprint">ITestProcessor</code>.
	 */
	protected var _progressNotifier:IProgressNotifier;
	
	/**
	 * @inheritDoc
	 */
	public function get test():Test { return _test; }
	
	/**
	 * The sorted array that stores the processes that have been, 
	 * are being or will be run by this 
	 * <code class="prettyprint">AbstractTestProcessor</code>.
	 */
	protected var processes:Array; /* of ITestProcess */
	
	/**
	 * @inheritDoc
	 */
	public function get idleProcesses():uint
	{
		return 	this.processes.length - 
				processes.filter(hasRunningProcessesFilter).length;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get numProcesses():uint
	{
		var np:uint = processes.length;
		// Note there are always a minimum of 3 processes
		// which are setUp, mainMethod and tearDown.
		// Nevertheless, they are not known until we start processing them, 
		// that's why we explicitly return a minimum of 3 processes.
		return np < 3 ? 3 : np;
	}
	
	/**
	 * The result object this 
	 * <code class="prettyprint">AbstractTestProcessor</code> will fill 
	 * while running processes.
	 * 
	 * @see astre.core.AtomicResult
	 * 
	 */
	protected var result:AtomicResult;
	
	/**
	 * The <code class="prettyprint">SyncPhasesRun</code> of this 
	 * <code class="prettyprint">AbstractTestProcessor</code>.
	 * 
	 * @see SyncPhasesRun
	 */
	protected var syncPhasesRun:SyncPhasesRun;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * Uses the <code class="prettyprint">IProgressNotifier</code> 
	 * of the runner of the test being run.
	 * 
	 * @param test The <code class="prettyprint">Test</code> this 
	 * <code class="prettyprint">AbstractTestProcessor</code> will 
	 * process.
	 */
	public function AbstractTestProcessor(test:Test) 
	{
		super();
		this._test = test;
		_progressNotifier = this._test.Astre::runner.progressNotifier;
		processes = new Array();
		syncPhasesRun = new SyncPhasesRun();
		
		this.addEventListener(
				TestProcessorInstructionEvent.INSTRUCTION, 
				onInstruction
			);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Registers and run the specified process.
	 * 
	 * @param process The process to be run.
	 * 
	 * @see ITestProcess
	 * 
	 */
	protected function registerAndRun(process:ITestProcess):void {}
	
	/**
	 * Reports the result of the specified process and merges it with 
	 * the global result of this 
	 * <code class="prettyprint">AbstractTestProcessor</code>.
	 * 
	 * @param process The process whose result is to be reported.
	 * 
	 * @see #result
	 * @see ITestProcess
	 * @see astre.core.AtomicResult
	 * 
	 */
	protected function reportResult(process:ITestProcess):void
	{
		if (result == null)
		{
			result = process.testProcessResult;
		}
		else
		{
			result.worstMerge(process.testProcessResult);
		}
	}
	
	/**
	 * Empty stub. This method is called every time this 
	 * <code class="prettyprint">AbstractTestProcessor</code> receives 
	 * an instruction by a 
	 * <code class="prettyprint">TestProcessorInstructionEvent.INSTRUCTION</code> 
	 * event.
	 * 
	 * <p>Override it to filter instructions, do pre-processing 
	 * algorithms or simply execute the specified instruction.</p>
	 * 
	 * @param event The event carrying the instruction.
	 * 
	 * @see TestProcessorInstructionEvent
	 * @see TestProcessorInstruction
	 * 
	 */
	protected function onInstruction(event:TestProcessorInstructionEvent):void
	{
		
	}
	
	/**
	 * Tells the <code class="prettyprint">IProgressNotifier</code> of this 
	 * <code class="prettyprint">AbstractTestProcessor</code> to 
	 * check if all processes are finished, and if true, to notify it.
	 * 
	 * @see #_progressNotifier
	 */
	protected function notifyAllProcessesEnd():void
	{
		if (!this.hasRunningProcesses())
		{
			_progressNotifier.notifyTestEnded(this._test, result);
		}
	}
	
	/**
	 * Runs this <code class="prettyprint">AbstractTestProcessor</code>.
	 * 
	 * <p>This implementation is an empty stub. Generally, you override it 
	 * and create an instruction to be executed by this 
	 * <code class="prettyprint">AbstractTestProcessor</code>.
	 * <br/>
	 * You can also keep it empty and pass an instruction to this 
	 * <code class="prettyprint">AbstractTestProcessor</code> from 
	 * an external object using the 
	 * <code class="prettyprint">execute()</code> method.
	 * 
	 * @see #execute()
	 * @see TestProcessorInstruction
	 * 
	 */
	public function run():void {}
	
	/**
	 * @inheritDoc
	 */
	public function execute(instruction:TestProcessorInstruction):void
	{
		this.dispatchEvent(
				new TestProcessorInstructionEvent(
					TestProcessorInstructionEvent.INSTRUCTION, 
					instruction
				)
			);
	}
	
	/**
	 * @inheritDoc
	 */
	public function hasRunningProcesses():Boolean
	{
		return processes.some(hasRunningProcessesFilter);
	}
	
}
	
}
