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

package astre.api 
{
	import astre.core.Reflection;
	import flash.utils.describeType;
	import flash.utils.Dictionary;

/**
 * The <code class="prettyprint">TraceUtil</code> class helps you logging 
 * complex variables while debugging.
 * 
 * @author lunar
 * 
 */
public class TraceUtil 
{
	
	/**
	 * The function that will be used to log the results. The specified 
	 * function must accept at least one parameter of any type. 
	 * Other parameters must be optional. By default, 
	 * the global function <code class="prettyprint">trace()</code> is 
	 * used.
	 * 
	 * @default trace
	 */
	public static var loggerFunction:Function = trace;
	
	/**
	 * Inspects the specified array, creates a formatted string 
	 * representation of it and uses the global 
	 * <code class="prettyprint">loggerFunction()</code> function to log it.
	 * 
	 * @param array The array to inspect.
	 * @param name The name of the variable of the specified array.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * var myArray:Array = new Array();
	 * 
	 * for (var i:uint = 0 ; i < 10 ; i++)
	 * {
	 *	myArray.push(Math.random()*20);
	 * }
	 * 
	 * TraceUtil.array(array, "myArray");
	 * 
	 * 
	 * // ouput :
	 * 
	 * Array myArray [
	 * "0"  =>  "17.47775091789663"
	 * "1"  =>  "4.82353400439024"
	 * "2"  =>  "12.105798600241542"
	 * "3"  =>  "15.911291809752584"
	 * "4"  =>  "4.3343050219118595"
	 * "5"  =>  "15.025365119799972"
	 * "6"  =>  "16.27092693001032"
	 * "7"  =>  "2.5752818770706654"
	 * "8"  =>  "11.293074702844024"
	 * "9"  =>  "0.9037005808204412"
	 * ]
	 * 
	 * 
	 * 
	 * </pre>
	 * 
	 */
	public static function array(array:Array, name:String = null):void
	{
		var toTrace:String = (name != null ? "Array "+
							  name : "Array")+" [\n";
		toTrace += iterateForIn(array);
		toTrace += "]";
		loggerFunction(toTrace);
	}
	
	/**
	 * Inspects the specified dictionary, creates a formatted string 
	 * representation of it and uses the global 
	 * <code class="prettyprint">loggerFunction()</code> function to log it.
	 * 
	 * @param dictionary The dictionary to inspect.
	 * @param name The name of the variable of the specified dictionary.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * var myDictionary:Dictionary = new Dictionary();
	 * 
	 * var keys:Array = new Array();
	 * var values:Array = new Array();
	 * 
	 * for (var i:uint = 0 ; i < 10 ; i++)
	 * {
	 * 	keys.push(new Error("error"+Math.floor(Math.random()*1000)));
	 * 	values.push(Math.random()*20);
	 * }
	 * 
	 * for (var j:uint = 0 ; j < 10 ; j++)
	 * {
	 * 	myDictionary[keys[j]] = values[j];
	 * }
	 * 
	 * TraceUtil.dictionary(dictionary, "myDictionary");
	 * 
	 * 
	 * // ouput :
	 * 
	 * Dictionary myDictionary [
	 * "Error: error538"  =>  "13.145839283242822"
	 * "Error: error415"  =>  "12.541567161679268"
	 * "Error: error699"  =>  "14.301345031708479"
	 * "Error: error60"  =>  "9.874300360679626"
	 * "Error: error423"  =>  "2.950147269293666"
	 * "Error: error770"  =>  "5.635726675391197"
	 * "Error: error304"  =>  "16.06898686848581"
	 * "Error: error456"  =>  "9.990359237417579"
	 * "Error: error330"  =>  "0.02605321817100048"
	 * "Error: error692"  =>  "2.55213163793087"
	 * ]
	 * 
	 * </pre>
	 * 
	 */
	public static function dictionary(
					dictionary:Dictionary, 
					name:String = null
				):void
	{
		var toTrace:String = (name != null ? "Dictionary "+
							  name : "Dictionary")+" [\n";
		toTrace += iterateForIn(dictionary);
		toTrace += "]";
		loggerFunction(toTrace);
	}
	
	/**
	 * Inspects the specified object, creates a formatted string 
	 * representation of it and uses the global 
	 * <code class="prettyprint">loggerFunction()</code> function to log it.
	 * 
	 * @param o The object to inspect.
	 * @param name The name of the variable of the specified object.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * var myObject:Object = new Object();
	 * 	
	 * var keys:Array = new Array();
	 * var values:Array = new Array();
	 * 
	 * for (var i:uint = 0 ; i < 10 ; i++)
	 * {
	 * 	keys.push("key"+Math.floor(Math.random()*1000));
	 * 	values.push(Math.random()*20);
	 * }
	 * 
	 * for (var j:uint = 0 ; j < 10 ; j++)
	 * {
	 * 	myObject[keys[j]] = values[j];
	 * }
	 * 
	 * TraceUtil.object(object, "myObject");
	 * 
	 * </pre>
	 * 
	 */
	public static function object(o:Object, name:String = null):void
	{
		var toTrace:String = (name != null ? "Object "+
							  name : "Object")+" {\n";
		toTrace += iterateForIn(o);
		toTrace += "}";
		loggerFunction(toTrace);
	}
	
	/**
	 * Inspects the specified object, 
	 * detects its public constants, accessors and variables, 
	 * creates a formatted string 
	 * representation of it and uses the global 
	 * <code class="prettyprint">loggerFunction()</code> function to log it.
	 * 
	 * <p>If you pass a <code class="prettyprint">Class</code> object, 
	 * the constants, accessors and variables of the class will be logged, 
	 * not those of an instance of that class.</p>
	 * 
	 * @param o The object to inspect.
	 * @param name The name of the variable of the specified object.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * 
	 * TraceUtil.objectPublicProperties(new Sprite());
	 * // output :
	 * Sprite instance {
	 * "buttonMode"  =>  "false"
	 * "graphics"  =>  "[object Graphics]"
	 * "dropTarget"  =>  "null"
	 * "hitArea"  =>  "null"
	 * "soundTransform"  =>  "[object SoundTransform]"
	 * "useHandCursor"  =>  "true"
	 * "numChildren"  =>  "0"
	 * "textSnapshot"  =>  "[object TextSnapshot]"
	 * "mouseChildren"  =>  "true"
	 * "tabChildren"  =>  "true"
	 * "tabIndex"  =>  "-1"
	 * "tabEnabled"  =>  "false"
	 * "doubleClickEnabled"  =>  "false"
	 * "contextMenu"  =>  "null"
	 * "accessibilityImplementation"  =>  "null"
	 * "mouseEnabled"  =>  "true"
	 * "focusRect"  =>  "null"
	 * "mouseX"  =>  "250"
	 * "transform"  =>  "[object Transform]"
	 * "alpha"  =>  "1"
	 * "filters"  =>  ""
	 * "parent"  =>  "null"
	 * "stage"  =>  "null"
	 * "mask"  =>  "null"
	 * "rotation"  =>  "0"
	 * "blendMode"  =>  "normal"
	 * "scaleX"  =>  "1"
	 * "scaleY"  =>  "1"
	 * "mouseY"  =>  "1"
	 * "y"  =>  "0"
	 * "x"  =>  "0"
	 * "accessibilityProperties"  =>  "null"
	 * "scale9Grid"  =>  "null"
	 * "scrollRect"  =>  "null"
	 * "root"  =>  "null"
	 * "width"  =>  "0"
	 * "loaderInfo"  =>  "null"
	 * "cacheAsBitmap"  =>  "false"
	 * "name"  =>  "instance1"
	 * "height"  =>  "0"
	 * "visible"  =>  "true"
	 * "opaqueBackground"  =>  "null"
	 * }
	 * 
	 * </pre>
	 * 
	 */
	public static function objectPublicProperties(
						o:Object, 
						name:String = null
					):void
	{
		var toTrace:String = "";
		if (o is Class)
		{
			var c:String = o.toString();
			toTrace = c.substring(1, c.length - 1)+" {\n";
		}
		else
		{
			var className:String = Reflection.getClassName(o);
			toTrace = (name != null ? 
					className+" "+name : 
					className+" instance")+" {\n";
		}
		
		
		var vars:XMLList = describeType(o).child("variable");
		var accessors:XMLList = describeType(o).child("accessor");
		var constants:XMLList = describeType(o).child("constant");
		
		toTrace += iterateForIn2(o, vars);
		toTrace += iterateForIn2(o, accessors);
		toTrace += iterateForIn2(o, constants);
		
		toTrace += "}";
		loggerFunction(toTrace);
	}
	
	/**
	 * Detects if the specified class implements the specified interface, 
	 * creates a string representation of the result and logs it.
	 * 
	 * @param c The class to check.
	 * @param whichInterface the interface the specified class 
	 * is checked for implementing.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * 
	 * 
	 * TraceUtil.classImplements(Sprite, IBitmapDrawable);
	 * // output : 
	 * // flash.display::Sprite implements flash.display::IBitmapDrawable ? true
	 * 
	 * 
	 * TraceUtil.classImplements(Sprite, IExternalizable);
	 * // output : 
	 * // flash.display::Sprite implements flash.utils::IExternalizable ? false
	 * 
	 * </pre>
	 * 
	 */
	public static function classImplements(c:Class, whichInterface:Class):void
	{
		var className:String = describeType(c).@name;
		var interfaceName:String = describeType(whichInterface).@name;
		
		loggerFunction(className+" implements "+interfaceName+" ? "+
				Reflection.isImplementorOf(c, whichInterface));
	}
	
	/**
	 * Detects if the specified class extends the specified super class, 
	 * creates a string representation of the result and logs it.
	 * 
	 * @param c The class to check.
	 * @param whichSuperClass the super class the specified 
	 * class is checked for subclassing.
	 * 
	 * @example This example shows an example of this method's output :
	 * <pre class="prettyprint">
	 * 
	 * TraceUtil.classExtends(Sprite, DisplayObject);
	 * // output :
	 * // flash.display::Sprite extends flash.display::DisplayObject ? true
	 * 
	 * 
	 * TraceUtil.classExtends(Sprite, Shape);
	 * // output :
	 * // flash.display::Sprite extends flash.display::Shape ? false
	 * 
	 * </pre>
	 * 
	 */
	public static function classExtends(c:Class, whichSuperClass:Class):void
	{
		var className:String = describeType(c).@name;
		var superClassName:String = describeType(whichSuperClass).@name;
		
		loggerFunction(className+" extends "+superClassName+" ? "+
				Reflection.isSubClassOf(c, whichSuperClass));
	}
	
	//------------------------------
	// Privates
	//------------------------------
	
	/**
	 * @private
	 */
	private static function iterateForIn(
						object:Object, 
						indentSpace:String = "  "
					):String
	{
		var str:String = "";
		for (var prop:Object in object)
		{
			var value:* = object[prop];
			if (object[prop] is String)
			{
				value = "\""+value+"\"";
			}
			str += indentSpace+"\""+prop+"\"  =>  "+value+"\n";
		}
		return str;
	}
	
	/**
	 * @private
	 */
	private static function iterateForIn2(
						object:Object, 
						propList:XMLList, 
						indentSpace:String = "  "
					):String
	{
		var str:String = "";
		var p:String
		for (var prop:String in propList)
		{
			p = propList[prop].@name;
			if (
				propList[prop].@access != "writeonly" && 
				propList[prop].@access != ""
			)
			{
				var value:* = object[p];
				if (object[p] is String)
				{
					value = "\""+value+"\"";
				}
				str += indentSpace+"\""+p+"\"  =>  "+value+"\n";
			}
			else
			{
				str += indentSpace+"\""+p+"\"  =>  \"(writeOnly)\"\n";
			}
		}
		return str;
	}
	
}
	
}
