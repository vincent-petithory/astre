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
	import astre.core.processor.IRunnable;
	import flash.events.Event;

/**
 * An <code class="prettyprint">AsyncData</code> object holds data about 
 * the result of an <code class="prettyprint">IAsyncCheckout</code> object.
 * 
 * <p>It is the object carried by the event object which is responsible to 
 * notify the <code class="prettyprint">AsyncProcess</code> which owns the 
 * related <code class="prettyprint">IAsyncCheckout</code>.</p>
 * 
 * @see IAsyncCheckout
 * @see astre.processor.process.AsyncProcess
 * 
 * @author lunar
 * 
 */
public class AsyncData implements IRunnable
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The function to be executed
	 * 
	 * @default null
	 */
	public var func:Function;
	
	/**
	 * The event which will possibly be passed to 
	 * the function.
	 * 
	 * @default null
	 */
	public var event:Event;
	
	/**
	 * The data which will possibly be passed to 
	 * the function.
	 * 
	 * @default null
	 */
	public var data:Object;
	
	/**
	 * The owner of this <code class="prettyprint">AsyncData</code>.
	 * 
	 * @default null
	 */
	public var asyncCheckoutOwner:IAsyncCheckout;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor. Parameters will be passed to the matching 
	 * properties.
	 * 
	 * @param func The function to be executed
	 * @param event The event which will possibly be passed to 
	 * the function.
	 * @param data The data which will possibly be passed to 
	 * the function.
	 * @param asyncCheckoutOwner The owner of this 
	 * <code class="prettyprint">AsyncData</code>.
	 */
	public function AsyncData(
							func:Function = null, 
							event:Event = null, 
							data:Object = null, 
							asyncCheckoutOwner:IAsyncCheckout = null
						) 
	{
		this.func = func;
		this.event = event;
		this.data = data;
		this.asyncCheckoutOwner = asyncCheckoutOwner;
	}
	
	/**
	 * Runs this <code class="prettyprint">AsyncData</code>.
	 */
	public function run():void
	{
		if (this.data != null && this.event != null)
		{
			func(this.event, this.data);
		}
		else if (this.event != null && this.data == null)
		{
			func(this.event);
		}
		else if (this.event == null && this.data != null)
		{
			func(this.data);
		}
		else 
		{
			func();
		}
	}
	
}
	
}
