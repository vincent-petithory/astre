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
	import astre.core.ICondition;

/**
 * A <code class="prettyprint">CombinedCondition</code> combines 
 * two <code class="prettyprint">ICondition</code> objects using a 
 * logical operator.
 * 
 * <p>Besides <code class="prettyprint">Condition</code> objects or 
 * custom <code class="prettyprint">Condition</code> objects, you may 
 * combine <code class="prettyprint">CombinedCondition</code> 
 * themselves to produce complex logical operations.</p>
 * 
 * @example The following code shows how to combine two custom 
 * subclass instances of the 
 * <code class="prettyprint">Condition</code> class.
 * 
 * <pre class="prettyprint">
 * 
 * package 
 * {
 * 
 * public class CombinedConditionExample extends Sprite
 * {
 * 
 * 	public function CombinedConditionExample()
 *  {
 * 		var a1:Array = new Array("Paris", "London", "Tokyo", "Roma");
 * 		var respectedCondition:ArrayHasItem = new ArrayHasItem(a1, "Tokyo");
 * 		var disregardedCondition:ArrayHasItem = new ArrayHasItem(a1, "Moscow");
 * 
 * 		// Output : true
 * 		trace(new CombinedCondition(
 * 							respectedCondition, 
 * 							LogicalOperator.OR, 
 * 							disregardedCondition
 * 						).isConditionRespected());
 * 
 * 		// Output : false
 * 		trace(new CombinedCondition(
 * 							respectedCondition, 
 * 							LogicalOperator.AND, 
 * 							disregardedCondition
 * 						).isConditionRespected());
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
 * @see Condition
 * @see LogicalOperator
 * 
 * @author lunar
 * 
 */
public class CombinedCondition extends Condition
{
	
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The first condition to combine.
	 */
	protected var c1:ICondition;
	
	/**
	 * The second condition to combine.
	 */
	protected var c2:ICondition;
	
	/**
	 * The logical operator to use for combining the 
	 * two conditions.
	 */
	protected var logicOperator:uint;
	
	/**
	 * @private
	 */
	private var c1Valid:Boolean;
	
	/**
	 * @private
	 */
	private var c2Valid:Boolean;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param c1 The first condition to combine.
	 * @param logicOperator The logical operator 
	 * to use for combining the two conditions.
	 * @param c2 The second condition to combine.
	 */
	public function CombinedCondition(
				c1:ICondition, 
				logicOperator:uint, 
				c2:ICondition 
			) 
	{
		this.c1 = c1;
		this.c2 = c2;
		this.logicOperator = logicOperator;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * <p>This implementation combines the results of the 
	 * two conditions and the logical operator passed 
	 * at construction time.</p>
	 * 
	 * @inheritDoc
	 */
	override protected function processCondition():Boolean 
	{
		c1Valid = c1.isConditionRespected();
		c2Valid = c2.isConditionRespected();
		switch (this.logicOperator)
		{
			case LogicalOperator.AND: 
				return c1Valid && c2Valid;
			case LogicalOperator.OR: 
				return c1Valid || c2Valid;
			default: 
				return true;
		}
		
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function getUnexpectedConditionTrueMessage():String 
	{
		var message:String = null;
		if (hasRunOnce && _lastResult)
		{
			switch (this.logicOperator)
			{
				case LogicalOperator.AND: 
					// true with AND implies two conditions are valid
					
					if (c1Valid && c2Valid)
					{
						message = c1.getUnexpectedResultMessage()+"\n"+
						c2.getUnexpectedResultMessage();
					}
					else
					{
						return null;
					}
					break;
				case LogicalOperator.OR: 
					if (c1Valid && c2Valid)
					{
						message = c1.getUnexpectedResultMessage()+"\n"+
						c2.getUnexpectedResultMessage();
					}
					else if (!c1Valid && c2Valid)
					{
						message = c2.getUnexpectedResultMessage();
					}
					else if (c1Valid && !c2Valid)
					{
						message = c1.getUnexpectedResultMessage();
					}
					else
					{
						message = null;
					}
					break;
				default: 
					return null;
			}
		}
		return message;
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		var message:String = null;
		if (hasRunOnce && !_lastResult)
		{
			switch (this.logicOperator)
			{
				case LogicalOperator.AND: 
					if (!c1Valid && !c2Valid)
					{
						message = c1.getUnexpectedResultMessage()+"\n"+
						c2.getUnexpectedResultMessage();
					}
					else if (!c1Valid && c2Valid)
					{
						message = c1.getUnexpectedResultMessage();
					}
					else if (c1Valid && !c2Valid)
					{
						message = c2.getUnexpectedResultMessage();
					}
					else
					{
						message = null;
					}
					break;
				case LogicalOperator.OR: 
					if (!c1Valid && !c2Valid)
					{
						message = c1.getUnexpectedResultMessage()+"\n"+
						c2.getUnexpectedResultMessage();
					}
					else
					{
						message = null;
					}
					break;
				default: 
					return null;
			}
		}
		return message;
	}
	
}
	
}
