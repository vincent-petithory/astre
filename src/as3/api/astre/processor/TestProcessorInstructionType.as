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

package astre.processor 
{

/**
 * The <code class="prettyprint">TestProcessorInstructionType</code> 
 * enumerates the possible types of 
 * <code class="prettyprint">TestProcessorInstruction</code> an 
 * <code class="prettyprint">ITestProcessor</code> can execute.
 * 
 * @see ITestProcessor
 * @see TestProcessorInstruction
 * @see astre.core.Test
 * 
 * @author lunar
 * 
 */
public class TestProcessorInstructionType 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * An instruction type that asks the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process all actual registered asynchronous method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#addDeferredAsync()
	 * @see astre.core.Test#addAsync()
	 * 
	 */
	public static const ASK_START_ALL_ASYNC_PROCESSES:String = 
						"askStartAllAsyncProcesses";
	
	/**
	 * An instruction type that asks the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process the next asynchronous method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#addDeferredAsync()
	 * @see astre.core.Test#addAsync()
	 * 
	 */
	public static const ASK_START_ASYNC_PROCESS:String = 
						"askStartAsyncProcess";
	
	/**
	 * An instruction type that asks the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process an asynchronous method that 
	 * checks a function call.
	 * 
	 * @see astre.core.Test#checkFunctionWillBeCalled()
	 * @see astre.core.Test#markFunctionAsCalled()
	 * 
	 */
	public static const ASK_START_FUNCTION_CALLED_PROCESS:String = 
						"askStartFunctionCalledProcess";
	
	/**
	 * An instruction type that asks the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process a specific asynchronous method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#addDeferredAsync()
	 * @see astre.core.Test#addAsync()
	 * 
	 */
	public static const ASK_START_SPECIFIC_ASYNC_PROCESS:String = 
						"askStartSpecificAsyncProcess";
	
	/**
	 * An instruction type that commands the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process an asynchronous method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#addDeferredAsync()
	 * @see astre.core.Test#addAsync()
	 * 
	 */
	public static const PROCESS_ASYNC_FUNCTION:String = 
						"processAsyncFunction";
	
	/**
	 * An instruction type that commands the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process an asynchronous fail method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#addDeferredAsync()
	 * @see astre.core.Test#addAsync()
	 * 
	 */
	public static const PROCESS_FAIL_FUNCTION:String = 
						"processFailFunction";
	
	/**
	 * An instruction type that commands the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process the main test method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 */
	public static const PROCESS_MAIN_METHOD:String = 
						"processMainMethod";
	
	/**
	 * An instruction type that commands the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process the <code class="prettyprint">setUp()</code> method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#setUp()
	 * 
	 */
	public static const PROCESS_SET_UP:String = 
						"processSetUp";
	
	/**
	 * An instruction type that commands the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> 
	 * to process the <code class="prettyprint">tearDown()</code> method of 
	 * its <code class="prettyprint">Test</code>.
	 * 
	 * @see astre.core.Test#tearDown()
	 * 
	 */
	public static const PROCESS_TEAR_DOWN:String = 
						"processTearDown";
	
}
	
}
