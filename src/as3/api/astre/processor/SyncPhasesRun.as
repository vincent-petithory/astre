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

/**
 * A <code class="prettyprint">SyncPhasesRun</code> memorizes the 
 * main synchronous phases of a <code class="prettyprint">Test</code> 
 * that have been already run.
 * 
 * @see TestProcessor
 * 
 * @author lunar
 * 
 */
public class SyncPhasesRun 
{
	
	/**
	 * A flag to indicate the 
	 * <code class="prettyprint">setUp()</code> method has been processed.
	 * 
	 * @default false
	 */
	public var setUp:Boolean = false;
	
	/**
	 * A flag to indicate the main test method has been processed.
	 * 
	 * @default false
	 */
	public var mainMethod:Boolean = false;
	
	/**
	 * A flag to indicate the 
	 * <code class="prettyprint">tearDown()</code> method has been processed.
	 * 
	 * @default false
	 */
	public var tearDown:Boolean = false;
	
	/**
	 * Returns an integer showing the progress of the 
	 * methods that have been processed.
	 * 
	 * <p>Possible values are :
	 * <ul>
	 * <li><code class="prettyprint">0</code> if no 
	 * methods have been processed yet.</li>
	 * <li><code class="prettyprint">1</code> if only the 
	 * <code class="prettyprint">setUp()</code> method 
	 * have been processed.</li>
	 * <li><code class="prettyprint">2</code> if only the 
	 * <code class="prettyprint">setUp()</code> and the main test method 
	 * methods have been processed.</li>
	 * <li><code class="prettyprint">3</code> if the 
	 * <code class="prettyprint">setUp()</code>, 
	 * <code class="prettyprint">tearDown()</code> and the main test method 
	 * methods have been processed.</li>
	 * </ul>
	 * </p>
	 * 
	 * @return an integer showing the progress of the 
	 * methods that have been processed.
	 */
	public function getProgressLevel():uint
	{
		if (!setUp)
		{
			return 0;
		}
		else if (setUp && !mainMethod)
		{
			return 1;
		}
		else if (setUp && mainMethod && !tearDown)
		{
			return 2;
		}
		else if (setUp && mainMethod && tearDown)
		{
			return 3;
		}
		else
		{
			return 4;
		}
	}
	
}
	
}
