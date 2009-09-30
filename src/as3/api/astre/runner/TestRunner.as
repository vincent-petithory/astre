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
	import astre.runner.AbstractTestListener;
	import astre.core.Astre;
	import astre.core.AtomicResult;
	import astre.core.EResultType;
	import astre.core.Test;
	import astre.processor.IProgressNotifier;
	import astre.runner.ProgressNotifier;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;

/**
 * A <code class="prettyprint">TestRunner</code> is the implementation 
 * of the <code class="prettyprint">ITestRunner</code> interface.
 * A <code class="prettyprint">TestRunner</code> allows to run 
 * tests specified in a <code class="prettyprint">RunRequest</code> object 
 * as well as providing results of the run.
 * 
 * <p><strong>Note :</strong> As a reference, 
 * <code class="prettyprint">TestRunner</code>s are 
 * <code class="prettyprint">ITestListener</code>s with a 
 * priority registration of -255 (-0xff).So, by default, a 
 * <code class="prettyprint">TestRunner</code> will process 
 * notifications of the related 
 * <code class="prettyprint">IProgressNotifier</code> before other 
 * <code class="prettyprint">ITestListener</code>.</p>
 * 
 * @example This code shows how to create and run a 
 * <code class="prettyprint">TestRunner</code>. As an 
 * example, this <code class="prettyprint">TestRunner</code> 
 * provides access to the <code class="prettyprint">Stage</code> 
 * to all tests about to be run, using the 
 * <code class="prettyprint">testEnvs</code> property.
 * 
 * <pre class="prettyprint">
 * public class TestRunnerExample extends Sprite
 * {
 * 		public function TestRunnerExample()
 * 		{
 * 			var runner:ITestRunner = new TestRunner({stage: this.stage});
 * 			runner.runWith(RunRequest.create(myTestAggregatorClass);
 * 		}
 * 	
 * }
 * </pre>
 * 
 * @see RunRequest
 * @see astre.runner.ITestListener#registerToNotifier()
 * 
 * @author lunar
 * 
 */
