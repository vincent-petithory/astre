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
	
import astre.core.processor.ITestProcessor;
import astre.core.processor.TestProcessor;

/**
 * A <code class="prettyprint">RunConfiguration</code> is an object 
 * you pass to an <code class="prettyprint">ITestRunner</code>. Please note this
 * is an advanced feature, so you don't need it in regular cases.
 * 
 * <p>Basically, it allows to select a test processor class to use 
 * for running the tests. Besides, the 
 * <code class="prettyprint">RunConfiguration</code> class is dynamic, 
 * so that you can add and use the properties you need for your 
 * implementation of your own test processor</p>
 * 
 * 
 * @example This code shows how to tell an 
 * <code class="prettyprint">ITestRunner</code> to use a specific 
 * test processor class : 
 * <pre class="prettyprint">
 * 
 * var runConfig:RunConfiguration = new RunConfiguration();
 * runConfig.testProcessorClass = path.to.my.CustomTestProcessor;
 * var runner:ITestRunner = new TestRunner(null, runConfig);
 * 
 * </pre>
 * 
 * @see ITestRunner
 * 
 * @author lunar
 * 
 */
public class RunConfiguration
{
	
	/**
	 * @private
	 */
	private var _testProcessorClass:Class = TestProcessor;
	
	/**
	 * The test processor class that will be used when passing this 
	 * <code class="prettyprint">RunConfiguration</code> to an 
	 * <code class="prettyprint">ITestRunner</code>.
	 * 
	 * <p>The specified test processor class must implement the 
	 * <code class="prettyprint">ITestProcessor</code> interface.
	 * Otherwise, setting a invalid value will throw an 
	 * <code class="prettyprint">ArgumentError</code>.</p>
	 * 
	 * @default astre.core.processor.TestProcessor
	 * 
	 * @throws   <code class="prettyprint">ArgumentError</code> - if 
	 * the class set does not implement 
	 * the <code class="prettyprint">ITestProcessor</code> interface.
	 * 
	 */
	public function get testProcessorClass():Class
	{
		return _testProcessorClass;
	}
	
	/**
	 * @private
	 */
	public function set testProcessorClass(value:Class):void 
	{
		if (!Reflection.isImplementorOf(value, ITestProcessor))
		{
			throw new ArgumentError(
					"The specified class must implement the "+
					"astre.core.processor.ITestProcessor class");
		}
		_testProcessorClass = value;
	}
	
	/**
	 * Wether to exit automatically when all tests have run.
	 * Works only when tests are run in a standalone version 
	 * of Flash Player (not in a browser) 
	 * or in the AIR Runtime.
	 */
	public var exitOnFinish:Boolean = true;
	
	
}

}
