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

package astre.core 
{

import astre.api.Test;

/**
 * The <code class="prettyprint">TestDescription</code> class holds 
 * information about a test that has been run or not.
 * 
 * @see Test
 * 
 * @author lunar
 * 
 */
public class TestDescription 
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 */
	private var _className:String;
	
	/**
	 * The class name of the test this 
	 * <code class="prettyprint">TestDescription</code> describes.
	 */
	public function get className():String
	{
		return _className;
	}
	
	/**
	 * @private
	 */
	private var _packageName:String;
	
	/**
	 * The package name of the test this 
	 * <code class="prettyprint">TestDescription</code> describes.
	 */
	public function get packageName():String
	{
		return _packageName;
	}
	
	/**
	 * @private
	 */
	private var _method:String;
	
	/**
	 * The method name of the test that has been, or will be executed.
	 */
	public function get method():String
	{
		return _method;
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function TestDescription(test:Test) 
	{
		super();
		this._method = test.Astre::runMethodName;
		this._packageName = Reflection.getPackage(test);
		this._className = Reflection.getClassName(test);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a full string representation of this 
	 * <code class="prettyprint">TestDescription</code>.
	 * @return a full string representation of this 
	 * <code class="prettyprint">TestDescription</code>.
	 */
	public function getDisplay():String
	{
		return displayTest(packageName,className,method);
	}
	
	public static var displayTest:Function = function (packageName:String, className:String, method:String):String
	{
		return packageName+"."+className+"."+method+"()";
	};
	
	/**
	 * Returns a string representation of this 
	 * <code class="prettyprint">TestDescription</code>.
	 * 
	 * <p>Actually, it returns the same string as the 
	 * <code class="prettyprint">getDisplay()</code> does.</p>
	 * 
	 * @return a string representation of this 
	 * <code class="prettyprint">TestDescription</code>.
	 */
	public function toString():String
	{
		return getDisplay();
	}
	
}
	
}
