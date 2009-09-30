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

/**
 * The <code class="prettyprint">AssertionError</code> class defines errors 
 * that will be thrown by the static methods of the 
 * <code class="prettyprint">Assertion</code> class.
 * In addition to standard error classes, it provides an additionnal string 
 * used by the <code class="prettyprint">Assertion</code> class as a specific 
 * message of the tester.
 * 
 * @see Assertion
 * @see TestError
 * 
 * @author lunar
 * 
 */
public class AssertionError extends Error
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * An additionnal string this 
	 * <code class="prettyprint">AssertionError</code> will 
	 * carry.
	 * 
	 * @default null
	 */
	public var testerMessage:String;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param message A string associated with this 
	 * <code class="prettyprint">AssertionError</code>.
	 * @param testerMessage An additionnal string this 
	 * <code class="prettyprint">AssertionError</code> will 
	 * carry.
	 */
	public function AssertionError(
				message:String, 
				testerMessage:String = ""
			) 
	{
		super(message);
		this.testerMessage = testerMessage;
		this.name = "AssertionError";
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">AssertionError</code>.
	 * @return a string representation of this 
	 * <code class="prettyprint">AssertionError</code>.
	 */
	public function toString():String
	{
		if (testerMessage == "")
		{
			return message;
		}
		else
		{
			return message+"\n"+testerMessage;
		}
		
	}
	
}
	
}
