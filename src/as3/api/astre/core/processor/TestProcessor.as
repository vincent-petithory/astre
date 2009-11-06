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
	import astre.api.ignore;
	import astre.api.Test;
	import astre.api.EResultType;
	import astre.async.AsyncData;
	import astre.async.IAsyncCheckout;
	import astre.core.Astre;
	import astre.core.AtomicResult;
	import astre.core.processor.TestProcessorInstruction;
	import astre.core.processor.process.ETestProcessPhase;
	import astre.core.processor.process.AsyncFunctionProcess;
	import astre.core.processor.process.AsyncProcess;
	import astre.core.processor.process.MainMethodProcess;
	import astre.core.processor.process.SetUpProcess;
	import astre.core.processor.process.TearDownProcess;
	import astre.core.processor.process.TestProcessEvent;
	
    import flash.events.Event;
    import flash.utils.describeType;

/**
 * A <code class="prettyprint">TestProcessor</code> is the default 
 * processor provided by the Astre API. Most often, you will use this one for 
 * processing your tests.
 * 
 * <p>It has the following features and behavior :
 * <ul>
 * <li>When the <code class="prettyprint">run()</code> method is called, 
 * the <code class="prettyprint">setUp()</code> method of the 
 * <code class="prettyprint">Test</code> is processed. 
 * The <code class="prettyprint">TestProcessor</code> also 
 * notifies the beginning of the test process.</li>
 * <li>The <code class="prettyprint">TestProcessor</code> registers 
 * any asynchronous checkouts while processing the 
 * <code class="prettyprint">setUp()</code> method.</li>
 * <li>Once all asynchronous checkouts are processed, the 
 * <code class="prettyprint">TestProcessor</code> processes the 
 * main test method of the <code class="prettyprint">Test</code>.</li>
 * <li>The <code class="prettyprint">TestProcessor</code> registers 
 * any asynchronous checkouts while processing the 
 * main test method.</li>
 * <li>Once all asynchronous checkouts are processed, the 
 * <code class="prettyprint">TestProcessor</code> processes the 
 * <code class="prettyprint">tearDown()</code> 
 * method of the <code class="prettyprint">Test</code>.</li>
 * <li>The <code class="prettyprint">TestProcessor</code> registers 
 * any asynchronous checkouts while processing the 
 * <code class="prettyprint">tearDown()</code> method.</li>
 * <li>Once all asynchronous checkouts are processed, the 
 * <code class="prettyprint">TestProcessor</code> notifies the end 
 * of the <code class="prettyprint">Test</code>.</li>
 * </ul>
 * </p>
 * 
 * <p>If you want to change the way the tests are processed, 
 * you may create another test processor extending one of the available 
 * classes, like 
 * <code class="prettyprint">astre.core.processor.AbstractTestProcessor</code> and 
 * <code class="prettyprint">astre.core.processor.TestProcessor</code>, or create a 
 * new class implementing the 
 * <code class="prettyprint">astre.core.processor.ITestProcessor</code> 
 * interface. Then, you specify your new test processor class to be used by 
 * setting the <code class="prettyprint">testProcessorClass</code> property 
 * of a <code class="prettyprint">astre.runner.RunConfiguration</code> 
 * instance. You finally pass the 
 * <code class="prettyprint">RunConfiguration</code> instance to the 
 * <code class="prettyprint">runWith()</code> method of the 
 * <code class="prettyprint">TestRunner</code>.</p>
 * 
 * @see astre.runner.TestRunner
 * @see astre.runner.RunConfiguration
 * @see ITestProcessor
 * @see AbstractTestProcessor
 * @see astre.core.processor.process
 * 
 * @author lunar
 * 
 */
