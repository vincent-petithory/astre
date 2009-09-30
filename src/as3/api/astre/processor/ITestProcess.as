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

package astre.processor 
{
	import astre.processor.IRunnable;
	import astre.core.AtomicResult;
	import astre.processor.process.ETestProcessPhase;
	import astre.core.Test;
	import flash.events.IEventDispatcher;

/**
 * The <code class="prettyprint">ITestProcess</code> interface 
 * defines objects that can processed by a 
 * <code class="prettyprint">ITestProcessor</code>.
 * 
 * @see ITestProcessor
 * 
 * @author lunar
 * 
 */
public interface ITestProcess extends IEventDispatcher, IRunnable
{
	
	/**
	 * The result of this process.
	 * 
	 * @see astre.core.AtomicResult
	 */
	function get testProcessResult():AtomicResult;
	
	/**
	 * @private
	 */
	function set testProcessResult(value:AtomicResult):void;
	
	/**
	 * The test from which this 
	 * <code class="prettyprint">ITestProcess</code> is part of.
	 */
	function get test():Test;
	
	/**
	 * The phase in which this process participates.
	 */
	function get testProcessPhase():ETestProcessPhase;
	
	/**
	 * A flag that indicates if this 
	 * <code class="prettyprint">ITestProcess</code> is being processed.
	 * 
	 * <p>Its value is <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">ITestProcess</code> is being processed. 
	 * Otherwise <code class="prettyprint">false</code>.
	 */
	function get isRunning():Boolean;
	
}
	
}
