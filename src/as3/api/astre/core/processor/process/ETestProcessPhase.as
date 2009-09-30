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

package astre.core.processor.process 
{

/**
 * The <code class="prettyprint">ETestProcessPhase</code> enumeration 
 * lists the possible phases an 
 * <code class="prettyprint">ITestProcess</code> may realize.
 * 
 * @see ITestProcess
 * 
 * @author lunar
 * 
 */
public class ETestProcessPhase 
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
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents the <code class="prettyprint">setUp()</code> method 
	 * processing phase.
	 */
	public static const SET_UP:ETestProcessPhase = new ETestProcessPhase("setUp");
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents the main test method processing phase.
	 */
	public static const MAIN_METHOD:ETestProcessPhase = new ETestProcessPhase("mainMethod");
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents a processing phase where the 
	 * <code class="prettyprint">ITestProcess</code> specifies a time out 
	 * the fulfilling 
	 * <code class="prettyprint">ITestProcessor</code> should wait for.
	 */
	public static const ASYNC_TIMEOUT:ETestProcessPhase = new ETestProcessPhase("asyncTimeout");
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents the processing phase of an asynchronous method triggered 
	 * by an event.
	 */
	public static const ASYNC_METHOD:ETestProcessPhase = new ETestProcessPhase("asyncMethod");
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents a processing phase of an asynchronous method triggered 
	 * by a misdispatched event.
	 */
	public static const ASYNC_FAIL_FUNCTION:ETestProcessPhase = new ETestProcessPhase("asyncFailFunction");
	
	/**
	 * The <code class="prettyprint">ETestProcessPhase</code> that 
	 * represents the <code class="prettyprint">tearDown()</code> method 
	 * processing phase.
	 */
	public static const TEAR_DOWN:ETestProcessPhase = new ETestProcessPhase("tearDown");
	
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
	public function ETestProcessPhase(name:String)
	{
		this._name = name;
		this._ordinal = _enums.push(this)-1;
	}
	
}
	
}