public class TestRunner extends AbstractTestListener implements ITestRunner
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The array of tests objects to be run by 
	 * this <code class="prettyprint">TestRunner</code>.
	 */
	protected var _tests:Array;
	
	/**
	 * @private
	 * Stores whether this <code class="prettyprint">TestRunner</code> 
	 * has been started by the <code class="prettyprint">runWith()</code> 
	 * method and the <code class="prettyprint">TestRunner</code> 
	 * has not finished processing tests (and the 
	 * <code class="prettyprint">terminate()</code> method has not 
	 * been called - or its effect has not been applied yet)
	 */
	private var wasStarted:Boolean = false;
	
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
	 * @private
	 */
	private var _numTests:uint = 0;
	
	/**
	 * @inheritDoc
	 */
	public function get numTests():uint
	{
		return _numTests;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get numTestsRun():uint
	{
		return _numTests - _tests.length;
	}
	
	/**
	 * The result object in which this 
	 * <code class="prettyprint">TestRunner</code> writes 
	 * the results of the tests
	 */
	protected var _results:Result;
	
	/**
	 * @inheritDoc
	 */
	public function get results():Result
	{
		return _results.clone();
	}
	
	/**
	 * The configuration of this <code class="prettyprint">TestRunner</code>.
	 */
	protected var _config:RunConfiguration;
	
	/**
	 * @inheritDoc
	 */
	public function get runConfiguration():RunConfiguration
	{
		return _config;
	}
	
	/**
	 * @private
	 */
	public function set runConfiguration(value:RunConfiguration):void
	{
		this._config = _config;
	}
	
	/**
	 * The <code class="prettyprint">IProgressNotifier</code> of this 
	 * <code class="prettyprint">TestRunner</code>.
	 */
	protected var _progressNotifier:IProgressNotifier;
	
	/**
	 * @inheritDoc
	 */
	public function get progressNotifier():IProgressNotifier
	{
		return _progressNotifier;
	}
	
	/**
	 * The resources shared by all tests to be run by this 
	 * <code class="prettyprint">TestRunner</code>.
	 */
	protected var _testEnvs:TestEnv;
	
	/**
	 * @inheritDoc
	 */
	public function get testEnvs():TestEnv
	{
		return _testEnvs;
	}
	
	/**
	 * @private
	 */
	public function set testEnvs(value:TestEnv):void
	{
		this._testEnvs = _testEnvs;
	}
	
	/**
	 * @private
	 */
	private var isATestCurrentlyBeingRun:Boolean = false;
	
	/**
	 * @private
	 */
	private var isPauseRequested:Boolean;
	
	/**
	 * @private
	 */
	private var isTerminateRequested:Boolean;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * This <code class="prettyprint">TestRunner</code> is 
	 * registered with a priority of <code class="prettyprint">255</code>.
	 * 
	 * @param testEnvs The resources that will be shared by all 
	 * tests to be run.
	 * @param runConfiguration The configuration of this 
	 * <code class="prettyprint">TestRunner</code>.
	 */
	public function TestRunner(
			testEnvs:TestEnv = null, 
			runConfiguration:RunConfiguration = null
		) 
	{
		super();
		_progressNotifier = new ProgressNotifier();
		
		if (testEnvs != null)
		{
			this._testEnvs= testEnvs;
		}
		else
		{
			this._testEnvs = new TestEnv();
		}
		
		if (runConfiguration != null)
		{
			this._config = runConfiguration;
		}
		else
		{
			this._config = new RunConfiguration();
		}
		this.registerToNotifier(_progressNotifier, -1*0xff);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	public function runWith(request:RunRequest):void
	{
		if (!wasStarted)
		{
			_tests = request.tests;
			_isRunning = true;
			wasStarted = true;
			_numTests = _tests.length;
			_results = new Result();
			this._progressNotifier.notifyRunStart(this);
			askRunNextTest();
		}
	}
	
	/**
	 * Runs the next <code class="prettyprint">Test</code> to be run.
	 */
	protected function runNextTest():void
	{
		if (_isRunning)
		{
			if (_tests.length > 0)
			{
				var test:Test = _tests.shift() as Test;
				test.Astre::runWith(this);
				isATestCurrentlyBeingRun = true;
			}
			else
			{
				instantTerminate();
			}
		}
	}
	
	/**
	 * @private
	 * Asks for the next test be run when 
	 * the actual has finished being processed.
	 */
	override public function testEnd(test:Test, result:AtomicResult):void 
	{
		_results.addAtomicResult(result);
		isATestCurrentlyBeingRun = false;
		askRunNextTest();
	}
	
	/**
	 * @inheritDoc
	 */
	public function pause():void
	{
		if (_isRunning && wasStarted)
		{
			//isPauseRequested = true;
			instantPause();
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function resume():void
	{
		if (!_isRunning && wasStarted)
		{
			this._isRunning = true;
			this._progressNotifier.notifyRunResume(this);
			askRunNextTest();
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function terminate():void
	{
		// Check if we were paused. if this is the case, 
		// call directly instantTerminate()
		if (!this._isRunning)
		{
			this.instantTerminate();
		}
		else
		{
			//isTerminateRequested = true;
			instantTerminate();
		}
	}
	
	/**
	 * @private
	 * Asks for the next test to be run, if possible.
	 */
	private function askRunNextTest():void
	{
		/*if (isPauseRequested)
		{
			instantPause();
		}
		else if (isTerminateRequested)
		{
			instantTerminate();
		}*/
		
		// we delay the next test process, to avoid stack overflows
		if (!isATestCurrentlyBeingRun)
		{
			setTimeout(runNextTest, 5);
		}
	}
	
	/**
	 * @private
	 * Pauses instantly this <code class="prettyprint">TestRunner</code>.
	 */
	private function instantPause():void
	{
		isPauseRequested = false;
		if (_isRunning && wasStarted)
		{
			this._isRunning = false;
			this._progressNotifier.notifyRunPause(this);
		}
	}
	
	/**
	 * @private
	 * Instantly terminates this <code class="prettyprint">TestRunner</code>.
	 */
	private function instantTerminate():void
	{
		isTerminateRequested = false;
		if (wasStarted)
		{
			wasStarted = false;
			_isRunning = false;
			this._progressNotifier.notifyRunEnd(this);
			tryExit();
		}
	}
	
	/**
	 * @private
	 * Tries to exit the application if asked.
	 */
	private function tryExit():void
	{
		if (runConfiguration.exitOnFinish)
		{
			if (Capabilities.playerType == "StandAlone")
			{
				System.exit(0);
			}
			else if (Capabilities.playerType == "Desktop") 
			{
				try
				{
					var NativeApp:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
					NativeApp.nativeApplication.exit(0);
				} catch (e:ReferenceError)
				{
					// could not get NativeApplication class :  ignore
				}
				catch (e:Error)
				{
					// unexpected error : ignore
				}
			}
		}
	}
	
}
	
}
