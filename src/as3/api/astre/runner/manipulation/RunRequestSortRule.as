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

package astre.runner.manipulation 
{
	import astre.core.Test;

/**
 * A <code class="prettyprint">RunRequestSortRule</code> is the base class 
 * of the rules you may use to sort the tests of a 
 * <code class="prettyprint">RunRequest</code> object.
 * 
 * @see astre.runner.RunRequest#sort()
 * @see astre.core.Test
 * 
 * @author lunar
 * 
 */
public class RunRequestSortRule 
{
	
	/**
	 * The function that determines the order of two tests.
	 * 
	 * <p>You must override this method in your subclass to 
	 * perform the required sort.</p>
	 * 
	 * @param t1 The first test.
	 * @param t2 The second test.
	 * @return An integer whose value is :
	 * <ul>
	 * <li>-1 if <code class="prettyprint">t1</code> should be before 
	 * <code class="prettyprint">t2</code> in the sorted sequence.</li>
	 * <li>0 if <code class="prettyprint">t1</code> equals 
	 * <code class="prettyprint">t2</code>.</li>
	 * <li>1 if <code class="prettyprint">t2</code> should be before 
	 * <code class="prettyprint">t1</code> in the sorted sequence.</li>
	 * </li>
	 */
	public function compare(t1:Test, t2:Test):int
	{
		return 0;
	}
	
}
	
}
