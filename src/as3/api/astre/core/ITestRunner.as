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
	import astre.api.TestResult;
	import astre.api.RunRequest;

/**
 * The <code class="prettyprint">ITestRunner</code> interface defines 
 * the contract an object that can run tests signs for.
 * 
 * @see TestRunner
 * @see RunRequest
 * @see TestResult
 * @see RunConfiguration
 * @see ProgressNotifier
 * @see astre.core.Test
 * 
 * @author lunar
 * 
 */
public interface ITestRunner 
{
	
	/**
	 * Runs this <code class="prettyprint">ITestRunner</code> with 
	 * the specified <code class="prettyprint">RunRequest</code>.
	 * 
	 * @param request A <code class="prettyprint">RunRequest</code> 
	 * object containing the tests to run with this 
	 * <code class="prettyprint">ITestRunner</code>.
	 */
	function runWith(request:RunRequest):void;
	
	/**
	 * Cleanly stops this <code class="prettyprint">ITestRunner</code>.
	 * This <code class="prettyprint">ITestRunner</code> finishes the process 
	 * of the current test and waits for a call to the 
	 * <code class="prettyprint">runWith()</code> to run this 
	 * <code class="prettyprint">ITestRunner</code> again. Results collected 
	 * during the stopped processing must be get then cloned before 
	 * running again the runner.
	 * 
	 * @see #runWith()
	 * 
	 */
	function terminate():void;
	
	/**
	 * Cleanly stops this <code class="prettyprint">ITestRunner</code>.
	 * This <code class="prettyprint">ITestRunner</code> finishes the process 
	 * of the current test and waits for a call to the 
	 * <code class="prettyprint">resume()</code> before processing the 
	 * next test.
	 * You may also call the <code class="prettyprint">terminate()</code> 
	 * method at this point.
	 * 
	 * @see #resume()
	 * 
	 */
	function pause():void;
	
	/**
	 * Resumes the processing of the tests after this 
	 * <code class="prettyprint">ITestRunner</code> has been 
	 * paused by the <code class="prettyprint">pause()</code> method.
	 * 
	 * @see #pause()
	 * 
	 */
	function resume():void;
	
	/**
	 * The number of tests this <code class="prettyprint">ITestRunner</code> 
	 * has to run.
	 */
	function get numTests():uint;
	
	/**
	 * The number of tests this <code class="prettyprint">ITestRunner</code> 
	 * has actually run.
	 */
	function get numTestsRun():uint;
	
	/**
	 * The <code class="prettyprint">TestResult</code> object containing the current 
	 * results of the global test processing.
	 * 
	 * <p>When this <code class="prettyprint">ITestRunner</code> has not been 
	 * run yet, the value is <code class="prettyprint">null</code>.</p>
	 * 
	 */
	function get testResult():TestResult;
	
	/**
	 * The current configuration this 
	 * <code class="prettyprint">ITestRunner</code> uses for running tests.
	 */
	function get runConfiguration():RunConfiguration;
	
	/**
	 * @private
	 */
	function set runConfiguration(value:RunConfiguration):void;
	
	/**
	 * The <code class="prettyprint">IProgressNotifier</code> object used 
	 * during the test processing for all notification jobs.
	 */
	function get progressNotifier():IProgressNotifier;
	
	/**
	 * The state of this <code class="prettyprint">ITestRunner</code>.
	 * The value is <code class="prettyprint">true</code> if the 
	 * runner is running. Otherwise <code class="prettyprint">false</code>.
	 */
	function get isRunning():Boolean;
	
}
	
}
