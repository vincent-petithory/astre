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

package astre.processor.process 
{
	
import astre.processor.ITestProcess;
import astre.processor.TestProcessorInstruction;
import flash.events.Event;
	
/**
 * A <code class="prettyprint">TestProcessEvent</code> is 
 * dispatched by an <code class="prettyprint">ITestProcess</code> to 
 * notify its progress.
 * 
 * @see astre.processor.ITestProcess
 * 
 * @author lunar
 * 
 */
public class TestProcessEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The 
	 * <code class="prettyprint">TestProcessEvent.TEST_PROCESS_START</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">testProcessStart</code> event.
	 * 
	 * <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th>
	 * 			<th>Value</th></tr>
	 *     <tr><td><code class="prettyprint">bubbles</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">cancelable</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">currentTarget</code></td>
	 * 			<td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code class="prettyprint">myButton.addEventListener()</code> 
	 * 			to register an event listener, 
	 *       myButton is the value of the 
	 * 		<code class="prettyprint">currentTarget</code>. </td></tr>
	 *     <tr><td><code class="prettyprint">target</code></td>
	 * 		<td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code class="prettyprint">currentTarget</code> 
	 * 		property to always access the 
	 *       Object listening for the event.</td></tr>
	 * 		<tr><td><code class="prettyprint">testProcess</code></td>
	 * 			<td>The <code class="prettyprint">ITestProcess</code> that 
	 * 			has just been started.
	 * 			</td>
	 * 		</tr>
	 * 		<tr><td><code class="prettyprint">forceCommand</code></td>
	 * 			<td>null</td>
	 * 		</tr>
	 *  </table>
	 */
	public static const TEST_PROCESS_START:String = "testProcessStart";
	
	/**
	 * The 
	 * <code class="prettyprint">TestProcessEvent.TEST_PROCESS_END</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">testProcessEnd</code> event.
	 * 
	 * <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th>
	 * 			<th>Value</th></tr>
	 *     <tr><td><code class="prettyprint">bubbles</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">cancelable</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">currentTarget</code></td>
	 * 			<td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code class="prettyprint">myButton.addEventListener()</code> 
	 * 			to register an event listener, 
	 *       myButton is the value of the 
	 * 		<code class="prettyprint">currentTarget</code>. </td></tr>
	 *     <tr><td><code class="prettyprint">target</code></td>
	 * 		<td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code class="prettyprint">currentTarget</code> 
	 * 		property to always access the 
	 *       Object listening for the event.</td></tr>
	 * 		<tr><td><code class="prettyprint">testProcess</code></td>
	 * 			<td>The <code class="prettyprint">ITestProcess</code> that 
	 * 			has just been started.
	 * 			</td>
	 * 		</tr>
	 * 		<tr><td><code class="prettyprint">forceCommand</code></td>
	 * 			<td>An optional instruction this 
	 * 		<code class="prettyprint">TestProcessEvent</code> will carry.</td>
	 * 		</tr>
	 *  </table>
	 */
	public static const TEST_PROCESS_END:String = "testProcessEnd";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">ITestProcess</code> 
	 * related to this 
	 * <code class="prettyprint">TestProcessEvent</code>.
	 */
	public var testProcess:ITestProcess;
	
	/**
	 * An optional instruction this 
	 * <code class="prettyprint">TestProcessEvent</code> will carry. 
	 * Most often, an 
	 * <code class="prettyprint">ITestProcessor</code> will 
	 * use it.
	 */
	public var forceCommand:TestProcessorInstruction;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	/**
	 * Constructor.
	 * 
	 * @param type The type of the event.
	 * @param testProcess The <code class="prettyprint">ITestProcess</code> 
	 * related to this 
	 * <code class="prettyprint">TestProcessEvent</code>.
	 * @param forceCommand
	 */
	public function TestProcessEvent(
				type:String, 
				testProcess:ITestProcess = null, 
				forceCommand:TestProcessorInstruction = null
			) 
	{ 
		super(type, false, false);
		this.testProcess = testProcess;
		this.forceCommand = forceCommand;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this 
	 * <code class="prettyprint">TestProcessEvent</code>.
	 * @return a clone of this 
	 * <code class="prettyprint">TestProcessEvent</code>.
	 */
	public override function clone():Event 
	{ 
		return new TestProcessEvent(type, testProcess, forceCommand);
	} 
	
	/**
	 * Returns a string representation of 
	 * this <code class="prettyprint">TestProcessEvent</code>.
	 * @return a string representation of 
	 * this <code class="prettyprint">TestProcessEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString(
						"TestProcessEvent", 
						"type", 
						"testProcess", 
						"forceCommand"
					); 
	}

}
	
}