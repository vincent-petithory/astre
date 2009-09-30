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

package astre.runner 
{
	
import astre.core.AtomicResult;
import astre.core.Test;
import flash.events.Event;
	
/**
 * A <code class="prettyprint">TestEvent</code> represents an 
 * event that occured when a <code class="prettyprint">Test</code> is 
 * being processed.
 * 
 * @see astre.core.Test
 * 
 * @author lunar
 * 
 */
public class TestEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">TestEvent.TEST_START</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">testStart</code> event.
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
	 * 		<tr><td><code class="prettyprint">test</code></td>
	 * 			<td>The <code class="prettyprint">Test</code> whose 
	 * 			process has just started.
	 * 			</td></tr>
	 * 		<tr><td><code class="prettyprint">result</code></td>
	 * 			<td>null</td>
	 * 		</tr>
	 *  </table>
	 */
	public static const TEST_START:String = "testStart";
	
	/**
	 * The <code class="prettyprint">TestEvent.TEST_END</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">testEnd</code> event.
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
	 * 		<tr><td><code class="prettyprint">test</code></td>
	 * 			<td>The <code class="prettyprint">Test</code> whose 
	 * 			process has just finished.
	 * 			</td></tr>
	 * 		<tr><td><code class="prettyprint">result</code></td>
	 * 			<td>The result of the process of 
	 * 			this <code class="prettyprint">Test</code>.</td>
	 * 		</tr>
	 *  </table>
	 */
	public static const TEST_END:String = "testEnd";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">Test</code> which is the 
	 * source of this <code class="prettyprint">TestEvent</code>.
	 */
	public var test:Test;
	
	/**
	 * The result of the process of 
	 * this <code class="prettyprint">Test</code>.
	 */
	public var result:AtomicResult;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	/**
	 * Constructor.
	 * 
	 * @param type The type of the event.
	 * @param test The <code class="prettyprint">Test</code> which is the 
	 * source of this <code class="prettyprint">TestEvent</code>.
	 * @param result The result of the process of 
	 * this <code class="prettyprint">Test</code>.
	 */
	public function TestEvent(
								type:String, 
								test:Test = null, 
								result:AtomicResult = null
							) 
	{ 
		super(type, false, false);
		this.test = test;
		this.result = result;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this <code class="prettyprint">TestEvent</code>.
	 * @return a clone of this <code class="prettyprint">TestEvent</code>.
	 */
	public override function clone():Event 
	{ 
		return new TestEvent(type, test, result);
	} 
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">TestEvent</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">TestEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString("TestEvent", "type", "test", "result"); 
	}

}
	
}