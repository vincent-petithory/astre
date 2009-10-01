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

package astre.api 
{
	import astre.core.ITestListener;
	import astre.core.ITestRunner;
	import astre.core.manipulation.runRequestRules.TestDescriptionSortRule;
	import astre.core.RunConfiguration;

/**
 * A simple class whose unique method serves as a shortcut for 
 * quickly running basic tests.
 * 
 * @author lunar
 */
public class TextRunner 
{

	/**
	 * Creates a test runner and runs the specified tests.
	 * The test runner class used is 
	 * <code class="prettyprint">astre.runner.TestRunner</code>.
	 * A <code class="prettyprint">ResultPrinter</code> is automatically 
	 * attached.
	 * 
	 * @param tests The object containing the tests to run. 
	 * The object to provide can be the same than the one of 
	 * the <code class="prettyprint">RunRequest#create()</code> method.
	 * @param listener a listener who will listener the test execution
	 * @param env Environment vars to provide to the test runner.
	 * @param runConfiguration A configuration to provide to the test runner.
	 * @return The newly created test runner.
	 * 
	 */
	public static function run(tests:Object, listener:ITestListener = null, env:TestEnv = null, runConfiguration:RunConfiguration = null):ITestRunner 
	{
		var runner:ITestRunner = new TestRunner(env, runConfiguration);
		
		var testResultPrinter:ITestListener = new ResultPrinter();
		testResultPrinter.registerToNotifier(runner.progressNotifier);
		
		if (listener != null)
		{
			listener.registerToNotifier(runner.progressNotifier);
		}
		
		var request:RunRequest = new RunRequest(tests);
		
		runner.runWith(request);
		return runner;
	}
	
	
	
}
	
}
