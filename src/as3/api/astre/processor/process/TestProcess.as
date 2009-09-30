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

package astre.processor.process 
{
	
	import astre.core.EResultType;
	import astre.processor.ITestProcess;
	import astre.core.Test;
	import astre.processor.TestProcessorInstruction;
	import astre.processor.process.ETestProcessPhase;
	import astre.core.AtomicResult;
	import flash.events.EventDispatcher;
	import flash.system.System;
	import flash.utils.getTimer;

/**
 * A <code class="prettyprint">TestProcess</code> is the base 
 * implementation of the <code class="prettyprint">ITestProcess</code> 
 * interface.
 * 
 * @author lunar
 * 
 */
public class TestProcess extends EventDispatcher implements ITestProcess
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * Returns the time elapsed since the specified milestone.
	 * 
	 * @param o The milestone from which to compute the 
	 * elapsed time.
	 * @return the time elapsed since the specified origin.
	 */
	public static function getRunTimeSince(o:int):int
	{
		return getTimer() - o;
	}
	
	/**
	 * Returns the memory consumed since the specified milestone.
	 * 
	 * @param lastMemory The milestone from which to compute the 
	 * consumed memory.
	 * @return the memory consumed since the specified milestone.
	 */
	public static function getMemoryFrom(lastMemory:uint):Number
	{
		return Number(System.totalMemory - lastMemory);
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _test:Test;
	
	/**
	 * @inheritDoc
	 */
	public function get test():Test
	{
		return _test;
	}
	
	/**
	 * @private
	 */
	private var _testProcessResult:AtomicResult;
	
	/**
	 * @inheritDoc
	 */
	public function get testProcessResult():AtomicResult
	{
		return _testProcessResult;
	}
	
	/**
	 * @private
	 */
	public function set testProcessResult(value:AtomicResult):void 
	{
		_testProcessResult = value;
	}
	
	/**
	 * @private
	 */
	private var _testProcessPhase:ETestProcessPhase;
	
	/**
	 * @inheritDoc
	 */
	public function get testProcessPhase():ETestProcessPhase
	{
		return _testProcessPhase;
	}
	
	/**
	 * @private
	 */
	private var _isRunning:Boolean = false;
	
	/**
	 * @inheritDoc
	 */
	public function get isRunning():Boolean
	{
		return _isRunning;
	}
	
	/**
	 * The time milestone indicating the starting 
	 * time of this <code class="prettyprint">TestProcess</code> 
	 * since Flash Player was started.
	 */
	protected var timeStart:int = 0;
	
	/**
	 * The memory milestone indicating the  
	 * memory state when this 
	 * <code class="prettyprint">TestProcess</code> started.
	 */
	protected var memoryStart:Number = 0;
	
	/**
	 * An optional instruction this 
	 * <code class="prettyprint">TestProcess</code> may send to 
	 * a process listener. Most often, it will be an 
	 * <code class="prettyprint">ITestProcessor</code>.
	 */
	protected var forceCommand:TestProcessorInstruction = null;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor
	 * 
	 * @param test The test from which this 
	 * <code class="prettyprint">ITestProcess</code> is part of.
	 * @param testProcessPhase The phase in which this process participates.
	 */
	public function TestProcess(test:Test, testProcessPhase:ETestProcessPhase) 
	{
		super();
		this._test = test;
		this._testProcessPhase = testProcessPhase;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Boots the execution of this 
	 * <code class="prettyprint">TestProcess</code>.
	 */
	protected function runStart():void
	{
		_isRunning = true;
		// we start considering the test is ok ; 
		// then we look for failures and errors
		this.timeStart = getTimer();
		memoryStart = System.totalMemory;
		this._testProcessResult = new AtomicResult(
										EResultType.PASSED, 
										test.description, 
										null, 
										0
									);
		this.dispatchEvent(new TestProcessEvent(
								TestProcessEvent.TEST_PROCESS_START, 
								this, 
								null
							)
						);
	}
	
	/**
	 * Ends the run of this <code class="prettyprint">TestProcess</code>.
	 */
	protected function runEnd():void
	{
		_isRunning = false;
		this._testProcessResult.runtime = TestProcess.getRunTimeSince(
												this.timeStart
											);
		// Memory records sometimes give weird results. They may be removed
		// in the future
		this._testProcessResult.memoryVariation = TestProcess.getMemoryFrom(
													this.memoryStart
												);
		this.dispatchEvent(new TestProcessEvent(
								TestProcessEvent.TEST_PROCESS_END, 
								this, 
								forceCommand
							)
						);
	}
	
	/**
	 * Runs this <code class="prettyprint">TestProcess</code>.
	 */
	public function run():void
	{
		runStart();
	}
	
}
	
}
