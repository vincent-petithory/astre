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

package astre.async 
{

/**
 * An <code class="prettyprint">AsyncHandler</code> is a FIFO collection 
 * which stores <code class="prettyprint">IAsyncCheckout</code> objects of a 
 * <code class="prettyprint">Test</code> to make them available for a 
 * <code class="prettyprint">ITestProcessor</code>.
 * 
 * @see astre.core.Test
 * @see IAsyncCheckout
 * @see astre.processor.ITestProcessor
 * 
 * @author lunar
 * 
 */
public class AsyncHandler 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private static var asyncCheckoutIdFilter:Function = function(item:*, index:int, array:Array):Boolean
	{
		return (item as IAsyncCheckout).id == this.id;
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _asyncCheckouts:Array; /* of IAsyncCheckout */
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function AsyncHandler() 
	{
		super();
		_asyncCheckouts = new Array();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns the unique <code class="prettyprint">IAsyncCheckout</code> 
	 * whose id matches with the specified id.
	 * 
	 * @param id the id of the searched 
	 * <code class="prettyprint">IAsyncCheckout</code>.
	 * 
	 * @return The unique <code class="prettyprint">IAsyncCheckout</code> 
	 * whose id matches with the specified id, or 
	 * <code class="prettyprint">null</code> if there is no 
	 * <code class="prettyprint">IAsyncCheckout</code> with the specified id.
	 */
	public function getAsyncCheckoutById(id:uint):IAsyncCheckout
	{
		var r:Array = _asyncCheckouts.filter(asyncCheckoutIdFilter, {id: id});
		if (r.length == 1)
		{
			return r[0];
		}
		return null;
	}
	
	/**
	 * Removes the first 
	 * <code class="prettyprint">IAsyncCheckout</code> stored in 
	 * this <code class="prettyprint">AsyncHandler</code> and returns it.
	 * 
	 * @return the first 
	 * <code class="prettyprint">IAsyncCheckout</code> stored in 
	 * this <code class="prettyprint">AsyncHandler</code>.
	 */
	public function getNextAsync():IAsyncCheckout
	{
		return _asyncCheckouts.shift();
	}
	
	/**
	 * Adds an <code class="prettyprint">IAsyncCheckout</code> to 
	 * the end of the queue.
	 * @param checkout the <code class="prettyprint">IAsyncCheckout</code> 
	 * to be added.
	 */
	public function addCheckout(checkout:IAsyncCheckout):void
	{
		_asyncCheckouts.push(checkout);
	}
	
	/**
	 * Returns <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">IAsyncCheckout</code> objects are remaining.
	 * Otherwise, <code class="prettyprint">false</code>.
	 * 
	 * @return <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">IAsyncCheckout</code> objects are remaining.
	 * Otherwise, <code class="prettyprint">false</code>.
	 */
	public function hasAsync():Boolean
	{
		return _asyncCheckouts.length > 0;
	}
	
	/**
	 * Returns a unique id (in the scope of this 
	 * <code class="prettyprint">AsyncHandler</code>).
	 * 
	 * <p>You may use this method when creating an 
	 * <code class="prettyprint">IAsyncCheckout</code> that you 
	 * want to store to this <code class="prettyprint">AsyncHandler</code>.</p>
	 * 
	 * @example This example shows how to add a valid 
	 * <code class="prettyprint">IAsyncCheckout</code> in 
	 * an <code class="prettyprint">AsyncHandler</code>.<br/>
	 * This example assumes <code class="prettyprint">asyncHandler</code> 
	 * already stores <code class="prettyprint">IAsyncHandler</code> objects.
	 * 
	 * 
	 * <pre class="prettyprint">
	 * 
	 * var checkout:IAsyncCheckout = new AsyncCheckout(
	 * 										asyncHandler.getUniqueId()
	 *										);
	 * 
	 * asyncHandler.addCheckout(checkout);
	 * 
	 * </pre>
	 * 
	 * @return a unique id (in the scope of this 
	 * <code class="prettyprint">AsyncHandler</code>).
	 */
	public function getUniqueId():uint
	{
		var id:uint;
		do {
			id = Math.floor(uint.MAX_VALUE*Math.random());
		} while (_asyncCheckouts.some(asyncCheckoutIdFilter, {id: id}))
		
		return id;
	}
	
}
	
}
