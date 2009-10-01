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
	import astre.core.Reflection;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

/**
 * A <code class="prettyprint">TestSuite</code> object holds 
 * a collection of tests that you can then pass to a runner 
 * using a <code class="prettyprint">RunRequest</code> object.
 * 
 * @see Test
 * @see astre.runner.RunRequest
 * 
 * @author lunar
 * 
 */
public class TestSuite 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * When writing a class that you pass to the 
	 * <code class="prettyprint">addTestClass()</code> for creating 
	 * a suite of tests, you may create a static method that returns a 
	 * <code class="prettyprint">TestSuite</code>. If you do like this, 
	 * the name of your method must be the value of 
	 * <code class="prettyprint">TestSuite.staticTestSuiteFunctionName</code>.
	 * 
	 * @default testSuite
	 * 
	 * @see TestSuite#addTestClass()
	 */
	public static var staticTestSuiteFunctionName:String = "suite";
	
	/**
	 * @private
	 * Filters the method of the 
	 * <code class="prettyprint">astre.core.Test</code> class.
	 */
	private static var testMethodFilter:Function = function(
														item:*, 
														index:int, 
														array:Array
													):Boolean
	{
		var s:String = item as String;
		return Test.NOT_TEST_METHODS.indexOf(s) == -1;
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 * 
	 * Tests and testSuite are in the 
	 * same array to keep order.
	 */
	private var _testsAndTestSuites:Array;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function TestSuite() 
	{
		super();
		_testsAndTestSuites = new Array();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Adds a test object to this 
	 * <code class="prettyprint">TestSuite</code>.
	 * 
	 * @param test The test object to be added. It can be : 
     * <ul>
     * <li>a TestSuite class or instance, </li>
     * <li>a Test class or instance, </li>
     * <li>a class with a static method returning a TestSuite.</li>
     * </ul>
     * 
	 */
	public function add(test:*):void
	{
		if (test is TestSuite)
			addTestSuite(test as TestSuite);
		else if (test is Class)
			addTestClass(test as Class);
		else if (test is Test)
			addTest(test as Test);
		else
		{
			throw new ArgumentError(
			"The specified parameters must be "+
			"either a astre.core.Test instance, "+
			"a astre.core.TestSuite instance, "+
			"a class extending Test "+
			"or a class specifying a static "+
			"method that returns a TestSuite.");
		}
	}

	/**
	 * Adds a test to this 
	 * <code class="prettyprint">TestSuite</code>.
	 * 
	 * @param test The test to be added.
	 */
	protected function addTest(test:Test):void
	{
		_testsAndTestSuites.push(test);
	}
	
	/**
	 * Uses a class to add tests and/or test suites to this 
	 * <code class="prettyprint">TestSuite</code>.
	 * 
	 * <p>You may pass :
	 * <ul>
	 * <li>A class that extends <code class="prettyprint">astre.core.Test</code> : 
	 * all the public methods you wrote in your subclass will be 
	 * considered as test classes. Public methods specified by the 
	 * <code class="prettyprint">Test</code> class are 
	 * automatically not considered as test classes.</li>
	 * you may
	 * <li>extends <code class="prettyprint">astre.core.Test</code> and 
	 * provides a static method that returns a 
	 * <code class="prettyprint">TestSuite</code> and whose name matches 
	 * the value of the 
	 * <code class="prettyprint">staticTestSuiteFunctionName</code> 
	 * property.</li>
	 * <li>Any class that provides a static method that returns a 
	 * <code class="prettyprint">TestSuite</code> and whose name matches 
	 * the value of the 
	 * <code class="prettyprint">staticTestSuiteFunctionName</code> 
	 * property.</li>
	 * </ul>
	 * </p>
	 * 
	 * @param testClass The class to be processed for adding 
	 * tests and test suites.
	 * 
	 * @throws   <code class="prettyprint">ArgumentError</code> - If 
	 * the specified class does not provide a 
	 * static method that returns a astre.core.TestSuite object 
	 * or it is not a astre.core.Test subclass.
	 * @throws   <code class="prettyprint">TypeError</code> - If 
	 * the specified class is null.
	 * 
	 * @see TestSuite#staticTestSuiteFunctionName
	 */
	protected function addTestClass(testClass:Class):void
	{
		if (testClass != null)
		{
			var desc:XMLList = 
				describeType(testClass).child("method").(@name == 
					TestSuite.staticTestSuiteFunctionName);
			if (desc.length() == 1 && 
				desc.@returnType == getQualifiedClassName(TestSuite)
				)
			{
				this.addTestSuite(
					testClass[TestSuite.staticTestSuiteFunctionName].apply(testClass)
				);
			}
			else if (Reflection.isSubClassOf(testClass, Test))
			{
				var testSuite:TestSuite = new TestSuite();
				var methods:Array = Reflection.getMethods(testClass);
				// reverse for alphabetical order by default
				methods = methods.filter(testMethodFilter).reverse();
				for each (var method:String in methods)
				{
					testSuite.addTest(new testClass(method) as Test);
				}
				this.addTestSuite(testSuite);
			}
			else if (Reflection.isSubClassOf(testClass, TestSuite))
			{
				testSuite.addTestSuite(new testClass() as TestSuite);
				this.addTestSuite(testSuite);
			}
			else
			{
				throw new ArgumentError(
					"The specified class "+testClass+" does not provide a "+
					"static method named "+TestSuite.staticTestSuiteFunctionName+
					" "+"that returns a astre.core.TestSuite object "+
					"or it is neither a astre.core.Test "+
					"nor astre.core.TestSuite subclass.");
			}
		}
		else
		{
			throw new TypeError("The specified class is null");
		}
	}
	
	/**
	 * Adds a test suite to this <code class="prettyprint">TestSuite</code>.
	 * 
	 * @param testSuite The <code class="prettyprint">TestSuite</code> to 
	 * be added.
	 * 
	 * @throws   <code class="prettyprint">TypeError</code> - If the 
	 * specified 
	 * <code class="prettyprint">TestSuite</code> is 
	 * <code class="prettyprint">null</code>.
	 * 
	 */
	protected function addTestSuite(testSuite:TestSuite):void
	{
		if (testSuite != null)
		{
			_testsAndTestSuites.push(testSuite as TestSuite);
		}
		else
		{
			throw new TypeError("The specified testSuite must not be null");
		}
	}
	
	/**
	 * Returns an array of the tests this 
	 * <code class="prettyprint">TestSuite</code> carry.
	 * 
	 * <p>Nested <code class="prettyprint">TestSuite</code> this 
	 * <code class="prettyprint">TestSuite</code> carry are recursively 
	 * processed to return only <code class="prettyprint">Test</code> 
	 * instances.</p>
	 * 
	 * @return an array of the tests this 
	 * <code class="prettyprint">TestSuite</code> carry.
	 */
	public function getTests():Array
	{
		var tests:Array = new Array();
		
		for each (var obj:* in _testsAndTestSuites)
		{
			if (obj is TestSuite)
			{
				tests = tests.concat((obj as TestSuite).getTests());
			}
			else if (obj is Test)
			{
				tests.push(obj as Test);
			}
		}
		return tests;
	}
	
	/**
	 * Returns a clone of this <code class="prettyprint">TestSuite</code>.
	 * @return a clone of this <code class="prettyprint">TestSuite</code>.
	 */
	public function clone():TestSuite
	{
		var cloneTestsAndTestSuites:Array = new Array();
		
		for each (var obj:* in _testsAndTestSuites)
		{
			if (obj is TestSuite || obj is Test)
			{
				cloneTestsAndTestSuites.push(obj.clone());
			}
		}
		var cloneSuite:TestSuite = new TestSuite();
		cloneSuite._testsAndTestSuites = cloneTestsAndTestSuites;
		return cloneSuite;
	}
	
}
	
}
