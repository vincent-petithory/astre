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
	import astre.core.manipulation.RunRequestFilterRule;
	import astre.core.manipulation.RunRequestSortRule;

/**
 * 
 * A <code class="prettyprint">RunRequest</code> is a bridge between 
 * the tests or the lists of tests and the runner that will run these 
 * tests.
 * 
 * <p>You gather all the tests to be run in a 
 * <code class="prettyprint">RunRequest</code> object before providing 
 * this one to your test runner. The 
 * <code class="prettyprint">RunRequest</code> class was created to 
 * concentrate filter and sort features into one entity.</p>
 * 
 * <p>The <code class="prettyprint">RunRequest</code> class provides 
 * several static methods to construct your list of tests to be run.</p>
 * 
 * @example This example shows how to create a list of tests with various 
 * test sources :
 * <pre class="prettyprint">
 * 
 * var runRequest:RunRequest = RunRequest.create(
 * 										myTestClass, new TestSuiteExample(), 
 * 										new SingleTest("myTestMethod")
 * 									);
 * 
 * var runner:ITestRunner = new TestRunner();
 * runner.runWith(runRequest);
 * 
 * </pre>
 * 
 * @see TestRunner
 * @see astre.core.Test
 * @see astre.core.TestSuite
 * 
 * @author lunar
 * 
 */
public class RunRequest 
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _tests:Array;
	
	/**
	 * The tests this <code class="prettyprint">RunRequest</code> contains.
	 */
	public function get tests():Array
	{
		return _tests.slice();
	}
	
	/**
	 * The number of tests this 
	 * <code class="prettyprint">RunRequest</code> contains.
	 */
	public function get numTests():uint
	{
		return _tests.length;
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * Creates a <code class="prettyprint">RunRequest</code> object 
	 * using heterogeneous test objects.
	 * 
	 * <p>The specified parameters can be either a astre.core.Test instance,      * a astre.core.TestSuite instance, a class extending Test 
	 * or a class specifying a static method that returns a TestSuite.<br/>
	 * A class specifying a static method that returns a TestSuite can 
	 * extend any class. If you provide a class extending 
	 * <code class="prettyprint">astre.core.Test</code> with such a method,      * the tests specified in this static method will be considered 
	 * rather than all the tests of the 
	 * <code class="prettyprint">astre.core.Test</code> subclass.</p>
	 * 
	 * @param ...tests A list of valid test objects     * 
	 * @return A <code class="prettyprint">RunRequest</code> object 
	 * based on the specified heterogeneous test objects.
	 * 
	 * @throws   <code class="prettyprint">ArgumentError</code> - If 
	 * the specified parameters must be 
	 * either a astre.core.Test instance,      * a astre.core.TestSuite instance, a class extending Test 
	 * or a class specifying a static method that returns a TestSuite.
	 * 
	 */
	public function RunRequest(...tests) 
	{
		super();
		
		var list:TestSuite = new TestSuite();
		for each (var obj:Object in tests)
		{
			list.addTest(obj);
		}
		this._tests = list.getTests();
	}
	
	/**
	 * Returns a clone of this <code class="prettyprint">RunRequest</code>.
	 * @return a clone of this <code class="prettyprint">RunRequest</code>.
	 */
	public function clone():RunRequest
	{
		var clone:RunRequest = new RunRequest();
		var cloneTests:Array = new Array();
		
		for each (var test:Test in this._tests)
		{
			cloneTests.push(test.clone());
		}
		clone._tests = cloneTests;
		return clone;
	}
	
	/**
	 * Filters the elements of this 
	 * <code class="prettyprint">RunRequest</code> based on filter rule and 
	 * returns the filtered <code class="prettyprint">RunRequest</code>.
	 * 
	 * <p>The original <code class="prettyprint">RunRequest</code> remains 
	 * unmodified.</p>
	 * 
	 * @param rule The <code class="prettyprint">RunRequestFilterRule</code> 
	 * to use to filter this <code class="prettyprint">RunRequest</code>.
	 * @return The filtered <code class="prettyprint">RunRequest</code>.
	 * The original <code class="prettyprint">RunRequest</code> remains 
	 * unmodified.
	 * 
	 * @example This example shows how to get a 
	 * <code class="prettyprint">RunRequest</code> that will contain 
	 * only the tests from the specified package :
	 * 
	 * <pre class="prettyprint">
	 * var request:RunRequest = RunRequest.testClass(
	 * 											MyGlobalTestAggregatorClass
	 * 											);
	 * request = request.filter(
	 * 					new TestPackageFilterRule("path.to.my.package")
	 * 				);
	 * </pre>
	 * 
	 * @see astre.runner.manipulation.runRequestRules
	 * @see astre.runner.manipulation.runRequestRules.TestPackageFilterRule
	 * 
	 */
	public function filter(rule:RunRequestFilterRule):RunRequest
	{
		var req:RunRequest = this.clone();
		var filteredTests:Array = req.tests.filter(
									rule.accept, 
									null
								);
		var request:RunRequest = new RunRequest();
		request._tests = filteredTests;
		return request;
	}
	
	/**
	 * Sorts the tests of this <code class="prettyprint">RunRequest</code> 
	 * according to the specified sort rule.
	 * 
	 * @param rule The <code class="prettyprint">RunRequestSortRule</code> 
	 * to use to sort this <code class="prettyprint">RunRequest</code>.
	 * 
	 * @example This example shows how to sort a 
	 * <code class="prettyprint">RunRequest</code> according to the package, 
	 * class name and method name of the tests :
	 * 
	 * <pre class="prettyprint">
	 * var request:RunRequest = RunRequest.testClass(
	 * 											MyGlobalTestAggregatorClass
	 * 											);
	 * request = request.filter(
	 * 					new TestDescriptionSortRule()
	 * 				);
	 * </pre>
	 * 
	 * @see astre.runner.manipulation.runRequestRules
	 * @see astre.runner.manipulation.runRequestRules.TestDescriptionSortRule
	 * 
	 */
	public function sort(rule:RunRequestSortRule):void
	{
		_tests.sort(rule.compare);
	}
	
}
	
}
