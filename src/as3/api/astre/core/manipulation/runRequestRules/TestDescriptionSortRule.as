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

package astre.core.manipulation.runRequestRules 
{
	import astre.api.Test;
	import astre.core.TestDescription;
	import astre.core.manipulation.RunRequestSortRule;

/**
 * A <code class="prettyprint">TestDescriptionSortRule</code> sorts 
 * the <code class="prettyprint">Test</code> objects of a 
 * <code class="prettyprint">RunRequest</code> object according to 
 * the package, class name and method name of the 
 * <code class="prettyprint">Test</code> objects of the 
 * related <code class="prettyprint">RunRequest</code>.
 * 
 * @example The following code shows how to apply this rule to a 
 * <code class="prettyprint">RunRequest</code> : 
 * <pre class="prettyprint">
 * myRunRequest.sort(new TestDescriptionSortRule());
 * </pre>
 * 
 * @see astre.core.TestDescription
 * 
 * @author lunar
 * 
 */
public class TestDescriptionSortRule extends RunRequestSortRule
{
	
	/**
	 * @inheritDoc
	 */
	override public function compare(t1:Test, t2:Test):int 
	{
		var d1:TestDescription = t1.description;
		var d2:TestDescription = t2.description;
		
		if (d1.toString() == d2.toString())
		{
			return 0;
		}
		var ar:Array = new Array(2);
		ar[0] = d1;
		ar[1] = d2;
		ar.sortOn(["packageName", "className", "method"]);
		if (ar[0] == d1)
		{
			return -1;
		}
		else // ar[0] = d2
		{
			return 1;
		}
	}
	
}
	
}
