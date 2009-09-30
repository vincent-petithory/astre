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

package astre.core.manipulation 
{
	import astre.core.AtomicResult;

/**
 * A <code class="prettyprint">ResultSortRule</code> is the base class 
 * of the rules you may use to sort the 
 * <code class="prettyprint">AtomicResult</code> objects of a 
 * <code class="prettyprint">Result</code> object.
 * 
 * @see astre.core.AtomicResult
 * 
 * @author lunar
 * 
 */
public class ResultSortRule 
{
	
	/**
	 * The function that determines the order of two tests.
	 * 
	 * <p>You must override this method in your subclass to 
	 * perform the required sort.</p>
	 * 
	 * @param r1 The first atomic result.
	 * @param r2 The second atomic result.
	 * @return An integer whose value is :
	 * <ul>
	 * <li>-1 if <code class="prettyprint">r1</code> should be before 
	 * <code class="prettyprint">r2</code> in the sorted sequence.</li>
	 * <li>0 if <code class="prettyprint">r1</code> equals 
	 * <code class="prettyprint">r2</code>.</li>
	 * <li>1 if <code class="prettyprint">r2</code> should be before 
	 * <code class="prettyprint">r1</code> in the sorted sequence.</li>
	 * </li>
	 */
	public function compare(r1:AtomicResult, r2:AtomicResult):int
	{
		return 0;
	}
	
}
	
}
