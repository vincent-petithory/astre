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
	import astre.async.AsyncCheckout;
	import astre.async.AsyncHandler;
	import astre.async.FunctionToken;
	import astre.async.IAsyncCheckout;
	import astre.core.Astre;
	import astre.core.processor.ITestProcessor;
	import astre.core.processor.TestProcessorInstruction;
	import astre.core.processor.TestProcessorInstructionType;
	import astre.core.ITestRunner;
	import astre.core.Reflection;
	import astre.core.TestDescription;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

/**
 * The <code class="prettyprint">Test</code> class is the base class 
 * of all unit tests.
 * 
 * <p>It provides the same scheme as the xUnit architecture provides.
 * This way, a unit test has a setUp(), tearDown() methods and the 
 * main method of the test.
 * However, the tests of the Astre architecture does not contain 
 * themselves the logic of how they are processed. Instead, this 
 * task is delegated to a <code class="prettyprint">ITestProcessor</code>.
 * Astre provides a default <code class="prettyprint">ITestProcessor</code>.
 * See <code class="prettyprint">astre.core.processor.TestProcessor</code> for 
 * more information on how tests are processed by default.</p>
 * 
 * <p>You have many tools available in order to write 
 * efficient tests :</p>
 * 
 * <ul>
 * 
 * <li>The most interesting feature is to add asynchronous checkouts 
 * during your tests. You do that by calling either the 
 * <code class="prettyprint">addAsync()</code> or 
 * the <code class="prettyprint">addDeferredAsync()</code>.</li>
 * 
 * <li>One very useful feature is to have resources that are shared 
 * by all your unit tests. Thoses resources are gathered in the 
 * <code class="prettyprint">testEnv</code> property, that 
 * have passed to the test runner. The advantage on defining 
 * shared resources is that they are created only one time. This is 
 * particularly useful when you need to collect data from a database, or 
 * to create complex objects (like parsing long xml files).</li>
 * 
 * <li>You can schedule a task in your test code. To do that, you call 
 * the <code class="prettyprint">addScheduledJob()</code> method.</li>
 * 
 * <li>You can ask a test process to wait for a specified amount of 
 * time before proceeding to the next synchronous method 
 * (setUp(), tearDown(), and the main test method). To do that, you 
 * call the <code class="prettyprint">wait()</code> method anywhere 
 * in your test code.</li>
 * 
 * <li>You can check that a function (in the scope of your test class) 
 * is called. To do that, you call the 
 * <code class="prettyprint">checkFunctionWillBeCalled()</code> method 
 * anywhere in your test code, then you call the 
 * <code class="prettyprint">markFunctionAsCalled()</code> in the 
 * function that is checked. This functionality is useful when you 
 * want to know if a function is called or not, and that this 
 * call is not a consequence of a listened event.</li>
 * 
 * <li>Sometimes, you may need to dispatch events. 
 * The <code class="prettyprint">Test</code> class provides a protected 
 * <code class="prettyprint">helpDispatcher</code> property of type 
 * <code class="prettyprint">IEventDispatcher</code> to do that.</li>
 * 
 * </ul>
 * 
 * <p>See the concerned methods/properties for more information on 
 * how to use them.</p>
 * 
 * @see Assertion
 * @see TraceUtil
 * @see astre.core.processor.TestProcessor
 * @see astre.core.ITestRunner
 * @see TestSuite
 * @see astre.core.AtomicResult
 * @see astre.core.TestDescription
 * @see astre.async.IAsyncCheckout
 * 
 * @author lunar
 * 
 */
