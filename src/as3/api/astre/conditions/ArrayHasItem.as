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
 * A condition that assumes a given array has -or not- a specified item.
 * 
 * @see Condition
 * 
 * @author lunar
 * 
 */
public class ArrayHasItem extends Condition 
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var array:Array;
	
	/**
	 * @private
	 */
	private var item:Object;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param array The array.
	 * @param item The item whose presence 
	 * in the array will be checked.
	 */
	public function ArrayHasItem(array:Array, item:Object) 
	{
		this.array = array;
		this.item = item;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	override protected function getUnexpectedConditionFalseMessage():String
	{
		return "Expected < "+item+" > was not found in < "+array+" >";
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function getUnexpectedConditionTrueMessage():String
	{
		return "Unexpected < "+item+" > was found in < "+array+" >";
	}
	
	/**
	 * @return <code class="prettyprint">true</code> if the 
	 * item is found in the array. 
	 * Otherwise <code class="prettyprint">false</code>.
	 * 
	 * @inheritDoc
	 */
	override protected function processCondition():Boolean 
	{
		for each (var obj:Object in array)
		{
			if (obj == item)
			{
				return true;
			}
		}
		return false;
	}
	
}
	
}
