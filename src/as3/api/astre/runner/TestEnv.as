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

package astre.runner 
{

/**
 * A <code class="prettyprint">TestEnv</code> is an object you 
 * pass to a <code class="prettyprint">ITestRunner</code> for 
 * sharing resources among all its tests to be run.
 * 
 * Typically, you may pass objects that represents data from a 
 * remote resource, so that it is accessible locally.
 * This prevents asynchronous calls that slows the test execution.
 * 
 * @author lunar
 * 
 */
public dynamic class TestEnv extends Object 
{
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns an array of string representing the resources 
	 * available in this <code class="prettyprint">TestEnv</code>.
	 * @return an array of string representing the resources 
	 * available in this <code class="prettyprint">TestEnv</code>.
	 */
	public function getResources():Array
	{
		var a:Array = new Array();
		for (var p:String in  this)
		{
			a.push(p);
		}
		return a;
	}
	
	/**
	 * Returns <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">TestEnv</code> has a 
	 * resource whose name matches the 
	 * parameter <code class="prettyprint">name</code>.
	 * @param name the name of the property whose presence is to 
	 * be checked.
	 * @return <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">TestEnv</code> has a 
	 * resource whose name matches the 
	 * parameter <code class="prettyprint">name</code>.
	 */
	public function hasResource(name:String):Boolean
	{
		return this.hasOwnProperty(name);
	}
	
	/**
	 * Adds a resource to this <code class="prettyprint">TestEnv</code>.
	 * @param name the name of the resource to add.
	 * @param value the value of the resource to add
	 * @return <code class="prettyprint">true</code> if this 
	 * <code class="prettyprint">TestEnv</code> had not yet a resource 
	 * with that name.
	 */
	public function setResource(name:String, value:Object):Boolean
	{
		var hasAlready:Boolean = hasResource(name);
		this[name] = value;
		return !hasAlready;
	}
	
}
	
}
