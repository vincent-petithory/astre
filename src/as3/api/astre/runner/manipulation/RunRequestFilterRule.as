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
 * A <code class="prettyprint">RunRequestFilterRule</code> is the base class 
 * of the rules you may use to filter the 
 * <code class="prettyprint">Test</code> objects of a 
 * <code class="prettyprint">RunRequest</code> object.
 * 
 * @see astre.runner.RunRequest#filter()
 * @see astre.core.Test
 * 
 * @author lunar
 * 
 */
public class RunRequestFilterRule 
{
	
	/**
	 * The function that determines if a 
	 * <code class="prettyprint">Test</code> is accepted in the final 
	 * <code class="prettyprint">RunRequest</code>.
	 * 
	 * <p>You must override this method in your subclass to 
	 * perform the required filter operation.</p>
	 * 
	 * @param item The test to be checked for inclusion.
	 * @param index The index of the test in the array from which it is from.
	 * @param array The array from which the test is from.
	 * @return <code class="prettyprint">true</code> if the 
	 * <code class="prettyprint">Test</code> is accepted.
	 * <code class="prettyprint">false</code> is the 
	 * <code class="prettyprint">Test</code> is rejected.
	 */
	public function accept(item:Test, index:int, array:Array):Boolean
	{
		return true;
	}
	
}
	
}
