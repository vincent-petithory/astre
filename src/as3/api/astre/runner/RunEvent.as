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
	
import astre.core.Test;
import flash.events.Event;
	
/**
 * A <code class="prettyprint">RunEvent</code> represents an 
 * event that occured when manipulating an 
 * <code class="prettyprint">ITestRunner</code>.
 * 
 * @see ITestRunner
 * 
 * @author lunar
 * 
 */
public class RunEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">RunEvent.RUN_START</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">runStart</code> event.
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
	 * 		<tr><td><code class="prettyprint">runner</code></td>
	 * 			<td>The <code class="prettyprint">ITestRunner</code> that 
	 * 			performed a <em>runStart</em> action. Generally, this matches 
	 * 			a call to the ITestRunner.runWith() method.
	 * 			</td></tr>
	 *  </table>
	 */
	public static const RUN_START:String = "runStart";
	
	/**
	 * The <code class="prettyprint">RunEvent.RUN_END</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">runEnd</code> event.
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
	 * 		<tr><td><code class="prettyprint">runner</code></td>
	 * 			<td>The <code class="prettyprint">ITestRunner</code> that 
	 * 			performed a <em>runEnd</em> action. Generally, this matches 
	 * 			a call to the ITestRunner.terminate() method.
	 * 			</td></tr>
	 *  </table>
	 */
	public static const RUN_END:String = "runEnd";
	
	/**
	 * The <code class="prettyprint">RunEvent.RUN_PAUSE</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">runPause</code> event.
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
	 * 		<tr><td><code class="prettyprint">runner</code></td>
	 * 			<td>The <code class="prettyprint">ITestRunner</code> that 
	 * 			performed a <em>runPause</em> action. Generally, this matches 
	 * 			a call to the ITestRunner.pause() method.
	 * 			</td></tr>
	 *  </table>
	 */
	public static const RUN_PAUSE:String = "runPause";
	
	/**
	 * The <code class="prettyprint">RunEvent.RUN_RESUME</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">runResume</code> event.
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
	 * 		<tr><td><code class="prettyprint">runner</code></td>
	 * 			<td>The <code class="prettyprint">ITestRunner</code> that 
	 * 			performed a <em>runResume</em> action. Generally, this matches 
	 * 			a call to the ITestRunner.resume() method.
	 * 			</td></tr>
	 *  </table>
	 */
	public static const RUN_RESUME:String = "runResume";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">ITestRunner</code> which is the 
	 * source of this <code class="prettyprint">RunEvent</code>.
	 */
	public var runner:ITestRunner;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	/**
	 * Constructor.
	 * 
	 * @param type The type of the event.
	 * @param runner The <code class="prettyprint">ITestRunner</code> 
	 * which is the source of this <code class="prettyprint">RunEvent</code>.
	 */
	public function RunEvent(type:String, runner:ITestRunner = null) 
	{ 
		super(type, false, false);
		this.runner = runner;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this <code class="prettyprint">RunEvent</code>.
	 * @return a clone of this <code class="prettyprint">RunEvent</code>.
	 */
	public override function clone():Event 
	{ 
		return new RunEvent(type, runner);
	} 
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">RunEvent</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">RunEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString("RunEvent", "type", "runner"); 
	}

}
	
}