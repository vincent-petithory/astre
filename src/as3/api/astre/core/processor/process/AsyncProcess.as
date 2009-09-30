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

package astre.core.processor.process 
{
	import astre.async.AsyncCheckoutEvent;
	import astre.async.FunctionToken;
	import astre.async.IAsyncCheckout;
	import astre.core.processor.TestProcessorInstructionType;
	import astre.api.EResultType;
	import astre.core.processor.TestProcessorInstruction;
	import astre.core.processor.process.ETestProcessPhase;
	import astre.api.Test;
	import astre.core.TestError;

/**
 * An <code class="prettyprint">AsyncProcess</code> handles asynchronous 
 * checkouts requests and waits for the result before notifying the 
 * <code class="prettyprint">ITestProcessor</code>.
 * 
 * <p>An <code class="prettyprint">AsyncProcess</code> participates to the 
 * <code class="prettyprint">ETestProcessPhase.ASYNC_TIMEOUT</code> 
 * phase.</p>
 * 
 * @author lunar
 * 
 */
public class AsyncProcess extends TestProcess
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var asyncCheckout:IAsyncCheckout;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param asyncCheckout The related checkout.
	 * @param test The test from which this 
	 * <code class="prettyprint">ITestProcess</code> is part of.
	 */
	public function AsyncProcess(asyncCheckout:IAsyncCheckout, test:Test) 
	{
		super(test, ETestProcessPhase.ASYNC_TIMEOUT);
		this.asyncCheckout = asyncCheckout;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Runs this <code class="prettyprint">AsyncProcess</code> process. 
	 * It will wait for an answer of the 
	 * <code class="prettyprint">IAsyncCheckout</code> specified at 
	 * construction time.
	 */
	override public function run():void 
	{
		super.run();
		asyncCheckout.addEventListener(AsyncCheckoutEvent.ASYNC_NOT_EXECUTED, onAsyncCheckoutEvent);
		asyncCheckout.addEventListener(AsyncCheckoutEvent.ASYNC_EXECUTED, onAsyncCheckoutEvent);
		asyncCheckout.addEventListener(AsyncCheckoutEvent.EXPECTED_ASYNC_NOT_EXECUTED, onAsyncCheckoutEvent);
		asyncCheckout.startCheckout();
	}
	
	/**
	 * @private
	 * Handles the answer of the related 
	 * <code class="prettyprint">IAsyncCheckout</code> object and sets the 
	 * next command if any.
	 */
	private function onAsyncCheckoutEvent(event:AsyncCheckoutEvent):void 
	{
		if (event.type == AsyncCheckoutEvent.ASYNC_EXECUTED)
		{
			this.testProcessResult.type = EResultType.PASSED;
			this.forceCommand = new TestProcessorInstruction(
					TestProcessorInstructionType.PROCESS_ASYNC_FUNCTION, 
					event.asyncData
				);
		}
		else if (event.type == AsyncCheckoutEvent.EXPECTED_ASYNC_NOT_EXECUTED)
		{
			this.testProcessResult.type = EResultType.PASSED;
			this.forceCommand = new TestProcessorInstruction(
					TestProcessorInstructionType.PROCESS_FAIL_FUNCTION, 
					event.asyncData
				);
		}
		else if (event.type == AsyncCheckoutEvent.ASYNC_NOT_EXECUTED)
		{
			this.testProcessResult.type = EResultType.FAILURE;
			var message:String = "Function not executed after "+
				(event.target as IAsyncCheckout).timeout.toString()+
				"ms";
			var eventType:String = (event.target as IAsyncCheckout).eventType;
			if (eventType.indexOf(FunctionToken.EVENT_TYPE_SEPARATOR) == -1)
			{
				message += " : < "+(event.target as IAsyncCheckout).eventType+" > event was not dispatched";
			}
			this.testProcessResult.error = new TestError(
					message, 
					new Error(message)
				);
			this.forceCommand = new TestProcessorInstruction(
					TestProcessorInstructionType.ASK_START_ASYNC_PROCESS
				);
		}
		this.runEnd();
	}
	
}
	
}
