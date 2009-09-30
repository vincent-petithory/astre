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
 * The <code class="prettyprint">ICondition</code> interface provides the 
 * behavior of conditional objects.
 * 
 * <p>You typically use objects implementing this interface (like 
 * <code class="prettyprint">astre.conditions.CombinedCondition</code>, 
 * <code class="prettyprint">astre.conditions.Condition</code>, or 
 * a subclass of them) with the 
 * <code class="prettyprint">Assertion#assertConditionDisregarded()</code>
 * and <code class="prettyprint">Assertion#assertConditionRespected()</code> 
 * methods.
 * </p>
 * 
 * <p>A conditional object can have two issues : <br/>
 * <ul>
 * <li>The condition is respected.</li>
 * <li>The condition is disregarded.</li>
 * </ul>
 * </p>
 * 
 * @see Assertion#assertConditionDisregarded()
 * @see Assertion#assertConditionRespected()
 * @see astre.conditions
 * @see astre.conditions.CombinedCondition
 * @see astre.conditions.Condition
 * 
 * @author lunar
 * 
 */
public interface ICondition 
{
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a string describing an unexpected result of this 
	 * <code class="prettyprint">ICondition</code>.
	 * 
	 * <p>Note that this unexpected result can be one of those 
	 * two possibilities: <br/>
	 * <ul>
	 * <li>The condition is respected and that is not 
	 * what was expected.</li>
	 * <li>The condition is disregarded and that is not 
	 * what was expected.</li>
	 * </ul>
	 * </p>
	 * @return  a string describing an unexpected result of this 
	 * <code class="prettyprint">ICondition</code>.
	 */
	function getUnexpectedResultMessage():String;
	
	/**
	 * Returns <code class="prettyprint">true</code> if the 
	 * condition is respected. 
	 * Otherwise<code class="prettyprint">false</code>.
	 * @return <code class="prettyprint">true</code> if the 
	 * condition is respected. 
	 * Otherwise<code class="prettyprint">false</code>.
	 */
	function isConditionRespected():Boolean;
	
}
	
}
