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

/**
 * A <code class="prettyprint">TestProcessorInstruction</code> is an 
 * object that can be executed by a 
 * <code class="prettyprint">ITestProcessor</code>.
 * 
 * @see TestProcessorInstructionType
 * @see ITestProcessor
 * 
 * @author lunar
 * 
 */
public class TestProcessorInstruction 
{

	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The type of this instruction.
	 * Possible values are enumerated in the 
	 * <code class="prettyprint">TestProcessorInstructionType</code> 
	 * class.
	 */
	public var type:String;
	
	/**
	 * Additional data that will be carried with 
	 * this <code class="prettyprint">TestProcessorInstruction</code>.
	 */
	public var data:Object;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param type The type of this instruction.
	 * Possible values are enumerated in the 
	 * <code class="prettyprint">TestProcessorInstructionType</code> 
	 * class.
	 * @param data Additional data that will be carried with 
	 * this <code class="prettyprint">TestProcessorInstruction</code>.
	 */
	public function TestProcessorInstruction(type:String, data:Object = null) 
	{ 
		this.type = type;
		this.data = data;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this <code class="prettyprint">TestProcessorInstruction</code>
	 * @return a clone of this <code class="prettyprint">TestProcessorInstruction</code>
	 */
	public function clone():TestProcessorInstruction 
	{ 
		return new TestProcessorInstruction(type, data);
	} 

}
	
}
