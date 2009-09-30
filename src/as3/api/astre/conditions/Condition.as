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

package astre.conditions 
{

/**
 * A <code class="prettyprint">Condition</code> is the low-level 
 * implementation of the 
 * <code class="prettyprint">ICondition</code> interface.
 * 
 * <p>Override this class and its protected methods to create your 
 * custom condition.</p>
 * 
 * @example The following code shows an example of a subclass of the
 * <code class="prettyprint">Condition</code> class, 
 * and some basic manipulation : 
 * 
 * <pre class="prettyprint">
 * 
 * package 
 * {
 * 
 * public class ConditionExample extends Sprite
 * {
 * 
 * 	public function ConditionExample()
 *  {
 * 		var a1:Array = new Array("Paris", "London", "Tokyo", "Roma");
 * 		var respectedCondition:ArrayHasItem = new ArrayHasItem(a1, "Tokyo");
 * 		var disregardedCondition:ArrayHasItem = new ArrayHasItem(a1, "Moscow");
 * 
 * 		// Output : true
 * 		trace(respectedCondition.isConditionRespected());
 * 		// Output  : false
 * 		trace(disregardedCondition.isConditionRespected());
 * 
 *  }
 * 
 * }
 * 
 * 
 * import astre.conditions.Condition;
 * 
 * internal class ArrayHasItem extends Condition 
 * {
 * 	
 * 	private var array:Array;
 * 	private var item:Object;
 * 	
 * 	public function ArrayHasItem(array:Array, item:Object) 
 * 	{
 * 		this.array = array;
 * 		this.item = item;
 * 	}
 * 	
 * 	override protected function getUnexpectedConditionFalseMessage():String
 * 	{
 * 		return "Expected < "+item+" > was not found in < "+array+" >";
 * 	}
 * 	
 * 	override protected function getUnexpectedConditionTrueMessage():String
 * 	{
 * 		return "Unexpected < "+item+" > was found in < "+array+" >";
 * 	}
 * 	
 * 	override protected function processCondition():Boolean 
 * 	{
 * 		for each (var obj:Object in array)
 * 		{
 * 			if (obj == item)
 * 			{
 * 				return true;
 * 			}
 * 		}
 * 		return false;
 * 	}
 * 	
 * }
 * 	
 * }
 * 
 * </pre>
 * 
 * @see astre.core.Assertion#assertConditionDisregarded()
 * @see astre.core.Assertion#assertConditionRespected()
 * @see astre.core.ICondition
 * @see CombinedCondition
 * 
 * 
 * @author lunar
 * 
 */
public class Condition implements ICondition
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * Stores the last result of a call to 
	 * the <code class="prettyprint">isConditionRespected()</code> method.
	 */
	protected var _lastResult:Boolean;
	
	/**
	 * A flag to indicate whether the 
	 * <code class="prettyprint">isConditionRespected()</code> method 
	 * has been run at least one time.
	 */
	protected var hasRunOnce:Boolean = false;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function Condition() 
	{
		
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	public final function getUnexpectedResultMessage():String
	{
		if (hasRunOnce && !_lastResult)
		{
			return this.getUnexpectedConditionFalseMessage();
		}
		else if (hasRunOnce && _lastResult)
		{
			return this.getUnexpectedConditionTrueMessage();
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public final function isConditionRespected():Boolean
	{
		hasRunOnce = true;
		_lastResult = this.processCondition();
		return _lastResult;
	}
	
	/**
	 * The logical implementation of the condition.
	 * Override this method in your subclass to implement 
	 * your logical algorithm.
	 * @return <code class="prettyprint">true</code>
	 */
	protected function processCondition():Boolean
	{
		return true;
	}
	
	/**
	 * Returns the message that describes a condition that has not been 
	 * respected. When you write the message, remember that this result was 
	 * not the expected one.
	 * @return the message that describes a condition that has not been 
	 * respected.
	 */
	protected function getUnexpectedConditionFalseMessage():String
	{
		return null;
	}
	
	/**
	 * Returns the message that describes a condition that has been 
	 * respected. When you write the message, remember that this result was 
	 * not the expected one.
	 * @return the message that describes a condition that has been 
	 * respected.
	 */
	protected function getUnexpectedConditionTrueMessage():String
	{
		return null;
	}
	
}
	
}
