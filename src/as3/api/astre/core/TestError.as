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

/**
 * The <code class="prettyprint">TestError</code> class is used 
 * internally to hold informations about the error that caused the 
 * related test to fail or generate an unexpected error.
 * 
 * @see AssertionError
 * @see AtomicResult
 * 
 * @author lunar
 * 
 */
public class TestError extends Error
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _causalError:Error;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param message A string associated with this 
	 * <code class="prettyprint">TestError</code>.
	 * @param causalError The error that caused this error.
	 */
	public function TestError(message:String, causalError:Error) 
	{
		super(message);
		this._causalError = causalError;
		this.name = "TestError";
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * An additionnal string this 
	 * <code class="prettyprint">TestError</code> 
	 * carry.
	 * 
	 * <p>If the error passed in the 
	 * <code class="prettyprint">TestError</code> constructor 
	 * is an <code class="prettyprint">AssertionError</code>, 
	 * its value is the one of the 
	 * <code class="prettyprint">testerMessage</code> property of that 
	 * <code class="prettyprint">AssertionError</code> instance.
	 * Otherwise, its value is <code class="prettyprint">null</code>.</p>
	 * 
	 * @return the value of the 
	 * <code class="prettyprint">testerMessage</code> property 
	 * if the error passed in the 
	 * <code class="prettyprint">TestError</code> constructor 
	 * is an <code class="prettyprint">AssertionError</code>.
	 * Otherwise, <code class="prettyprint">null</code>.
	 */
	public function getTesterMessage():String
	{
		if (_causalError is AssertionError)
		{
			return (_causalError as AssertionError).testerMessage;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * Returns the call stack of the error that caused this error, or
	 * <code class="prettyprint">null</code> if not using 
	 * the debugger version of Flash Player or ADL.
	 * 
	 * @return the call stack of the error that caused this error, or
	 * <code class="prettyprint">null</code> if not using 
	 * the debugger version of Flash Player or ADL.
	 */
	override public function getStackTrace():String 
	{
		return _causalError.getStackTrace();
	}
	
}
	
}
