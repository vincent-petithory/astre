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

package astre.runner.manipulation.resultRules 
{
	import astre.core.TestDescription;
	import astre.core.AtomicResult;
	import astre.runner.manipulation.ResultSortRule;

/**
 * A <code class="prettyprint">TestDescriptionSortRule</code> sorts 
 * the <code class="prettyprint">AtomicResult</code> of a 
 * <code class="prettyprint">Result</code> object according to 
 * the package, class name and method name of the 
 * <code class="prettyprint">Test</code> the 
 * <code class="prettyprint">AtomicResult</code> is linked to.
 * 
 * @example The following code shows how to apply this rule to a 
 * <code class="prettyprint">Result</code> : 
 * <pre class="prettyprint">
 * myResult.sort(new TestDescriptionSortRule());
 * </pre>
 * 
 * @see astre.core.TestDescription
 * 
 * @author lunar
 * 
 */
public class TestDescriptionSortRule extends ResultSortRule
{
	
	/**
	 * @inheritDoc
	 */
	override public function compare(r1:AtomicResult, r2:AtomicResult):int 
	{
		var d1:TestDescription = r1.testDescription;
		var d2:TestDescription = r2.testDescription;
		
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
