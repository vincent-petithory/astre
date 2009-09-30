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
	
import flash.events.Event;

/**
 * The <code class="prettyprint">AsyncCheckoutEvent</code> is used for 
 * unidirectionnal communication from an 
 * <code class="prettyprint">IAsyncCheckout</code> object to 
 * its <code class="prettyprint">AsyncProcess</code> owner.
 * 
 * @see astre.processor.process.AsyncProcess
 * @see IAsyncCheckout
 * @see AsyncData
 * 
 * @author lunar
 * 
 */
public class AsyncCheckoutEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The 
	 * <code class="prettyprint">AsyncCheckoutEvent.ASYNC_NOT_EXECUTED</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">asyncNotExecuted</code> event.
	 * 
	 * <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th>
	 * 			<th>Value</th></tr>
	 *     <tr><td><code class="prettyprint">bubbles</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">cancelable</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">currentTarget</code></td>
	 * 			<td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code class="prettyprint">myButton.addEventListener()</code> 
	 * 			to register an event listener, 
	 *       myButton is the value of the 
	 * 		<code class="prettyprint">currentTarget</code>. </td></tr>
	 *     <tr><td><code class="prettyprint">target</code></td>
	 * 		<td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code class="prettyprint">currentTarget</code> 
	 * 		property to always access the 
	 *       Object listening for the event.</td></tr>
	 * 		<tr><td><code class="prettyprint">asyncData</code></td>
	 * 			<td>The data passed by the 
	 * 			<code class="prettyprint">IAsyncCheckout</code> object :<br/>
	 * 			<ul>
	 * 				<li>The <code class="prettyprint">func</code>, 
	 * 			<code class="prettyprint">event</code> and 
	 * 			<code class="prettyprint">data</code> properties are 
	 * 			<code class="prettyprint">null</code>.</li>
	 * 				<li>The 
	 * 				<code class="prettyprint">asyncCheckoutOwner</code> 
	 * 				references the 
	 * 				<code class="prettyprint">IAsyncCheckout</code> object 
	 * 				that owns this <code class="prettyprint">AsyncData</code>, 
	 * 				generally the same reference as the 
	 * 				<code class="prettyprint">AsyncCheckoutEvent.target</code> 
	 * 				property.</li>
	 * 			</ul>
	 * 			</td></tr>
	 *  </table>
	 */
	public static const ASYNC_NOT_EXECUTED:String = "asyncNotExecuted";
	
	/**
	 * The 
	 * <code class="prettyprint">AsyncCheckoutEvent.EXPECTED_ASYNC_NOT_EXECUTED</code> 
	 * constant defines the value of the type property of the event 
	 * object for a 
	 * <code class="prettyprint">expectedAsyncNotExecuted</code> event.
	 * 
	 * <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th>
	 * 			<th>Value</th></tr>
	 *     <tr><td><code class="prettyprint">bubbles</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">cancelable</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">currentTarget</code></td>
	 * 			<td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code class="prettyprint">myButton.addEventListener()</code> 
	 * 			to register an event listener, 
	 *       myButton is the value of the 
	 * 		<code class="prettyprint">currentTarget</code>. </td></tr>
	 *     <tr><td><code class="prettyprint">target</code></td>
	 * 		<td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code class="prettyprint">currentTarget</code> 
	 * 		property to always access the 
	 *       Object listening for the event.</td></tr>
	 * 		<tr><td><code class="prettyprint">asyncData</code></td>
	 * 			<td>The data passed by the 
	 * 			<code class="prettyprint">IAsyncCheckout</code> object :<br/>
	 * 			<ul>
	 * 				<li>The <code class="prettyprint">func</code> contains 
	 * 				the reference to the 
	 * 				<code class="prettyprint">failFunction</code> passed to 
	 * 				the <code class="prettyprint">IAsyncCheckout</code>.</li>
	 * 				<li>The <code class="prettyprint">event</code> property 
	 * 				is <code class="prettyprint">null</code>.</li>
	 * 				<li>The <code class="prettyprint">data</code> property 
	 * 				references the data to pass to the 
	 * 				<code class="prettyprint">failFunction</code>.</li>
	 * 				<li>The 
	 * 				<code class="prettyprint">asyncCheckoutOwner</code> 
	 * 				references the 
	 * 				<code class="prettyprint">IAsyncCheckout</code> object 
	 * 				that owns this <code class="prettyprint">AsyncData</code>, 
	 * 				generally the same reference as the 
	 * 				<code class="prettyprint">AsyncCheckoutEvent.target</code> 
	 * 				property.</li>
	 * 			</ul>
	 * 			</td></tr>
	 *  </table>
	 */
	public static const EXPECTED_ASYNC_NOT_EXECUTED:String = 
								"expectedAsyncNotExecuted";
	
	/**
	 * The 
	 * <code class="prettyprint">AsyncCheckoutEvent.ASYNC_EXECUTED</code> 
	 * constant defines the value of the type property of the event 
	 * object for a <code class="prettyprint">asyncExecuted</code> event.
	 * 
	 * <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th>
	 * 			<th>Value</th></tr>
	 *     <tr><td><code class="prettyprint">bubbles</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">cancelable</code></td>
	 * 			<td>false</td></tr>
	 *     <tr><td><code class="prettyprint">currentTarget</code></td>
	 * 			<td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code class="prettyprint">myButton.addEventListener()</code> 
	 * 			to register an event listener, 
	 *       myButton is the value of the 
	 * 		<code class="prettyprint">currentTarget</code>. </td></tr>
	 *     <tr><td><code class="prettyprint">target</code></td>
	 * 		<td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code class="prettyprint">currentTarget</code> 
	 * 		property to always access the 
	 *       Object listening for the event.</td></tr>
	 * 		<tr><td><code class="prettyprint">asyncData</code></td>
	 * 			<td>The data passed by the 
	 * 			<code class="prettyprint">IAsyncCheckout</code> object :<br/>
	 * 			<ul>
	 * 				<li>The <code class="prettyprint">func</code> contains 
	 * 				the reference to the 
	 * 				<code class="prettyprint">asyncFunction</code> passed to 
	 * 				the <code class="prettyprint">IAsyncCheckout</code>.</li>
	 * 				<li>The <code class="prettyprint">event</code> property 
	 * 				references the event the 
	 * 				<code class="prettyprint">IAsyncCheckout</code> 
	 * 				expected.</li>
	 * 				<li>The <code class="prettyprint">data</code> property 
	 * 				references the data to pass to the 
	 * 				<code class="prettyprint">asyncFunction</code>.</li>
	 * 				<li>The 
	 * 				<code class="prettyprint">asyncCheckoutOwner</code> 
	 * 				references the 
	 * 				<code class="prettyprint">IAsyncCheckout</code> object 
	 * 				that owns this <code class="prettyprint">AsyncData</code>, 
	 * 				generally the same reference as the 
	 * 				<code class="prettyprint">AsyncCheckoutEvent.target</code> 
	 * 				property.</li>
	 * 			</ul>
	 * 			</td></tr>
	 *  </table>
	 */
	public static const ASYNC_EXECUTED:String = "asyncExecuted";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The data to pass to the receiver, generally an 
	 * <code class="prettyprint">AsyncProcess</code>.
	 * 
	 * @default null
	 */
	public var asyncData:AsyncData;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param type The type of this 
	 * <code class="prettyprint">AsyncCheckoutEvent</code>.
	 * @param asyncData The data to pass to the receiver, generally an 
	 * <code class="prettyprint">AsyncProcess</code>.
	 */
	public function AsyncCheckoutEvent(
			type:String, 
			asyncData:AsyncData = null
		)
	{ 
		super(type, false, false);
		this.asyncData = asyncData;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a clone of this 
	 * <code class="prettyprint">AsyncCheckoutEvent</code>.
	 * 
	 * @return a clone of this 
	 * <code class="prettyprint">AsyncCheckoutEvent</code>.
	 */
	public override function clone():Event 
	{ 
		return new AsyncCheckoutEvent(type, asyncData);
	} 

	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">AsyncCheckoutEvent</code>.
	 * 
	 * @return a string representation of this 
	 * <code class="prettyprint">AsyncCheckoutEvent</code>.
	 */
	public override function toString():String 
	{ 
		return formatToString("AsyncCheckoutEvent", "type", "asyncData");
	}

}
	
}