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
	import astre.processor.process.ETestProcessPhase;
	import astre.core.Test;

/**
 * A <code class="prettyprint">SetUpProcess</code> runs the 
 * <code class="prettyprint">setUp()</code> method of the 
 * <code class="prettyprint">Test</code> to which this 
 * <code class="prettyprint">SetUpProcess</code> is part of.
 * 
 * <p>An <code class="prettyprint">SetUpProcess</code> participates to the 
 * <code class="prettyprint">ETestProcessPhase.SET_UP</code> 
 * phase.</p>
 * 
 * @author lunar
 * 
 */
public class SetUpProcess extends SyncMethodProcess
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
	 */
	public function SetUpProcess(test:Test) 
	{
		super(test, ETestProcessPhase.SET_UP);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Runs the <code class="prettyprint">setUp()</code> method 
	 * of the <code class="prettyprint">Test</code> this 
	 * <code class="prettyprint">SetUpProcess</code> is part of.
	 */
	override protected function runSyncProcess():void 
	{
		test.setUp();
	}
	
}
	
}