public class TestProcessor extends AbstractTestProcessor
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param test The <code class="prettyprint">Test</code> 
	 * to be processed.
	 */
	public function TestProcessor(test:Test) 
	{
		super(test);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Processes the <code class="prettyprint">setUp()</code> method.
	 */
	protected function __processSetUp():void
	{
		var process:ITestProcess = new SetUpProcess(this._test);
		this.registerAndRun(process);
	}
	
	/**
	 * Processes the <code class="prettyprint">tearDown()</code> method.
	 */
	protected function __processTearDown():void
	{
		var process:ITestProcess = new TearDownProcess(this._test);
		this.registerAndRun(process);
	}
	
	/**
	 * Processes the main method of the <code class="prettyprint">Test</code>.
	 */
	protected function __processMethod():void
	{
		var process:ITestProcess = new MainMethodProcess(this._test);
		this.registerAndRun(process);
	}
	
	/**
	 * Starts an asynchronous process.
	 * @param checkout The <code class="prettyprint">IAsyncCheckout</code> 
	 * object related to this process.
	 */
	protected function __startAsyncProcess(checkout:IAsyncCheckout = null):void
	{
		var process:ITestProcess = new AsyncProcess(
			checkout != null ? 
					checkout : 
					this._test.Astre::asyncsHandler.getNextAsync(), 
			this._test);
		this.registerAndRun(process);
	}
	
	/**
	 * Starts the process of an asynchronous method. Typically, this is a 
	 * the listener of an event, or an optional method associated 
	 * if the event is not caught.
	 * 
	 * @param phase The phase in which this asynchronous function will be run.
	 * Two values are possible : 
	 * <ul>
	 * <li><code class="prettyprint">ETestProcessPhase.ASYNC_METHOD</code></li>
	 * <li>
	 * 	<code class="prettyprint">ETestProcessPhase.ASYNC_FAIL_FUNCTION</code>
	 * </li>
	 * </ul>
	 * 
	 * @param func the function to be processed
	 * @param event An optional event to pass to the function.
	 * @param data Optional data to pass to the function.
	 */
	protected function __processAsyncFunction(
							phase:ETestProcessPhase, 
							asyncData:AsyncData
						):void
	{
		var process:ITestProcess = new AsyncFunctionProcess(
														this._test, 
														phase, 
														asyncData
													);
		this.registerAndRun(process);
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function registerAndRun(process:ITestProcess):void
	{
		processes.push(process);
		process.addEventListener(
						TestProcessEvent.TEST_PROCESS_END, 
						onProcessEnd
					);
		process.run();
	}
	
	/**
	 * Manages the next instruction to process when 
	 * an other has finished being processed.
	 */
	protected function onProcessEnd(event:TestProcessEvent):void 
	{
		event.testProcess.removeEventListener(
									TestProcessEvent.TEST_PROCESS_END, 
									onProcessEnd
								);
		
		_progressNotifier.notifyTestProgress(
					this._test, 
					event.testProcess.testProcessPhase, 
					this.idleProcesses, 
					this.numProcesses
				);
		this.reportResult(event.testProcess);
		
		if (event.testProcess.testProcessPhase == 
						ETestProcessPhase.SET_UP || 
			event.testProcess.testProcessPhase == 
						ETestProcessPhase.MAIN_METHOD || 
			event.testProcess.testProcessPhase == 
							ETestProcessPhase.TEAR_DOWN 
			)
		{
			this.syncPhasesRun[event.testProcess.testProcessPhase.name] = true;
			this.execute(
				new TestProcessorInstruction(
						TestProcessorInstructionType.ASK_START_ASYNC_PROCESS 
					)
				);
		}
		else if (event.testProcess.testProcessPhase == 
						ETestProcessPhase.ASYNC_METHOD || 
				 event.testProcess.testProcessPhase == 
						ETestProcessPhase.ASYNC_FAIL_FUNCTION
				)
		{
			this.execute(
				new TestProcessorInstruction(
						TestProcessorInstructionType.ASK_START_ASYNC_PROCESS
					)
				);
		}
		else if (event.testProcess.testProcessPhase == 
					ETestProcessPhase.ASYNC_TIMEOUT
				)
		{
			// Generally received from an AsyncProcess.
			// specifies the next command, i.e processing a 
			// fail function or an async function
			// depending on the result of the async checkout
			this.execute(event.forceCommand);
		}
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function onInstruction(
							event:TestProcessorInstructionEvent
						):void
	{
		var instruction:TestProcessorInstruction = event.instruction;
		switch(instruction.type)
		{
			case TestProcessorInstructionType.ASK_START_ASYNC_PROCESS: 
				if (this._test.Astre::asyncsHandler.hasAsync())
				{
					__startAsyncProcess();
				}
				else
				{
					if (!this.hasRunningProcesses())
					{
						switch (this.syncPhasesRun.getProgressLevel())
						{
							case 0:
								// setUp method is run when calling the run() 
								// method of this TestProcessor,
								// so we are never facing this case
								break;
							case 1: 
								this.execute(
								new TestProcessorInstruction(
								TestProcessorInstructionType.PROCESS_MAIN_METHOD
								));
								break;
							case 2:
								this.execute(
								new TestProcessorInstruction(
								TestProcessorInstructionType.PROCESS_TEAR_DOWN
								));
								break;
							case 3:
								notifyAllProcessesEnd();
								break;
							default: 
								notifyAllProcessesEnd();
						}
					}
					// else there is at least one 
					// running process that will call back this method
				}
				break;
			case TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS: 
				__startAsyncProcess(instruction.data as IAsyncCheckout);
				break;
			case TestProcessorInstructionType.PROCESS_SET_UP: 
				__processSetUp();
				break;
			case TestProcessorInstructionType.PROCESS_MAIN_METHOD: 
				__processMethod();
				break;
			case TestProcessorInstructionType.PROCESS_TEAR_DOWN: 
				__processTearDown();
				break;
			case TestProcessorInstructionType.PROCESS_ASYNC_FUNCTION: 
				__processAsyncFunction(
									ETestProcessPhase.ASYNC_METHOD, 
									instruction.data as AsyncData
								);
				break;
			case TestProcessorInstructionType.PROCESS_FAIL_FUNCTION: 
				__processAsyncFunction(
									ETestProcessPhase.ASYNC_FAIL_FUNCTION, 
									instruction.data as AsyncData
								);
				break;
			case TestProcessorInstructionType.ASK_START_ALL_ASYNC_PROCESSES: 
				// Feature not yet used, but maybe in the future as an option 
				// of the Test#addDeferredAsync() method
				while (this._test.Astre::asyncsHandler.hasAsync())
				{
					__startAsyncProcess();
				}
				break;
			default: 
				// do nothing
		}
	}
	
	/**
	 * <p>This implementation starts the test processor by processing 
	 * the <code class="prettyprint">setUp()</code> method.</p>
	 * 
	 * @inheritDoc
	 */
	override public function run():void 
	{
		_progressNotifier.notifyTestStarted(this._test);
        var isIgnored:Boolean = test.isIgnored();
            
        
        if (isIgnored)
        {
            this.result = new AtomicResult(EResultType.IGNORED, _test.description);
            notifyAllProcessesEnd();
        }
        else
        {
            var dt:XMLList = describeType(this._test)..method.(@name == this._test.name);
            isIgnored = dt.attribute("uri") == "http://www.lunar-dev.net/astre/ignore";
            if (isIgnored)
            {
                this.result = new AtomicResult(EResultType.IGNORED, _test.description);
                notifyAllProcessesEnd();
            }
            else
            {
                this.execute(new TestProcessorInstruction(
                    TestProcessorInstructionType.PROCESS_SET_UP
                    )
                );
            }
        }
	}
	
}
	
}
