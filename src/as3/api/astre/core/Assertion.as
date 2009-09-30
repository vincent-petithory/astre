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
	

/**
 * The <code class="prettyprint">Assertion</code> class provides 
 * several methods that you must use when writing your tests.
 * 
 * <p>When an assertion fails inside a test, Astre automatically registers 
 * the current test as a failure. Others errors are also registered. In that 
 * case, the test is registered as having generated an unexpected error.</p>
 * 
 * <p>You typically use the methods of this class in a subclass of 
 * <code class="prettyprint">astre.core.Test</code>. Each method possibly 
 * throws an <code class="prettyprint">astre.core.AssertionError</code> 
 * with an appropriate message when it fails.</p>
 * 
 * <p>For conveniance, the <code class="prettyprint">Test</code> 
 * class extends the <code class="prettyprint">Assertion</code> class.
 * This way, for example, you may directly call 
 * <code class="prettyprint">assertTrue()</code> instead of 
 * <code class="prettyprint">Assertion.assertTrue()</code>.</p>
 * 
 * <p>Although the number of the <code class="prettyprint">Assertion</code> 
 * class methods is limited, you can easily extend its functionalities 
 * by using the 
 * <code class="prettyprint">Assertion.assertConditionRespected()</code> and 
 * <code class="prettyprint">Assertion.assertConditionDisregarded()</code> 
 * methods.</p>
 * 
 * @see ICondition
 * @see astre.conditions
 * @see Test
 * @see AssertionError
 * @see TestError
 * 
 * @author lunar
 * 
 */
