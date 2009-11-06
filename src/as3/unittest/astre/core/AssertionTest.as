package astre.core 
{

public class AssertionTest extends Test
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function AssertionTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function failTest():void
	{
		var caught:Boolean = false;
		try 
		{
			Assertion.fail("Trying to fail the test");
		} catch (e:AssertionError)
		{
			caught = true;
		}
		assertTrue(caught, "AssertionError exception was not caught");
	}
	
	public function assertTrueTest():void
	{
		var b1:Boolean = false;
		var b2:Boolean = true;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertTrue(b1);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertTrue(b2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertFalseTest():void
	{
		var b1:Boolean = false;
		var b2:Boolean = true;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertFalse(b2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertFalse(b1);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertEqualsTest():void
	{
		var n1:Number = 0;
		var n2:Number = 1;
		var n3:Number = 0;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertEquals(n1, n2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertEquals(n1, n3);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotEqualsTest():void
	{
		var n1:Number = 0;
		var n2:Number = 1;
		var n3:Number = 0;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotEquals(n1, n3);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotEquals(n1, n2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertStrictlyEqualsTest():void
	{
		var s1:String = "0";
		var n2:Number = 0;
		var s3:String = "0";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertStrictlyEquals(s1, n2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertStrictlyEquals(s1, s3);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotStrictlyEqualsTest():void
	{
		var s1:String = "0";
		var n2:Number = 0;
		var s3:String = "0";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotStrictlyEquals(s1, s3);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotStrictlyEquals(s1, n2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertUndefinedTest():void
	{
		var u1:* = undefined;
		var u2:String = "notUndefined";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertUndefined(u2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertUndefined(u1);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotUndefinedTest():void
	{
		var u1:* = undefined;
		var u2:String = "notUndefined";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotUndefined(u1);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotUndefined(u2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNullTest():void
	{
		var o1:Object = null;
		var s2:String = "notNull";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNull(s2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNull(o1);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotNullTest():void
	{
		var o1:Object = null;
		var s2:String = "notNull";
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotNull(o1);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotNull(s2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertOwnsPropertyTest():void
	{
		var o:Object = {someProperty: "some value"};
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertOwnsProperty(o, "unknownProperty");
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertOwnsProperty(o, "someProperty");
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotOwnsPropertyTest():void
	{
		var o:Object = {someProperty: "some value"};
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotOwnsProperty(o, "someProperty");
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotOwnsProperty(o, "unknownProperty");
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertApproximateTest():void
	{
		var n1:Number = 0.5;
		var n2:Number = 0.8;
		var n3:Number = 0.55;
		var e:Number = 0.1;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertApproximate(n1, n2, e);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertApproximate(n1, n3, e);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertNotApproximateTest():void
	{
		var n1:Number = 0.5;
		var n2:Number = 0.8;
		var n3:Number = 0.55;
		var e:Number = 0.1;
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertNotApproximate(n1, n3, e);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertNotApproximate(n1, n2, e);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertArrayEqualsTest():void
	{
		var a1:Array = new Array(5, 7);
		var a2:Array = new Array("5", 7);
		var a3:Array = new Array(8, 5);
		var a4:Array = new Array(5, 7, 8);
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertArrayEquals(a1, a3);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertArrayEquals(a1, a2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
		
		var expectedCaught2:Boolean = false;
		
		try
		{
			assertArrayEquals(a1, a4);
		} catch (e:AssertionError)
		{
			expectedCaught2 = true;
		}
		assertTrue(expectedCaught2, "AssertionError exception was not caught");
	}
	
	public function assertArrayNotEqualsTest():void
	{
		var a1:Array = new Array(5, 7);
		var a2:Array = new Array(5, 7);
		var a3:Array = new Array(8, 5);
		var a4:Array = new Array(5, 7, 8);
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertArrayNotEquals(a1, a2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertArrayNotEquals(a1, a3);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
		
		var expectedCaught2:Boolean = true;
		
		try
		{
			assertArrayNotEquals(a1, a4);
		} catch (e:AssertionError)
		{
			expectedCaught2 = false;
		}
		assertTrue(expectedCaught2, "Unexpected AssertionError exception was caught");
	}
	
	public function assertArrayStrictlyEqualsTest():void
	{
		var a1:Array = new Array(5, 7);
		var a2:Array = new Array(5, 7);
		var a3:Array = new Array("5", "7");
		var a4:Array = new Array(5, 7, 8);
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertArrayStrictlyEquals(a1, a3);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertArrayStrictlyEquals(a1, a2);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
		
		var expectedCaught2:Boolean = false;
		
		try
		{
			assertArrayStrictlyEquals(a1, a4);
		} catch (e:AssertionError)
		{
			expectedCaught2 = true;
		}
		assertTrue(expectedCaught2, "Unexpected AssertionError exception was caught");
	}
	
	public function assertArrayNotStrictlyEqualsTest():void
	{
		var a1:Array = new Array(5, 7);
		var a2:Array = new Array(5, 7);
		var a3:Array = new Array("5", "7");
		var a4:Array = new Array(5, 7, 8);
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertArrayNotStrictlyEquals(a1, a2);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertArrayNotStrictlyEquals(a1, a3);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
		
		var expectedCaught2:Boolean = true;
		
		try
		{
			assertArrayNotStrictlyEquals(a1, a4);
		} catch (e:AssertionError)
		{
			expectedCaught2 = false;
		}
		assertTrue(expectedCaught2, "Unexpected AssertionError exception was caught");
	}
	
	public function assertConditionRespectedTest():void
	{
		var cT:ICondition = new AlwaysRespectedCondition();
		var cF:ICondition = new AlwaysDisregardedCondition();
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertConditionRespected(cF);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertConditionRespected(cT);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
	public function assertConditionDisregardedTest():void
	{
		var cT:ICondition = new AlwaysRespectedCondition();
		var cF:ICondition = new AlwaysDisregardedCondition();
		
		var expectedCaught:Boolean = false;
		
		try
		{
			assertConditionDisregarded(cT);
		} catch (e:AssertionError)
		{
			expectedCaught = true;
		}
		assertTrue(expectedCaught, "AssertionError exception was not caught");
		
		var expectedNotCaught:Boolean = true;
		
		try
		{
			assertConditionDisregarded(cF);
		} catch (e:AssertionError)
		{
			expectedNotCaught = false;
		}
		assertTrue(expectedNotCaught, "Unexpected AssertionError exception was caught");
	}
	
}
	
}
import astre.conditions.Condition;

internal class AlwaysRespectedCondition extends Condition
{
	
	override protected function processCondition():Boolean 
	{
		return true;
	}
	
	override protected function getUnexpectedConditionTrueMessage():String 
	{
		return "Condition is respected";
	}
	
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		return "Condition is disregarded";
	}
	
}

internal class AlwaysDisregardedCondition extends Condition
{
	
	override protected function processCondition():Boolean 
	{
		return false;
	}
	
	override protected function getUnexpectedConditionTrueMessage():String 
	{
		return "Condition is respected";
	}
	
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		return "Condition is disregarded";
	}
	
}