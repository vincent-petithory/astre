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
	
import astre.processor.process.ETestProcessPhase;
import astre.core.Test;
import flash.events.Event;
	
/**
 * A <code class="prettyprint">TestProgressEvent</code> represents an 
 * event that occured when a unit process of a 
 * <code class="prettyprint">Test</code> has just finished.
 * 
 * @see astre.processor.ITestProcessor
 * @see astre.processor.ITestProcess
 * 
 * @author lunar
 * 
 */
public class TestProgressEvent extends Event 
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
	 * 			process has just finished.
	 * 			</td></tr>
	 * 		<tr><td><code class="prettyprint">processPhase</code></td>
	 * 			<td>The <code class="prettyprint">ETestProcessPhase</code> 
	 * 			phase of the <code class="prettyprint">ITestProcess</code> 
	 * 			that has just finished being processed.</td>
	 * 		</tr>
	 * 		<tr><td><code class="prettyprint">processesRun</code></td>
	 * 			<td>The number of processes already processed for 
	 * 			the related <code class="prettyprint">Test</code>, 
	 * 			including this process which has just finished.</td>
	 * 		</tr>
	 * 		<tr><td><code class="prettyprint">processesTotal</code></td>
	 * 			<td>The total number of processes the related 
	 * 			<code class="prettyprint">Test</code> actually contains.</td>
	 * 		</tr>
	 *  </table>
	 */
	public static const TEST_PROGRESS:String = "testProgress";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">Test</code> which is the 
	 * source of this <code class="prettyprint">TestProgressEvent</code>.
	 */
	public var test:Test;
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> in which this 
	 * <code class="prettyprint">TestProgressEvent</code> occured.
	 */
	public var processPhase:ETestProcessPhase;
	
	/**
	 * The number of processes already processed for 
	 * the related <code class="prettyprint">Test</code>.
	 */
	public var processesRun:uint;
	
	/**
	 * The total number of processes the related 
	 * <code class="prettyprint">Test</code> actually contains.
	 */
	public var processesTotal:uint;
	
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
	 * source of this <code class="prettyprint">TestProgressEvent</code>.
	 * @param processPhase The 
	 * <code class="prettyprint">ETestProcessPhase</code> in which this 
	 * <code class="prettyprint">TestProgressEvent</code> occured.
	 * @param processesRun The number of processes already processed for 
	 * this <code class="prettyprint">Test</code>.
	 * @param processesTotal The total number of processes this 
	 * <code class="prettyprint">Test</code> actually contains.
	 */
	public function TestProgressEvent(
				type:String, 
				test:Test = null, 
				processPhase:ETestProcessPhase = null, 
				processesRun:uint = 0, 
				processesTotal:uint = 0
			) 
	{ 
		super(type, false, false);
		this.test = test;
		this.processPhase = processPhase;
		this.processesRun = processesRun;
		this.processesTotal = processesTotal;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this 
	 * <code class="prettyprint">TestProgressEvent</code>.
	 * @return a clone of this 
	 * <code class="prettyprint">TestProgressEvent</code>.
	 */
	public override function clone():Event 
	{ 
		return new TestProgressEvent(
							type, 
							test, 
							processPhase, 
							processesRun, 
							processesTotal
						);
	} 
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">TestProgressEvent</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">TestProgressEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString(
						"TestProgressEvent", 
						"type", 
						"test", 
						"processPhase", 
						"processesRun", 
						"processesTotal"
					); 
	}

}
	
}