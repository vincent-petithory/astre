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
	import astre.util.Reflection;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

/**
 * A <code class="prettyprint">TestList</code> object holds 
 * a collection of tests that you can then pass to a runner 
 * using a <code class="prettyprint">RunRequest</code> object.
 * 
 * @see Test
 * @see astre.runner.RunRequest
 * 
 * @author lunar
 * 
 */
public class TestList 
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
	 * <code class="prettyprint">TestList</code>. If you do like this, 
	 * the name of your method must be the value of 
	 * <code class="prettyprint">TestList.staticTestListFunctionName</code>.
	 * 
	 * @default testList
	 * 
	 * @see TestList#addTestClass()
	 */
	public static var staticTestListFunctionName:String = "list";
	
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
	 * Tests and testList are in the 
	 * same array to keep order.
	 */
	private var _testsAndTestLists:Array;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function TestList() 
	{
		super();
		_testsAndTestLists = new Array();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Adds a test object to this 
	 * <code class="prettyprint">TestList</code>.
	 * 
	 * @param test The test to be added. It can be : 
     * <ul>
     * <li>a TestList class or instance, </li>
     * <li>a Test class or instance, </li>
     * <li>a class with a static method returning a TestList.</li>
     * </ul>
     * 
	 */
	public function addTest(test:*):void
	{
		if (test is Test)
			addTest(test as Test);
		else if (test is Class)
			addTestClass(test as Class);
		else if (test is TestList)
			addTestList(test as TestList);
	}

	/**
	 * Adds a test to this 
	 * <code class="prettyprint">TestList</code>.
	 * 
	 * @param test The test to be added.
	 */
	protected function addTest(test:Test):void
	{
		_testsAndTestLists.push(test);
	}
	
	/**
	 * Uses a class to add tests and/or test lists to this 
	 * <code class="prettyprint">TestList</code>.
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
	 * <code class="prettyprint">TestList</code> and whose name matches 
	 * the value of the 
	 * <code class="prettyprint">staticTestListFunctionName</code> 
	 * property.</li>
	 * <li>Any class that provides a static method that returns a 
	 * <code class="prettyprint">TestList</code> and whose name matches 
	 * the value of the 
	 * <code class="prettyprint">staticTestListFunctionName</code> 
	 * property.</li>
	 * </ul>
	 * </p>
	 * 
	 * @param testClass The class to be processed for adding 
	 * tests and test lists.
	 * 
	 * @throws   <code class="prettyprint">ArgumentError</code> - If 
	 * the specified class does not provide a 
	 * static method that returns a astre.core.TestList object 
	 * or it is not a astre.core.Test subclass.
	 * @throws   <code class="prettyprint">TypeError</code> - If 
	 * the specified class is null.
	 * 
	 * @see TestList#staticTestListFunctionName
	 */
	protected function addTestClass(testClass:Class):void
	{
		if (testClass != null)
		{
			var desc:XMLList = 
				describeType(testClass).child("method").(@name == 
					TestList.staticTestListFunctionName);
			if (desc.length() == 1 && 
				desc.@returnType == getQualifiedClassName(TestList)
				)
			{
				this.addTestList(
					testClass[TestList.staticTestListFunctionName].apply(testClass)
				);
			}
			else if (Reflection.isSubClassOf(testClass, Test))
			{
				var testList:TestList = new TestList();
				var methods:Array = Reflection.getMethods(testClass);
				// reverse for alphabetical order by default
				methods = methods.filter(testMethodFilter).reverse();
				for each (var method:String in methods)
				{
					testList.addTest(new testClass(method) as Test);
				}
				this.addTestList(testList);
			}
			else
			{
				throw new ArgumentError(
					"The specified class "+testClass+" does not provide a "+
					"static method named "+TestList.staticTestListFunctionName+
					" "+"that returns a astre.core.TestList object "+
					"or it is not a astre.core.Test subclass.");
			}
		}
		else
		{
			throw new TypeError("The specified class is null");
		}
	}
	
	/**
	 * Adds a test list to this <code class="prettyprint">TestList</code>.
	 * 
	 * @param testList The <code class="prettyprint">TestList</code> to 
	 * be added.
	 * 
	 * @throws   <code class="prettyprint">TypeError</code> - If the 
	 * specified 
	 * <code class="prettyprint">TestList</code> is 
	 * <code class="prettyprint">null</code>.
	 * 
	 */
	protected function addTestList(testList:TestList):void
	{
		if (testList != null)
		{
			_testsAndTestLists.push(testList as TestList);
		}
		else
		{
			throw new TypeError("The specified testList must not be null");
		}
	}
	
	/**
	 * Returns an array of the tests this 
	 * <code class="prettyprint">TestList</code> carry.
	 * 
	 * <p>Nested <code class="prettyprint">TestList</code> this 
	 * <code class="prettyprint">TestList</code> carry are recursively 
	 * processed to return only <code class="prettyprint">Test</code> 
	 * instances.</p>
	 * 
	 * @return an array of the tests this 
	 * <code class="prettyprint">TestList</code> carry.
	 */
	public function getTests():Array
	{
		var tests:Array = new Array();
		
		for each (var obj:* in _testsAndTestLists)
		{
			if (obj is TestList)
			{
				tests = tests.concat((obj as TestList).getTests());
			}
			else if (obj is Test)
			{
				tests.push(obj as Test);
			}
		}
		return tests;
	}
	
	/**
	 * Returns a clone of this <code class="prettyprint">TestList</code>.
	 * @return a clone of this <code class="prettyprint">TestList</code>.
	 */
	public function clone():TestList
	{
		var cloneTestsAndTestLists:Array = new Array();
		
		for each (var obj:* in _testsAndTestLists)
		{
			if (obj is TestList || obj is Test)
			{
				cloneTestsAndTestLists.push(obj.clone());
			}
		}
		var cloneList:TestList = new TestList();
		cloneList._testsAndTestLists = cloneTestsAndTestLists;
		return cloneList;
	}
	
}
	
}
