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
	import astre.core.AssertionError;
	import astre.core.EResultType;
	import astre.processor.process.ETestProcessPhase;
	import astre.core.AtomicResult;
	import astre.core.Test;
	import astre.core.TestError;

/**
 * The <code class="prettyprint">SyncMethodProcess</code> is 
 * designed to run a synchronous method and record exceptions.
 * 
 * <p><code class="prettyprint">AssertionError</code> and 
 * <code class="prettyprint">Error</code> are separated to 
 * differentiate unexpected errors from failures.</p>
 * 
 * @author lunar
 * 
 */
public class SyncMethodProcess extends TestProcess
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param test The test from which this 
	 * <code class="prettyprint">ITestProcess</code> is part of.
	 * @param testProcessPhase The phase in which this process participates.
	 */
	public function SyncMethodProcess(
						test:Test, 
						testProcessPhase:ETestProcessPhase
					) 
	{
		super(test, testProcessPhase);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	override public function run():void 
	{
		super.run();
		try
		{
			runSyncProcess();
		} catch (ae:AssertionError)
		{
			this.testProcessResult.type = EResultType.FAILURE;
			this.testProcessResult.error = new TestError(ae.message, ae);
		} catch (e:Error)
		{
			this.testProcessResult.type = EResultType.UNEXPECTED_ERROR;
			this.testProcessResult.error = new TestError(e.message, e);
		}
		finally
		{
			runEnd();
		}
	}
	
	/**
	 * The logical implementation of the process. 
	 * This method has to be overriden in 
	 * <code class="prettyprint">SyncMethodProcess</code> subclass.
	 */
	protected function runSyncProcess():void {}
	
}
	
}
