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

package astre.processor.process 
{
	import astre.async.AsyncData;
	import astre.processor.process.ETestProcessPhase;
	import astre.core.Test;
	import flash.events.Event;

/**
 * A <code class="prettyprint">AsyncFunctionProcess</code> runs a 
 * method that is a result of an asynchronous checkout. This may be either 
 * the listener of an event or a fail function called if 
 * the event is not caught during the timeout. 
 * <code class="prettyprint">Test</code> to which this 
 * <code class="prettyprint">SetUpProcess</code> is part of.
 * 
 * <p>An <code class="prettyprint">AsyncFunctionProcess</code> 
 * may participate to the 
 * <code class="prettyprint">ETestProcessPhase.ASYNC_FAIL_FUNCTION</code> or 
 * the <code class="prettyprint">ETestProcessPhase.ASYNC_METHOD</code> 
 * phases.</p>
 * 
 * @author lunar
 * 
 */
public class AsyncFunctionProcess extends SyncMethodProcess
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The <code class="prettyprint">AsyncData</code> this 
	 * <code class="prettyprint">AsyncFunctionProcess</code> will 
	 * use to run.
	 */
	public var asyncData:AsyncData;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * 
	 * 
	 * @param test The test from which this 
	 * <code class="prettyprint">ITestProcess</code> is part of.
	 * @param testProcessPhase The phase in which this process participates.
	 * @param asyncData The <code class="prettyprint">AsyncData</code> this 
	 * <code class="prettyprint">AsyncFunctionProcess</code> will 
	 * use to run.
	 */
	public function AsyncFunctionProcess(
					test:Test, 
					testProcessPhase:ETestProcessPhase, 
					asyncData:AsyncData
				) 
	{
		super(test, testProcessPhase);
		this.asyncData = asyncData;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Runs the function of the 
	 * <code class="prettyprint">asyncData</code> property with the 
	 * specified arguments.
	 */
	override protected function runSyncProcess():void 
	{
		asyncData.run();
	}
	
}
	
}