public class Assertion 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * Asserts that the <code class="prettyprint">actualValue</code> number 
	 * approaches the <code class="prettyprint">expectedValue</code> number 
	 * by <code class="prettyprint">tolerance</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">|expectedValue - actualValue| <= tolerance
	 * </code></p>
	 * 
	 * @param actualValue the value to test.
	 * @param expectedValue the target value that 
	 * <code class="prettyprint">actualValue</code> may approach.
	 * @param tolerance the maximum difference allowed between the 
	 * expected and actual values.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var n1:Number = 2;
	 * var n2:Number = 3;
	 * var d1:Number = 1.5;
	 * var d2:Number = 0.5;
	 * 
	 * // Does not throw an error
	 * assertApproximate(n1, n2, d1);
	 * 
	 * // Throws an error
	 * assertApproximate(n1, n2, d2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 * 
	 */
	public static function assertApproximate(
					actualValue:Number, 
					expectedValue:Number, 
					tolerance:Number, 
					testerMessage:String = ""
				):void
	{
		if (Math.abs(actualValue - expectedValue) > tolerance)
		{
			Assertion.fail("< "+actualValue+" > unexpectedly did not "+
			"approach < "+expectedValue+" > by < "+tolerance+" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actualValue</code> number 
	 * does not approach the <code class="prettyprint">unexpectedValue</code> 
	 * number by <code class="prettyprint">tolerance</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">|unexpectedValue - actualValue| > tolerance
	 * </code></p>
	 * 
	 * @param actualValue the value to test.
	 * @param unexpectedValue the target value that 
	 * <code class="prettyprint">actualValue</code> may not approach.
	 * @param tolerance the minimum difference allowed between the 
	 * unexpected and actual values.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var n1:Number = 2;
	 * var n2:Number = 3;
	 * var d1:Number = 1.5;
	 * var d2:Number = 0.5;
	 * 
	 * // Throws an error
	 * assertNotApproximate(n1, n2, d1);
	 * 
	 * // Does not throw an error
	 * assertNotApproximate(n1, n2, d2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotApproximate(
					actualValue:Number, 
					unexpectedValue:Number, 
					tolerance:Number, 
					testerMessage:String = ""
				):void
	{
		if (Math.abs(actualValue - unexpectedValue) <= tolerance)
		{
			Assertion.fail("< "+actualValue+" > unexpectedly approached < "+
			unexpectedValue+" > by < "+tolerance+" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">value</code> object 
	 * owns the <code class="prettyprint">expectedProperty</code> property 
	 * as a property or a method.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param value the object to test.
	 * @param expectedProperty the property the 
	 * <code class="prettyprint">value</code> object is assumed to own.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Does not throw an error
	 * assertOwnsProperty(new Sprite(), "x");
	 * 
	 * // Throws an error
	 * assertOwnsProperty(new Bitmap(), "graphics");
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertOwnsProperty(
					value:Object, 
					expectedProperty:String, 
					testerMessage:String = ""
				):void
	{
		if (!value.hasOwnProperty(expectedProperty))
		{
			Assertion.fail("Expected < "+value+" > to have the < "+
			expectedProperty+" > property but has not", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">value</code> object 
	 * does not own the <code class="prettyprint">expectedProperty</code> 
	 * property as a property or a method.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param value the object to test.
	 * @param expectedProperty the property the 
	 * <code class="prettyprint">value</code> object is assumed not to own.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Throws an error
	 * assertNotOwnsProperty(new Sprite(), "x");
	 * 
	 * // Does not throw an error
	 * assertNotOwnsProperty(new Bitmap(), "graphics");
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotOwnsProperty(
					value:Object, 
					unexpectedProperty:String, 
					testerMessage:String = ""
				):void
	{
		if (value.hasOwnProperty(unexpectedProperty))
		{
			Assertion.fail("< "+value+" > had the unexpected < "+
			unexpectedProperty+" > property", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> and 
	 * <code class="prettyprint">expected</code> arrays are 
	 * &quot;equals&quot;. If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>Two arrays will be declared &quot;equals&quot; if and only if :
	 * <ul>
	 * <li>They have the same length</li>
	 * <li>All of the elements of the first array and the 
	 * elements of the other at their respective indexes return 
	 * <code class="prettyprint">true</code> when compared with the 
	 * <code class="prettyprint">==</code> operator.</li>
	 * </ul></p>
	 * 
	 * @param expected The expected array.
	 * @param actual The array to be compared with the 
	 * <code class="prettyprint">expected</code> array.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var a1:Array = new Array(5, 7);
	 * var a2:Array = new Array("5", 7);
	 * var a3:Array = new Array(8, 5);
	 * var a4:Array = new Array(5, 7, 8);
	 * 
	 * // Throws an error
	 * assertArrayEquals(a1, a3);
	 * // Throws an error
	 * assertArrayEquals(a1, a4);
	 * 
	 * // Does not thrown an error
	 * assertArrayEquals(a1, a2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertArrayEquals(
					expected:Array, 
					actual:Array, 
					testerMessage:String = ""
				):void
	{
		var expectedLength:uint = expected.length;
		var actualLength:uint = actual.length;
		
		if (expectedLength != actualLength)
		{
			Assertion.fail("Expected Array has "+expectedLength+
			" elements but actual has "+actualLength+
			" elements", testerMessage);
		}
		else
		{
			for (var i:uint = 0 ; i < expectedLength ; i++)
			{
				if (expected[i] != actual[i])
				{
					Assertion.fail("Expected value < "+
					expected[i]+" > but found < "+actual[i]+" > at index "+i);
				}
			}
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> and 
	 * <code class="prettyprint">unexpected</code> arrays are not 
	 * &quot;equals&quot;. If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>Two arrays will be declared not &quot;equals&quot; if either :
	 * <ul>
	 * <li>They do not have the same length</li>
	 * <li>or at least one of the element of the first array and the 
	 * element at the same index in the other array returns 
	 * <code class="prettyprint">false</code> when they are compared with the 
	 * <code class="prettyprint">==</code> operator.</li>
	 * </ul></p>
	 * 
	 * @param unexpected The expected array.
	 * @param actual The array to be compared with the 
	 * <code class="prettyprint"un>expected</code> array.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var a1:Array = new Array(5, 7);
	 * var a2:Array = new Array("5", 7);
	 * var a3:Array = new Array(8, 5);
	 * var a4:Array = new Array(5, 7, 8);
	 * 
	 * // Does not thrown an error
	 * assertArrayNotEquals(a1, a3);
	 * // Does not thrown an error
	 * assertArrayNotEquals(a1, a4);
	 * 
	 * // Throws an error
	 * assertArrayNotEquals(a1, a2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertArrayNotEquals(
					unexpected:Array, 
					actual:Array, 
					testerMessage:String = ""
				):void
	{
		var unexpectedLength:uint = unexpected.length;
		var actualLength:uint = actual.length;
		
		if (unexpectedLength == actualLength)
		{
			for (var i:uint = 0 ; i < unexpectedLength ; i++)
			{
				if (unexpected[i] == actual[i])
				{
					Assertion.fail("< "+actual[i]+
					" > was the unexpected value < "+
					unexpected[i]+" > at index "+i);
				}
			}
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> and 
	 * <code class="prettyprint">expected</code> arrays are 
	 * &quot;strictly equals&quot;. If the assertion is not true, 
	 * it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>Two arrays will be declared &quot;strictly equals&quot; 
	 * if and only if :
	 * <ul>
	 * <li>They have the same length</li>
	 * <li>All of the elements of the first array and the 
	 * elements of the other at their respective indexes return 
	 * <code class="prettyprint">true</code> when compared with the 
	 * <code class="prettyprint">===</code> operator.</li>
	 * </ul></p>
	 * 
	 * @param expected The expected array.
	 * @param actual The array to be compared with the 
	 * <code class="prettyprint">expected</code> array.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var a1:Array = new Array(5, 7);
	 * var a2:Array = new Array(5, 7);
	 * var a3:Array = new Array("5", "7");
	 * var a4:Array = new Array(5, 7, 8);
	 * 
	 * // Throws an error
	 * assertArrayStrictlyEquals(a1, a3);
	 * 
	 * // Does not throw an error
	 * assertArrayStrictlyEquals(a1, a2);
	 * 
	 * // Throws an error
	 * assertArrayStrictlyEquals(a1, a4);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertArrayStrictlyEquals(
					expected:Array, 
					actual:Array, 
					testerMessage:String = ""
				):void
	{
		var expectedLength:uint = expected.length;
		var actualLength:uint = actual.length;
		
		if (expectedLength != actualLength)
		{
			Assertion.fail("Expected Array has "+expectedLength+
			" elements but actual has "+actualLength+
			" elements", testerMessage);
		}
		else
		{
			for (var i:uint = 0 ; i < expectedLength ; i++)
			{
				if (expected[i] !== actual[i])
				{
					Assertion.fail("Expected value < "+expected[i]+
					" > but found < "+actual[i]+" > at index "+i);
				}
			}
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> and 
	 * <code class="prettyprint">unexpected</code> arrays are not 
	 * &quot;strictly equals&quot;. If the assertion is not true, it 
	 * will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>Two arrays will be declared not &quot;strictly equals&quot; 
	 * if either :
	 * <ul>
	 * <li>They do not have the same length</li>
	 * <li>or at least one of the element of the first array and the 
	 * element at the same index in the other array returns 
	 * <code class="prettyprint">false</code> when they are compared with the 
	 * <code class="prettyprint">===</code> operator.</li>
	 * </ul></p>
	 * 
	 * @param unexpected The expected array.
	 * @param actual The array to be compared with the 
	 * <code class="prettyprint"un>expected</code> array.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var a1:Array = new Array(5, 7);
	 * var a2:Array = new Array(5, 7);
	 * var a3:Array = new Array("5", "7");
	 * var a4:Array = new Array(5, 7, 8);
	 * 
	 * // Throws an error
	 * assertArrayNotStrictlyEquals(a1, a2);
	 * 
	 * // Does not throw an error
	 assertArrayNotStrictlyEquals(a1, a3);
	 * 
	 * // Does not throw an error
	 * assertArrayStrictlyEquals(a1, a4);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertArrayNotStrictlyEquals(
					unexpected:Array, 
					actual:Array, 
					testerMessage:String = ""
				):void
	{
		var unexpectedLength:uint = unexpected.length;
		var actualLength:uint = actual.length;
		
		if (unexpectedLength == actualLength)
		{
			for (var i:uint = 0 ; i < unexpectedLength ; i++)
			{
				if (unexpected[i] === actual[i])
				{
					Assertion.fail("< "+actual[i]+
					" > was strictly the unexpected value < "+
					unexpected[i]+" > at index "+i);
				}
			}
		}
	}
	
	/**
	 * Asserts that the specified condition is 
	 * <code class="prettyprint">true</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param condition a <code class="prettyprint">Boolean</code>
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Throws an error
	 * assertTrue(1 == 0);
	 * 
	 * // Does not throw an error
	 * assertTrue(1 < 2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertTrue(
					condition:Boolean, 
					testerMessage:String = ""
				):void
	{
		if (!condition)
		{
			Assertion.fail("Expected true but was false", testerMessage);
		}
	}
	
	/**
	 * Asserts that the specified condition is 
	 * <code class="prettyprint">false</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param condition a <code class="prettyprint">Boolean</code>
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Throws an error
	 * assertFalse(1 != 0);
	 * 
	 * // Does not throw an error
	 * assertFalse(1 > 2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertFalse(
					condition:Boolean, 
					testerMessage:String = ""
				):void
	{
		if (condition)
		{
			Assertion.fail("Expected false but was true", testerMessage);
		}
	}
	
	/**
	 * Asserts the specified <code class="prettyprint">object</code> is 
	 * not <code class="prettyprint">null</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param object the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var sprite:Sprite;
	 * 
	 * // Throws an error
	 * assertNotNull(sprite);
	 * 
	 * sprite = new Sprite();
	 * 
	 * // Does not throw an error
	 * assertNotNull(sprite);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotNull(
					object:Object, 
					testerMessage:String = ""
				):void
	{
		if (object == null)
		{
			Assertion.fail("Expected not null but was null", testerMessage);
		}
	}
	
	/**
	 * Asserts the specified <code class="prettyprint">object</code> is 
	 * <code class="prettyprint">null</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param object the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var sprite:Sprite = new Sprite();
	 * 
	 * // Throws an error
	 * assertNull(sprite);
	 * 
	 * sprite = null;
	 * 
	 * // Does not throw an error
	 * assertNull(sprite);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNull(
					object:Object, 
					testerMessage:String = ""
				):void
	{
		if (object != null)
		{
			Assertion.fail("Expected null but was : "+object, testerMessage);
		}
	}
	
	/**
	 * Asserts the specified <code class="prettyprint">object</code> is 
	 * not <code class="prettyprint">undefined</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param object the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var u1:* = undefined;
	 * var u2:String = "notUndefined";
	 * 
	 * // Throws an error
	 * assertNotUndefined(u1);
	 * // Does not throw an error
	 * assertNotUndefined(u2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotUndefined(
					object:*, 
					testerMessage:String = ""
				):void
	{
		if (object == undefined)
		{
			Assertion.fail(
						"Expected not undefined but was undefined", 
						testerMessage
					);
		}
	}
	
	/**
	 * Asserts the specified <code class="prettyprint">object</code> is 
	 * <code class="prettyprint">undefined</code>.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param object the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var u1:* = undefined;
	 * var u2:String = "notUndefined";
	 * 
	 * // Does not throw an error
	 * assertUndefined(u1);
	 * // Throws an error
	 * assertUndefined(u2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertUndefined(
					object:*, 
					testerMessage:String = ""
				):void
	{
		if (object != undefined)
		{
			Assertion.fail("Expected undefined but was : "+
			object, testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> Object 
	 * does not equals the <code class="prettyprint">unexpected</code> 
	 * Object. The comparison uses the <code class="prettyprint">==</code> 
	 * operator.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">actual != unexpected</code> 
	 * returns <code class="prettyprint">true</code>.</p>
	 * 
	 * @param unexpected the object that 
	 * <code class="prettyprint">actual</code> should not be equal to.
	 * @param actual the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var n1:Number = 0;
	 * var n2:Number = 1;
	 * var n3:Number = 0;
	 * 
	 * // Throws an error
	 * assertNotEquals(n1, n3);
	 * 
	 * // Does not throw an error
	 * assertNotEquals(n1, n2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotEquals(
					unexpected:Object, 
					actual:Object, 
					testerMessage:String = ""
				):void
	{
		if (unexpected == actual)
		{
			Assertion.fail("< "+actual+
			" > was the unexpected value < "+unexpected+
			" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> Object 
	 * equals the <code class="prettyprint">expected</code> 
	 * Object. The comparison uses the <code class="prettyprint">==</code> 
	 * operator.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">actual != expected</code> 
	 * returns <code class="prettyprint">false</code>.</p>
	 * 
	 * @param expected the object that 
	 * <code class="prettyprint">actual</code> should be equal to.
	 * @param actual the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var n1:Number = 0;
	 * var n2:Number = 1;
	 * var n3:Number = 0;
	 * 
	 * // Does not throw an error
	 * assertEquals(n1, n3);
	 * 
	 * // Throws an error
	 * assertEquals(n1, n2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertEquals(
					expected:Object, 
					actual:Object, 
					testerMessage:String = ""
				):void
	{
		if (expected != actual)
		{
			Assertion.fail("Expected < "+expected+
			" > but was < "+actual+" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> Object 
	 * does not strictly equals the 
	 * <code class="prettyprint">unexpected</code> 
	 * Object. The comparison uses the <code class="prettyprint">===</code> 
	 * operator.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">actual !== unexpected</code> 
	 * returns <code class="prettyprint">true</code>.</p>
	 * 
	 * @param unexpected the object that 
	 * <code class="prettyprint">actual</code> should not be 
	 * strictly equal to.
	 * @param actual the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var s1:String = "0";
	 * var n2:Number = 0;
	 * var s3:String = "0";
	 * 
	 * // Throws an error
	 * assertNotStrictlyEquals(s1, s3);
	 * 
	 * // Does not throw an error
	 * assertNotStrictlyEquals(s1, n2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotStrictlyEquals(
					unexpected:Object, 
					actual:Object, 
					testerMessage:String = ""
				):void
	{
		if (unexpected === actual)
		{
			Assertion.fail("< "+actual+
			" > was strictly the unexpected value < "+
			unexpected+" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">actual</code> Object 
	 * strictly equals the <code class="prettyprint">expected</code> 
	 * Object. The comparison uses the <code class="prettyprint">===</code> 
	 * operator.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>In other words, the assertion is 
	 * <code class="prettyprint">true</code> if 
	 * <code class="prettyprint">actual !== expected</code> 
	 * returns <code class="prettyprint">false</code>.</p>
	 * 
	 * @param expected the object that 
	 * <code class="prettyprint">actual</code> should be 
	 * strictly equal to.
	 * @param actual the object to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * var s1:String = "0";
	 * var n2:Number = 0;
	 * var s3:String = "0";
	 * 
	 * // Does not throw an error
	 * assertStrictlyEquals(s1, s3);
	 * 
	 * // Throws an error
	 * assertStrictlyEquals(s1, n2);
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertStrictlyEquals(
					expected:Object, 
					actual:Object, 
					testerMessage:String = ""
				):void
	{
		if (expected !== actual)
		{
			Assertion.fail("Expected < "+
			expected+" > but was strictly < "+
			actual+" >", testerMessage);
		}
	}
	
	/**
	 * Asserts that the specified 
	 * <code class="prettyprint">condition</code> is true, 
	 * that is to say it is respected.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * <p>You pass an instance of a class that implements the 
	 * <code class="prettyprint">ICondition</code> interface as 
	 * the first parameter. The assertion is true if the 
	 * <code class="prettyprint">ICondition.isConditionRespected()</code> 
	 * returns <code class="prettyprint">true</code>.</p>
	 * 
	 * <p>Typically, you will use your own subclass of the 
	 * <code class="prettyprint">astre.conditions.Condition</code> class, 
	 * one of the <code class="prettyprint">astre.conditions</code> package 
	 * condition, and/or use the 
	 * <code class="prettyprint">astre.conditions.CombinedCondition</code> 
	 * to combine conditions.</p>
	 * 
	 * <p>See the <code class="prettyprint">astre.conditions</code> 
	 * package for more informations.</p>
	 * 
	 * @param condition the condition to be tested
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @see astre.conditions
	 * @see astre.conditions.CombinedCondition
	 * @see astre.conditions.Condition
	 * @see ICondition
	 * @see Assertion#fail()
	 * 
	 */
	public static function assertConditionRespected(
					condition:ICondition, 
					testerMessage:String = ""
				):void
	{
		if (!condition.isConditionRespected())
		{
			Assertion.fail(
					condition.getUnexpectedResultMessage(), 
					testerMessage
				);
		}
	}
	
	/**
	 * Asserts that the specified 
	 * <code class="prettyprint">condition</code> is false, 
	 * that is to say it is not respected.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * 
	 * <p>You pass an instance of a class that implements the 
	 * <code class="prettyprint">ICondition</code> interface as 
	 * the first parameter. The assertion is true if the 
	 * <code class="prettyprint">ICondition.isConditionRespected()</code> 
	 * returns <code class="prettyprint">false</code>.</p>
	 * 
	 * <p>Typically, you will use your own subclass of the 
	 * <code class="prettyprint">astre.conditions.Condition</code> class, 
	 * one of the <code class="prettyprint">astre.conditions</code> package 
	 * condition, and/or use the 
	 * <code class="prettyprint">astre.conditions.CombinedCondition</code> 
	 * to combine conditions.</p>
	 * 
	 * <p>See the <code class="prettyprint">astre.conditions</code> 
	 * package for more informations.</p>
	 * 
	 * 
	 * @param condition the condition to be tested
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @see astre.conditions
	 * @see astre.conditions.CombinedCondition
	 * @see astre.conditions.Condition
	 * @see ICondition
	 * @see Assertion#fail()
	 */
	public static function assertConditionDisregarded(
					condition:ICondition, 
					testerMessage:String = ""
				):void
	{
		if (condition.isConditionRespected())
		{
			Assertion.fail(
					condition.getUnexpectedResultMessage(), 
					testerMessage
				);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">object</code> object 
	 * has a type that is compatible with the specified 
	 * <code class="prettyprint">expectedType</code> parameter.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param expectedType the expected type of the object to test.
	 * @param object the object whose type is to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Throws an error
	 * assertCompatibleType(Shape, new Sprite());
	 * 
	 * // Does not throw an error
	 * assertCompatibleType(DisplayObject, new Sprite());
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertCompatibleType(
					expectedType:Class, 
					object:Object, 
					testerMessage:String = ""
				):void
	{
		if (!(object is expectedType))
		{
			Assertion.fail(
					"Expected < "+object+
					" > to have a compatible type with < "+
					expectedType+" > but has not", 
					testerMessage
				);
		}
	}
	
	/**
	 * Asserts that the <code class="prettyprint">object</code> object 
	 * has not a type that is compatible with the specified 
	 * <code class="prettyprint">expectedType</code> parameter.
	 * If the assertion is not true, it will throw an 
	 * <code class="prettyprint">AssertionError</code>.
	 * 
	 * @param unexpectedType the unexpected type of the object to test.
	 * @param object the object whose type is to be tested.
	 * @param testerMessage An additionnal message the possible error 
	 * will carry.
	 * @throws   <code class="prettyprint">AssertionError</code> - if 
	 * the assertion fails.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * 
	 * // Throws an error
	 * assertNotCompatibleType(DisplayObject, new Sprite());
	 * 
	 * // Does not throw an error
	 * assertNotCompatibleType(Shape, new Sprite());
	 * 
	 * </pre>
	 * 
	 * @see Assertion#fail()
	 */
	public static function assertNotCompatibleType(
					unexpectedType:Class, 
					object:Object, 
					testerMessage:String = ""
				):void
	{
		if (object is unexpectedType)
		{
			Assertion.fail(
					"< "+object+
					" > had a unexpected compatible type < "+
					unexpectedType+" >", 
					testerMessage
				);
		}
	}
	
	/**
	 * Throws an <code class="prettyprint">AssertionError</code> error 
	 * with the given messages. Use this method in your tests to 
	 * make them fail directly, for example if an exception is 
	 * caught and it should not be.
	 * 
	 * @param message The standard message that caused the error. 
	 * Unless the <code class="prettyprint">fail()</code> is 
	 * directly called by the developer, 
	 * it is created automatically accordingly to the causal error.
	 * @param testerMessage An additionnal message that the error will carry. 
	 * Use this message to add any particular precision you 
	 * consider useful for debugging.
	 * 
	 * @throws   <code class="prettyprint">AssertionError</code> - Always 
	 * thrown, with the specified strings.
	 * 
	 */
	public static function fail(
					message:String = "", 
					testerMessage:String = ""
				):void
	{
		throw new AssertionError(message, testerMessage);
	}
	
}
	
}
