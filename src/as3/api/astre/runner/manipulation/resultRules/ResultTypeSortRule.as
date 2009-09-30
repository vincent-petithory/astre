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
	import astre.core.AtomicResult;
	import astre.runner.manipulation.ResultSortRule;

/**
 * A <code class="prettyprint">ResultTypeSortRule</code> sorts 
 * the <code class="prettyprint">AtomicResult</code> objects of a 
 * <code class="prettyprint">Result</code> object according to 
 * the level of the <code class="prettyprint">EResultType</code> of the 
 * <code class="prettyprint">AtomicResult</code> objects of the 
 * related <code class="prettyprint">Result</code>.
 * 
 * @example The following code shows how to apply this rule to a 
 * <code class="prettyprint">RunRequest</code> : 
 * <pre class="prettyprint">
 * myRunRequest.sort(new TestDescriptionSortRule());
 * </pre>
 * 
 * @see astre.core.EResultType
 * 
 * @author lunar
 * 
 */
public class ResultTypeSortRule extends ResultSortRule
{
	
	/**
	 * @inheritDoc
	 */
	override public function compare(r1:AtomicResult, r2:AtomicResult):int 
	{
		return r1.type.compareTo(r2.type);
	}
	
}
	
}
