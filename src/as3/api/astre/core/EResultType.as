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
 * An enumeration of the possible results for a test.
 * The level of the <code class="prettyprint">EResultType</code> is given 
 * by its <code class="prettyprint">ordinal</code> property : 
 * the higher the value, the higher the &quot;threat&quot; of 
 * the <code class="prettyprint">EResultType</code>.
 * 
 * <p>The result types follow the following ordered list, from lower to 
 * higher values :</p>
 * <ol>
 * <li>EResultType.PASSED</li>
 * <li>EResultType.FAILURE</li>
 * <li>EResultType.UNEXPECTED_ERROR</li>
 * <li>EResultType.IGNORED</li>
 * </ol>
 * 
 * @author lunar
 * 
 */
public class EResultType 
{
	
	/**
	 * An array containing the enum constants defined.
	 */
	public static function get enums():Array
	{
		return _enums;
	}
	
	/**
	 * @private
	 */
	private static var _enums:Array = [];
	
	// Keep order
	
	/**
	 * Defines the result for a test that is successful.
	 */
	public static const PASSED:EResultType = new EResultType("passed");
	
	/**
	 * Defines the result for a test that is a failure.
	 */
	public static const FAILURE:EResultType = new EResultType("failure");
	
	/**
	 * Defines the result for a test that has 
	 * generated an unexpected error.
	 */
	public static const UNEXPECTED_ERROR:EResultType = new EResultType("unexpectedError");
	
	/**
	 * Defines the result for a test that has been ignored.
	 */
	public static const IGNORED:EResultType = new EResultType("ignored");
	
	/**
	 * @private
	 */
	private var _name:String;
	
	/**
	 * The name of the result type
	 */
	public function get name():String
	{
		return _name;
	}
	
	/**
	 * @private
	 */
	private var _ordinal:uint;
	
	/**
	 * The level of the result type
	 */
	public function get ordinal():uint
	{
		return _ordinal;
	}
	
	/**
	 * Constructor
	 * @param name the name of the result type
	 */
	public function EResultType(name:String)
	{
		this._name = name;
		this._ordinal = _enums.push(this)-1;
	}
	
	public function compareTo(result:EResultType):int
	{
		return this.ordinal - result.ordinal;
	}
	
	public function toString():String
	{
		return _name;
	}
	
}
	
}
