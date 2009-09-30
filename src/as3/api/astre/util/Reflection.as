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

package astre.util 
{
	
import flash.utils.*;

/**
 * The <code class="prettyprint">Reflection</code> class provides 
 * static methods to do basic code reflection.
 * 
 * @author lunar
 * 
 */
public class Reflection 
{
	
	/**
	 * Returns an array of all the public instance methods 
	 * of the specified class.
	 * 
	 * @param clazz The class to introspect
	 * @return an array of all the public instance methods 
	 * of the specified class.
	 */
	public static function getMethods(clazz:Class):Array /* of strings */
	{
		var a:Array = new Array();
		var list:XMLList = 
			describeType(clazz).factory.child("method").attribute("name");
		for each (var method:String in list)
		{
			a.push(method);
		}
		return a;
	}
	
	/**
	 * Returns the class name of the specified object.
	 * 
	 * <p>The parameter may be a class or an instance of a class.</p>
	 * 
	 * @param obj The class object or instance object.
	 * @return the class name of the specified object.
	 */
	public static function getClassName(obj:Object):String
	{
		return Reflection.parseSimpleName(describeType(obj).@name);
	}
	
	/**
	 * Returns the package of the specified object.
	 * 
	 * <p>The parameter may be a class or an instance of a class.</p>
	 * 
	 * @param obj The class object or instance object.
	 * @return the package of the specified object.
	 */
	public static function getPackage(obj:Object):String
	{
		return Reflection.parsePackage(describeType(obj).@name);
	}
	
	/**
	 * Checks if the specified class implements the 
	 * specified interface.
	 * 
	 * @param thisClass The class to check.
	 * @param whichInterface The interface 
	 * <code class="prettyprint">thisClass</code> is checked for implementing.
	 * @return <code class="prettyprint">true</code> if the specified 
	 * class implements the specified interface. Otherwise 
	 * <code class="prettyprint">false</code>.
	 */
	public static function isImplementorOf(
						thisClass:Class, 
						whichInterface:Class
					):Boolean
	{
		var interfaces:XMLList = describeType(thisClass).factory.child(
								"implementsInterface"
							).attribute("type");
		for each (var thisInterface:String in interfaces)
		{
			if (getDefinitionByName(thisInterface) == whichInterface)
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Checks if the specified class extends the 
	 * specified super class.
	 * 
	 * @param thisClass The class to check.
	 * @param whichSuperClass The class 
	 * <code class="prettyprint">thisClass</code> is checked for subclassing.
	 * @return <code class="prettyprint">true</code> if the specified 
	 * class is a subclass of 
	 * <code class="prettyprint">whichSuperClass</code>. Otherwise 
	 * <code class="prettyprint">false</code>.
	 */
	public static function isSubClassOf(
						thisClass:Class, 
						whichSuperClass:Class
					):Boolean
	{
		var superClasses:XMLList = describeType(thisClass).factory.child(
										"extendsClass"
									).attribute("type");
		for each (var thisSuperclass:String in superClasses)
		{
			if (getDefinitionByName(thisSuperclass) == whichSuperClass)
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * @private
	 */
	private static function parsePackage(qualifiedClassName:String):String
	{
		var patternIndex:int = qualifiedClassName.indexOf("::");
		if (patternIndex == -1)
		{
			return "";
		}
		return qualifiedClassName.substring(0, patternIndex);
	}
	
	/**
	 * @private
	 */
	private static function parseSimpleName(qualifiedClassName:String):String
	{
		var patternIndex:int = qualifiedClassName.lastIndexOf("::");
		if (patternIndex == -1) // Top-level class
		{
			patternIndex = 0;
		}
		else
		{
			patternIndex += 2;
		}
		return qualifiedClassName.substring(patternIndex);
	}
	
}
	
}