public class Test extends Assertion
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The public instance methods that are defined by the 
	 * <code class="prettyprint">Test</code> class.
	 */
	public static const NOT_TEST_METHODS:Array = Reflection.getMethods(Test);
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The description of this <code class="prettyprint">Test</code>.
	 */
	public function get description():TestDescription
	{
		return new TestDescription(this);
	}
	
	/**
	 * @private
	 */
	Astre var asyncsHandler:AsyncHandler;
	
	/**
	 * @private
	 */
	Astre var runner:ITestRunner;
	
	/**
	 * @private
	 */
	private var _name:String;
	
    /**
     * The name of the test method to be run.
     */
    public function get name():String
    {
        return this._name;
    }
    
    /**
     * @private
     */
    public function set name(value:String):void
    {
        if (this.hasOwnProperty(name) && this[name] is Function)
		{
			this.name = name;
		}
		else
		{
			throw new TypeError("The method name '"+name+"' does not "+ 
			"exist for a "+this.description.className+" class test.");
		}
    }
    
	/**
	 * @private
	 */
	private var testProcessor:ITestProcessor;
	
	/**
	 * An event dispatcher helper object. You may use it in case you need 
	 * to dispatch events in your test subclass. If you plan to use it to 
	 * create a scheduled job, you should consider using the 
	 * <code class="prettyprint">Test.addScheduledJob()</code> method.
	 * 
	 * @see #addScheduledJob()
	 * 
	 */
	protected var helpDispatcher:IEventDispatcher;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * @param name The name of the method 
	 * to run for this <code class="prettyprint">Test</code>.
	 * 
	 * @throws   <code class="prettyprint">TypeError</code> - If the 
	 * specified method name does not 
	 * exist in this <code class="prettyprint">Test</code> class.
	 */
	public function Test(name:String = null) 
	{
		super();
		helpDispatcher = new EventDispatcher();
		this.Astre::asyncsHandler = new AsyncHandler();
        if (name != null && name != "")
        {
            this.name = name;
        }
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">setUp()</code> method is 
	 * generally called at the beginning of a test.
	 * 
	 * <p>You may override this method to initialize what you 
	 * need for a test. This method is run for each test method of 
	 * your test class.</p>
	 * 
	 * <p>The default test processor of Astre handles all 
	 * kinds of asynchronous checkouts in this method. This is useful 
	 * when you need to get resources asynchronously, from a server for 
	 * example.</p>
	 * 
	 * @see #tearDown()
	 * 
	 */
	public function setUp():void {}
	
	/**
	 * The <code class="prettyprint">tearDown()</code> method is 
	 * generally called at the end of a test.
	 * 
	 * <p>You may override this method to destroy what you have 
	 * created during a test in order to free memory. 
	 * This method is run for each test method of 
	 * your test class.</p>
	 * 
	 * <p>The default test processor of Astre handles all 
	 * kinds of asynchronous checkouts in this method.</p>
	 * 
	 * @see #setUp()
	 * 
	 */
	public function tearDown():void {}
	
	/**
	 * @private
	 * Runs this <code class="prettyprint">Test</code> with the 
	 * specified <code class="prettyprint">ITestRunner</code>.
	 * @param runner The runner that will run this 
	 * <code class="prettyprint">Test</code>.
	 */
	Astre function runWith(runner:ITestRunner):void
	{
		this.Astre::runner = runner;
		testProcessor = new 
				this.Astre::runner.runConfiguration.testProcessorClass(this);
		testProcessor.run();
	}
    
    /**
	 * Returns <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">Test</code> should be marked as ignored.
	 * Otherwise, <code class="prettyprint">false</code>.
	 * By default, all tests are not ignored.
	 * 
	 * <p>The treatment of an ignored test is deferred to the 
	 * <code class="prettyprint">ITestProcessor</code> that will run this 
	 * <code class="prettyprint">Test</code>.<br/>
	 * The default test processor of Astre stores a result of type 
	 * <code class="prettyprint">EResultType.IGNORED</code> for an 
	 * ignored test, but does not run it.</p>
	 * 
	 * @example The following code shows how to set a test method as ignored.
	 * It assumes those methods are declared in a subclass of 
	 * <code class="prettyprint">Test</code>.
	 * <pre class="prettyprint">
	 * ...
	 * 
	 * public function myIgnoredTestMethod():void
	 * {
	 * 		// statements...
	 * }
	 * 
	 * override public function isIgnored():Boolean
	 * {
	 * 		var methodName:String = this.Astre::runMethodName;
	 * 		var isIgnored:Boolean = false;
	 * 		switch (methodName)
	 * 		{
	 * 			case "myIgnoredTestMethod": 
	 * 				isIgnored = true;
	 * 				break;
	 * 			default:
	 * 				
	 * 		}
	 * 		return isIgnored;
	 * }
	 * 
	 * 
	 * </pre>
	 * 
	 * @return <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">Test</code> should be marked as ignored.
	 * Otherwise, <code class="prettyprint">false</code>.
	 */
	public function isIgnored():Boolean
	{
		return false;
	}
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">Test</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">Test</code>.
	 */
	public function toString():String
	{
		return this.description.getDisplay();
	}
	
	/**
	 * Returns a deep-copy of this test class.
	 * <p>If your Test class is not declared public, 
	 * you will need to override 
	 * this method.<br/>
	 * 
	 * For example :</p>
	 * <pre class="prettyprint">
	 * 
	 * internal class InternalTestClass extends Test
	 * {
	 * 
	 *   public function InternalTestClass(name:String)
	 *   {
	 *      super(name);
	 *   }
	 * 
	 *   override public function clone():Test
	 *   {
	 *      return new InternalTestClass(this.name);
	 *   }
	 * 
	 * }
	 * 
	 * </pre>
	 * 
	 * <p>Otherwise, it will throw an 
	 * <code class="prettyprint">ArgumentError</code> error.</p>
	 * 
	 * @return a deep-copy of this test class.
	 * @throws   <code class="prettyprint">ArgumentError</code> - if 
	 * this test class is not declared public.
	 */
	public function clone():Test
	{
		var thisClass:Class;
		try
		{
			thisClass = getDefinitionByName(
							describeType(this).attribute("name").toString()
						) as Class;
		} catch (re:ReferenceError)
		{
			throw new ArgumentError(
						"Non-public test classes cannot be cloned."
					);
		}
        var t:Test = new thisClass() as Test;
        if (t == null)
            throw new ArgumentError("The class to clone is not a Test subclass.");
        
        t.name = this.name;
        return t;
	}
	
	/**
	 * Creates an asynchronous checkout for this 
	 * <code class="prettyprint">Test</code>. With the 
	 * default test processor of Astre, the checkout 
	 * starts immediately after this method returns.
	 * 
	 * <p>You may use use this method inside any of the following 
	 * methods of your <code class="prettyprint">Test</code> class :</p>
	 * 
	 * <ul>
	 * <li>setUp()</li>
	 * <li>tearDown()</li>
	 * <li>your main test method</li>
	 * <li>any method passed to a method that generates an asynchronous 
	 * checkout method (see <em>note 1</em>)</li>
	 * <li>more generally, all the functions in the scope of your 
	 * test class that should possibly 
	 * be executed during the process of the test.</li>
	 * </ul>
	 * 
	 * <p><strong>Note 1: </strong>the following methods generate 
	 * asynchronous checkouts :</p>
	 * <ul>
	 * <li>addAsync()</li>
	 * <li>addDeferredAsync()</li>
	 * <li>addScheduledJob()</li>
	 * <li>wait()</li>
	 * <li>waitFor()</li>
	 * </ul>
	 * 
	 * @param timeout The time to wait for the event to be 
	 * dispatched, in milliseconds.
	 * @param dispatcher The <code class="prettyprint">IEventDispatcher</code> 
	 * that is supposed either to dispatch the expected event, or to listen to 
	 * the expected event.
	 * @param type The type of the expected event.
	 * @param asyncFunction The function that should be executed if the 
	 * expected event is successfully dispatched on the specified dispatcher.
	 * The function you provide must provide a parameter that is compatible 
	 * with the expected event. It may expose a second parameter whose 
	 * type matches the one of the data passed to this function, if the 
	 * <code class="prettyprint">data</code> parameter is not 
	 * <code class="prettyprint">null</code>. The function must not 
	 * expose more than two parameters.
	 * @param data The data to pass to the 
	 * <code class="prettyprint">asyncFunction</code> function. The 
	 * function must expose a second parameter whose 
	 * type matches the one of the 
	 * <code class="prettyprint">data</code>, if it is not 
	 * <code class="prettyprint">null</code>.
	 * @param failFunction The function that should be executed if the 
	 * expected event is not dispatched on the specified dispatcher.
	 * The function you provide must provide a parameter that is compatible 
	 * with the data passed to this function, if the 
	 * <code class="prettyprint">failData</code> parameter is not 
	 * <code class="prettyprint">null</code>.
	 * @param failData The data to pass to the 
	 * <code class="prettyprint">failFunction</code> function. The 
	 * function must expose only one parameter whose 
	 * type matches the one of the 
	 * <code class="prettyprint">failData</code> parameter, if it is not 
	 * <code class="prettyprint">null</code>. The function must not 
	 * expose more than one parameter.
	 * @param useCapture Whether the event should be listen on the 
	 * capture phase. See the 
	 * <code class="prettyprint">EventDispatcher</code> and the 
	 * <code class="prettyprint">Event</code> classes for more information 
	 * on the event flow model.
	 * @param priority The priority of the listener of the expected event.
	 * See the 
	 * <code class="prettyprint">EventDispatcher</code> 
	 * class for more information on the event flow model.
	 * 
	 * @example The following code shows how to create an 
	 * asynchronous checkout inside a test : a test runner runs several 
	 * tests, and it is asked to wait for the end of the process of the tests.
	 * Then it is checked that the number of tests to be run is equal to 
	 * the tests really run.
	 * It assumes : 
	 * <ul>
	 * <li>The <code class="prettyprint">numTestsRunAndNumTestsTest</code> 
	 * and <code class="prettyprint">onRunEnd</code> functions are 
	 * declared inside the scope of a 
	 * <code class="prettyprint">Test</code> subclass.</li>
	 * <li><code class="prettyprint">TestsContainer</code> is a 
	 * class aggregating several tests.</li>
	 * </ul>
	 * 
	 * <pre class="prettyprint">
	 * public function numTestsRunAndNumTestsTest():void
	 * {
	 * 	var runner:ITestRunner = new TestRunner();
	 *  var pn:IProgressNotifier = runner.progressNotifier;
	 * 	this.addAsync(10000, pn, RunEvent.RUN_END, onRunEnd);
	 * 	runner.runWith(RunRequest.testClass(TestsContainer));
	 * }
	 * 
	 * private function onRunEnd(event:RunEvent):void
	 * {
	 * 	assertEquals(runner.numTests, runner.numTestsRun);
	 * }
	 * 
	 * </pre>
	 * 
	 * @see #addDeferredAsync()
	 * @see astre.core.processor.TestProcessor
	 * 
	 */
	protected function addAsync(timeout:int, 
										dispatcher:IEventDispatcher, 
										type:String, 
										asyncFunction:Function, 
										data:Object = null, 
										failFunction:Function = null, 
										failData:Object = null, 
										useCapture:Boolean = false, 
										priority:int = 0):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
		checkout.checkout(
				timeout, dispatcher, type, 
				asyncFunction, data, failFunction, failData, 
				useCapture, priority
			);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
	}
	
	/**
	 * Creates an asynchronous checkout for this 
	 * <code class="prettyprint">Test</code>. With the 
	 * default test processor of Astre, after this method returns, 
	 * the checkout starts as soon as the following conditions are 
	 * fulfilled :
	 * <ul>
	 * <li>The test method 
	 * in which it is called returns, or a method that has been 
	 * called by another checkout has just finished being processed.<li>
	 * <li>All the previous checkouts declared by the 
	 * <code class="prettyprint">addDeferredAsync()</code> have been 
	 * started.</li>
	 * </ul>
	 * 
	 * <p>You may use use this method inside any of the following 
	 * methods of your <code class="prettyprint">Test</code> class :</p>
	 * 
	 * <ul>
	 * <li>setUp()</li>
	 * <li>tearDown()</li>
	 * <li>your main test method</li>
	 * <li>any method passed to a method that generates an asynchronous 
	 * checkout method (see <em>note 1</em>)</li>
	 * <li>more generally, all the functions in the scope of your 
	 * test class that should possibly 
	 * be executed during the process of the test.</li>
	 * </ul>
	 * 
	 * <p><strong>Note 1: </strong>the following methods generate 
	 * asynchronous checkouts :</p>
	 * <ul>
	 * <li>addAsync()</li>
	 * <li>addDeferredAsync()</li>
	 * <li>addScheduledJob()</li>
	 * <li>wait()</li>
	 * <li>waitFor()</li>
	 * </ul>
	 * 
	 * @param timeout The time to wait for the event to be 
	 * dispatched, in milliseconds.
	 * @param dispatcher The <code class="prettyprint">IEventDispatcher</code> 
	 * that is supposed either to dispatch the expected event, or to listen to 
	 * the expected event.
	 * @param type The type of the expected event.
	 * @param asyncFunction The function that should be executed if the 
	 * expected event is successfully dispatched on the specified dispatcher.
	 * The function you provide must provide a parameter that is compatible 
	 * with the expected event. It may expose a second parameter whose 
	 * type matches the one of the data passed to this function, if the 
	 * <code class="prettyprint">data</code> parameter is not 
	 * <code class="prettyprint">null</code>. The function must not 
	 * expose more than two parameters.
	 * @param data The data to pass to the 
	 * <code class="prettyprint">asyncFunction</code> function. The 
	 * function must expose a second parameter whose 
	 * type matches the one of the 
	 * <code class="prettyprint">data</code>, if it is not 
	 * <code class="prettyprint">null</code>.
	 * @param failFunction The function that should be executed if the 
	 * expected event is not dispatched on the specified dispatcher.
	 * The function you provide must provide a parameter that is compatible 
	 * with the data passed to this function, if the 
	 * <code class="prettyprint">failData</code> parameter is not 
	 * <code class="prettyprint">null</code>.
	 * @param failData The data to pass to the 
	 * <code class="prettyprint">failFunction</code> function. The 
	 * function must expose only one parameter whose 
	 * type matches the one of the 
	 * <code class="prettyprint">failData</code> parameter, if it is not 
	 * <code class="prettyprint">null</code>. The function must not 
	 * expose more than one parameter.
	 * @param useCapture Whether the event should be listen on the 
	 * capture phase. See the 
	 * <code class="prettyprint">EventDispatcher</code> and the 
	 * <code class="prettyprint">Event</code> classes for more information 
	 * on the event flow model.
	 * @param priority The priority of the listener of the expected event.
	 * See the 
	 * <code class="prettyprint">EventDispatcher</code> 
	 * class for more information on the event flow model.
	 * 
	 * @see #addAsync()
	 * @see astre.core.processor.TestProcessor
	 * 
	 */
	protected function addDeferredAsync(timeout:int, 
										dispatcher:IEventDispatcher, 
										type:String, 
										asyncFunction:Function, 
										data:Object = null, 
										failFunction:Function = null, 
										failData:Object = null, 
										useCapture:Boolean = false, 
										priority:int = 0):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
		checkout.checkout(
				timeout, dispatcher, type, 
				asyncFunction, data, failFunction, failData, 
				useCapture, priority
			);
		// checkout is added to async handler for later processing.
		this.Astre::asyncsHandler.addCheckout(checkout);
	}
	
	/**
	 * Schedules an asynchronous job. As with other checkout 
	 * methods, you can use assertion methods in the asynchronous 
	 * function.
	 * 
	 * @param timeout The time, in milliseconds, in which this 
	 * job will start.
	 * @param name The name of the job.
	 * @param func The function that will perform the job. The function 
	 * must provide only one argument whose type is compatible with 
	 * the one of the <code class="prettyprint">data</code> 
	 * property, and only if the 
	 * <code class="prettyprint">data</code> property is 
	 * not <code class="prettyprint">null</code>.
	 * @param data The data to pass to the function.
	 * 
	 * @see astre.core.processor.TestProcessor
	 * 
	 */
	protected function addScheduledJob(	timeout:int, 
										name:String, 
										func:Function, 
										data:Object = null):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
		checkout.checkout(
				timeout, helpDispatcher, name, 
				null, null, func, data
			);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
	}
	
	/**
	 * Asks the test processor to wait for the specified event 
	 * to be dispatched before proceeding to the next main function 
	 * of the test (which are setUp(), tearDown() and the main test method).
	 * The specified fail function is called if the event is not dispatched.
	 * 
	 * 
	 * @param timeout The time, in milliseconds, to wait for the expected 
	 * event.
	 * @param dispatcher The <code class="prettyprint">IEventDispatcher</code> 
	 * that is supposed either to dispatch the expected event, or to listen to 
	 * the expected event.
	 * @param type The type of the expected event.
	 * @param failFunction The function that should be executed if the 
	 * expected event is not dispatched on the specified dispatcher.
	 * The function you provide must provide a parameter that is compatible 
	 * with the data passed to this function, if the 
	 * <code class="prettyprint">failData</code> parameter is not 
	 * <code class="prettyprint">null</code>.
	 * @param failData The data to pass to the 
	 * <code class="prettyprint">failFunction</code> function. The 
	 * function must expose only one parameter whose 
	 * type matches the one of the 
	 * <code class="prettyprint">failData</code> parameter, if it is not 
	 * <code class="prettyprint">null</code>. The function must not 
	 * expose more than one parameter.
	 * @param useCapture Whether the event should be listen on the 
	 * capture phase. See the 
	 * <code class="prettyprint">EventDispatcher</code> and the 
	 * <code class="prettyprint">Event</code> classes for more information 
	 * on the event flow model.
	 * @param priority The priority of the listener of the expected event.
	 * See the 
	 * <code class="prettyprint">EventDispatcher</code> 
	 * class for more information on the event flow model.
	 * 
	 * @example The following code shows a possible usage of this method.
	 * An URLLoader object loads some xml data needed for the tests in the 
	 * setUp() method. We tell the test processor to wait for 
	 * the Event.COMPLETE event before processing the 
	 * main method of the test :
	 * 
	 * <pre class="prettyprint">
	 * override public function setUp():void
	 * {
	 * 		var loader:URLLoader = new URLLoader();
	 * 		this.waitFor(5000, loader, Event.COMPLETE);
	 * 		loader.load(new URLRequest("data.xml");
	 * }
	 * </pre>
	 * 
	 * 
	 */
	protected function waitFor(timeout:int, 
								dispatcher:IEventDispatcher, 
								type:String, 
								failFunction:Function = null, 
								failData:Object = null, 
								useCapture:Boolean = false, 
								priority:int = 0
							):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
								
		checkout.checkout(
					timeout, 
					dispatcher, 
					type, 
					FunctionToken.EMPTY_EVENT_FUNCTION, 
					null, 
					failFunction, 
					failData, 
					useCapture, 
					priority 
				);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
	}
	
	/**
	 * Asks the test processor to wait for the specified event 
	 * to be dispatched before proceeding to the next main function 
	 * of the test (which are setUp(), tearDown() and the main test method), 
	 * or after the specified timeout ends.
	 * 
	 * @param timeout The time, in milliseconds, to wait for the expected 
	 * event.
	 * @param dispatcher The <code class="prettyprint">IEventDispatcher</code> 
	 * that is supposed either to dispatch the expected event, or to listen to 
	 * the expected event.
	 * @param type The type of the expected event.
	 * @param useCapture Whether the event should be listen on the 
	 * capture phase. See the 
	 * <code class="prettyprint">EventDispatcher</code> and the 
	 * <code class="prettyprint">Event</code> classes for more information 
	 * on the event flow model.
	 * @param priority The priority of the listener of the expected event.
	 * See the 
	 * <code class="prettyprint">EventDispatcher</code> 
	 * class for more information on the event flow model.
	 * 
	 * @example The following code shows a possible usage of this method.
	 * An URLLoader object loads some xml data needed for the tests in the 
	 * setUp() method. We tell the test processor to wait for 
	 * the Event.COMPLETE event before processing the 
	 * main method of the test :
	 * 
	 * <pre class="prettyprint">
	 * override public function setUp():void
	 * {
	 * 		var loader:URLLoader = new URLLoader();
	 * 		this.waitFor(5000, loader, Event.COMPLETE);
	 * 		loader.load(new URLRequest("data.xml");
	 * }
	 * </pre>
	 * 
	 * 
	 */
	protected function lazyWaitFor(timeout:int, 
								dispatcher:IEventDispatcher, 
								type:String, 
								useCapture:Boolean = false, 
								priority:int = 0
							):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
								
		checkout.checkout(
					timeout, 
					dispatcher, 
					type, 
					FunctionToken.EMPTY_EVENT_FUNCTION, 
					null, 
					FunctionToken.EMPTY_FUNCTION, 
					null, 
					useCapture, 
					priority 
				);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
	}
	
	/**
	 * Asks the test processor to wait the specified amount of time 
	 * before proceeding to the next main function 
	 * of the test (which are setUp(), tearDown() and the main test method).
	 * 
	 * @param timeout The time, in milliseconds, to wait for the expected 
	 * event.
	 * 
	 * @see #waitFor()
	 * 
	 */
	protected function wait(timeout:int):void
	{
		var checkout:IAsyncCheckout = new AsyncCheckout(
									this.Astre::asyncsHandler.getUniqueId()
								);
								
		var type:String = "wait"+timeout+""+
							Math.floor(Math.random()*uint.MAX_VALUE);
		checkout.checkout(
					timeout, 
					helpDispatcher, 
					type, 
					null, 
					null, 
					FunctionToken.EMPTY_FUNCTION
				);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
	}
	
	/**
	 * Checks a function in the test class scope will be called in 
	 * the specified time. This function returns a 
	 * <code class="prettyprint">FunctionToken</code> that you must pass 
	 * to the <code class="prettyprint">markFunctionAsCalled()</code> 
	 * method to notify the test processor that you validate the 
	 * call to the function. So, the function in which you call 
	 * the <code class="prettyprint">markFunctionAsCalled()</code> method 
	 * is the function that is checked.
	 * 
	 * <p>You may find this method useful when you need to check that 
	 * a function has to be called, but not consequently to 
	 * an event triggering. For example, you may need that to check 
	 * a function responder passed to the 
	 * <code class="prettyprint">NetConnection.call()</code> method.</p>
	 * 
	 * @param timeout The time, in milliseconds, allowed for the function 
	 * to be called.
	 * @param funcName The name of the function. This name is used 
	 * to display a specific message if the function is not called.
	 * 
	 * @return A <code class="prettyprint">FunctionToken</code> that you 
	 * may pass to the 
	 * <code class="prettyprint">markFunctionAsCalled()</code> method.
	 * 
	 * @see #markFunctionAsCalled()
	 * 
	 */
	protected function checkFunctionWillBeCalled(
						timeout:int, 
						funcName:String
					):FunctionToken
	{
		var id:uint = this.Astre::asyncsHandler.getUniqueId();
		var checkout:IAsyncCheckout = new AsyncCheckout(
									id
								);
		
		var token:FunctionToken = new FunctionToken(funcName, id);
		checkout.checkout(
				timeout, helpDispatcher, 
				token.eventType, FunctionToken.EMPTY_EVENT_FUNCTION
			);
		
		testProcessor.execute(new TestProcessorInstruction(
			TestProcessorInstructionType.ASK_START_SPECIFIC_ASYNC_PROCESS, 
			checkout)
		);
		return token;
	}
	
	/**
	 * Notifies that the function in which it is called, is called. 
	 * 
	 * @param functionToken The 
	 * <code class="prettyprint">FunctionToken</code> returned by 
	 * the <code class="prettyprint">checkFunctionWillBeCalled()</code> 
	 * method.
	 * 
	 * @see #checkFunctionWillBeCalled()
	 */
	protected function markFunctionAsCalled(functionToken:FunctionToken):void
	{
		this.helpDispatcher.dispatchEvent(new Event(functionToken.eventType));
	}
	
}
	
}
