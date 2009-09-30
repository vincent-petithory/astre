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

package astre.core.processor 
{
	import astre.api.Test;
	import astre.core.processor.IRunnable;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

/**
 * The <code class="prettyprint">ITestProcessor</code> interface defines the 
 * behavior of objects that process tests. An 
 * <code class="prettyprint">ITestProcessor</code> object is linked to 
 * a test and deals with all the logic of the processes sequence.
 * An <code class="prettyprint">ITestProcessor</code> can receive and 
 * execute instructions. Those instructions are 
 * <code class="prettyprint">TestProcessorInstruction</code> objects.
 * 
 * @see TestProcessorInstruction
 * @see astre.core.Test
 * @see ITestProcess
 * 
 * @author lunar
 * 
 */
public interface ITestProcessor extends IEventDispatcher, IRunnable
{
	
	/**
	 * The <code class="prettyprint">Test</code> this 
	 * <code class="prettyprint">ITestProcessor</code> is 
	 * processing.
	 * 
	 * @see astre.core.Test
	 * 
	 */
	function get test():Test;
	
	/**
	 * The number of idle processes in this 
	 * <code class="prettyprint">ITestProcessor</code>.
	 * 
	 * <p>A process is considered idle if either it has been run or 
	 * it is waiting to be run.</p>
	 */
	function get idleProcesses():uint;
	
	/**
	 * The number of processes that have been, 
	 * are being, or will be 
	 * processed.
	 */
	function get numProcesses():uint;
	
	/**
	 * Checks if this 
	 * <code class="prettyprint">ITestProcessor</code> is still running 
	 * processes.
	 * 
	 * @return <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">ITestProcessor</code> is still running 
	 * processes.
	 */
	function hasRunningProcesses():Boolean;
	
	/**
	 * Tells this <code class="prettyprint">ITestProcessor</code> to execute 
	 * the specified instruction.
	 * @param instruction The instruction to be executed.
	 * 
	 * @see TestProcessorInstruction
	 * 
	 */
	function execute(instruction:TestProcessorInstruction):void;
	
}
	
}
