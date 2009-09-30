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

package astre.core.processor 
{
	
import flash.events.Event;

/**
 * A <code class="prettyprint">TestProcessorInstructionEvent</code> event 
 * allows to command an <code class="prettyprint">ITestProcessor</code> to 
 * execute an asynchronous 
 * <code class="prettyprint">TestProcessorInstruction</code>.
 * 
 * @see ITestProcessor
 * @see TestProcessorInstruction
 * 
 * @author lunar
 * 
 */
public class TestProcessorInstructionEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The 
	 * <code class="prettyprint">TestProcessorInstructionEvent.INSTRUCTION</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">instruction</code> event.
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
	 * 		<tr><td><code class="prettyprint">instruction</code></td>
	 * 			<td>The 
	 * 			<code class="prettyprint">TestProcessorInstruction</code> 
	 * 			to be carried with this 
	 * 			<code class="prettyprint">TestProcessorInstructionEvent</code> 
	 * 			</td>
	 *		</tr>
	 *  </table>
	 */
	public static const INSTRUCTION:String = "instruction";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The instruction to be executed.
	 */
	public var instruction:TestProcessorInstruction;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor
	 * 
	 * @param type The type of the event. Actually, there is only one 
	 * type : 
	 * <code class="prettyprint">TestProcessorInstructionEvent.INSTRUCTION</code>.
	 * @param instruction The instruction to be executed.
	 */
	public function TestProcessorInstructionEvent(
							type:String, 
							instruction:TestProcessorInstruction
						) 
	{ 
		super(type, false, false);
		this.instruction = instruction;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this 
	 * <code class="prettyprint">TestProcessorInstructionEvent</code>.
	 * @return
	 */
	public override function clone():Event 
	{ 
		return new TestProcessorInstructionEvent(type, instruction.clone());
	} 

	/**
	 * Return a string representation of this 
	 * <code class="prettyprint">TestProcessorInstructionEvent</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">TestProcessorInstructionEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString(
						"TestProcessorInstruction", 
						"type", 
						"instruction"
					); 
	}
	
}
	
}
