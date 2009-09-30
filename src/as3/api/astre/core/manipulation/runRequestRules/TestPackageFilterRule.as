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
	import astre.core.manipulation.RunRequestFilterRule;
	import astre.api.Test;

/**
 * A <code class="prettyprint">TestPackageFilterRule</code> filters 
 * the <code class="prettyprint">Test</code> whose package matches with 
 * the <code class="prettyprint">TestPackageFilterRule.packageName</code> 
 * property.
 * 
 * @example The following code allows only the 
 * <code class="prettyprint">Test</code> objects which are in the package 
 * (or a subpackage) <code class="prettyprint">path.to.my.package</code> :
 * 
 * <pre class="prettyprint">
 * var request:RunRequest = RunRequest.testClass(
 * 											MyGlobalTestAggregatorClass
 * 											);
 * request = request.filter(
 * 					new TestPackageFilterRule("path.to.my.package")
 * 				);
 * </pre>
 * 
 * @author lunar
 * 
 */
public class TestPackageFilterRule extends RunRequestFilterRule
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The package allowed by this 
	 * <code class="prettyprint">TestPackageFilterRule</code>.
	 */
	public var packageName:String;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * @param packageName The package allowed by this 
	 * <code class="prettyprint">TestPackageFilterRule</code>.
	 */
	public function TestPackageFilterRule(packageName:String) 
	{
		super();
		this.packageName = packageName;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	override public function accept(item:Test, index:int, array:Array):Boolean 
	{
		return item.description.packageName.indexOf(packageName) 
				!= -1;
	}
	
}
	
}
