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
	import flash.events.IEventDispatcher;

/**
 * The <code class="prettyprint">IAsyncCheckout</code> interface 
 * defines objects that can make asynchronous checkouts.
 * 
 * @author lunar
 * 
 */
public interface IAsyncCheckout extends IEventDispatcher
{
	
	/**
	 * Defines the checkout parameters for this 
	 * <code class="prettyprint">IAsyncCheckout</code>.
	 * 
	 * @param timeout The time to wait for the asynchronous 
	 * object to be called.
	 * @param dispatcher The target of the event this 
	 * <code class="prettyprint">IAsyncCheckout</code> waits for.
	 * @param type The type of the event this 
	 * <code class="prettyprint">IAsyncCheckout</code> waits for.
	 * @param asyncFunction The function that will be called if the 
	 * the target receives the event before the timeout ends.
	 * The function you pass must at least define one parameter whose type 
	 * is <code class="prettyprint">flash.events.Event</code> 
	 * (or a subclass of it).
	 * If you pass extra data to this function using the 
	 * <code class="prettyprint">data</code> parameter, then your function 
	 * must have a second parameter whose type matches with the one of 
	 * the <code class="prettyprint">data</code>.
	 * @param data Optional data to pass to the 
	 * <code class="prettyprint">asyncFunction</code>.
	 * @param failFunction An optional function that will be called if 
	 * no event of the expected type is dispatched to the 
	 * <code class="prettyprint">dispatcher</code>.
	 * The function you pass may have no argument.
	 * If you pass extra data to this function using the 
	 * <code class="prettyprint">failData</code> parameter, then your 
	 * function must have one parameter whose type matches with the 
	 * one of the <code class="prettyprint">failData</code>.
	 * @param failData Optional data to pass to the 
	 * <code class="prettyprint">failFunction</code>.
	 * @param useCapture Whether the event is listened on the 
	 * capture phase or not.
	 * @param priority The priority of the event listener registration.
	 */
	function checkout(	
					timeout:uint, 
					dispatcher:IEventDispatcher, 
					type:String, 
					asyncFunction:Function, 
					data:Object = null, 
					failFunction:Function = null, 
					failData:Object = null, 
					useCapture:Boolean = false, 
					priority:int = 0
				):void;
	
	/**
	 * Starts the timeout of this 
	 * <code class="prettyprint">IAsyncCheckout</code>.
	 */
	function startCheckout():void;
	
	/**
	 * Cancels the timeout of this 
	 * <code class="prettyprint">IAsyncCheckout</code>.
	 */
	function cancelCheckout():void;
	
	/**
	 * Whether this 
	 * <code class="prettyprint">IAsyncCheckout</code> 
	 * is running or not.
	 */
	function get isRunning():Boolean;
	
	/**
	 * The time in milliseconds this 
	 * <code class="prettyprint">IAsyncCheckout</code> has to wait.
	 */
	function get timeout():int;
	
	/**
	 * The type of the event this 
	 * <code class="prettyprint">IAsyncCheckout</code> expects.
	 */
	function get eventType():String;
	
	/**
	 * The id of this <code class="prettyprint">IAsyncCheckout</code>.
	 */
	function get id():uint;
	//function removeAsyncEventListener():void;

}
	
}
