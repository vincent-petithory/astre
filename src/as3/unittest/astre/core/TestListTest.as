package astre.core 
{
	import astre.core.Assertion;
	import flash.display.Sprite;

public class TestListTest extends Test
{
	private var testList:TestList;
	
	public function TestListTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		testList = new TestList();
	}
	
	override public function tearDown():void 
	{
		testList = null;
	}
	
	public function getTestsTest():void
	{
		var inner:TestList = new TestList();
		inner.addTest(new SampleTest("testMethod1"));
		inner.addTest(new SampleTest("testMethod2"));
		testList.addTestList(inner);
		testList.addTestClass(SampleTest);
		testList.addTest(new SampleTest("testMethod1"));
		assertEquals(5, testList.getTests().length);
	}
	
	public function addTestClassTest():void
	{
		testList.addTestClass(SampleTest);
		assertEquals(2, testList.getTests().length);
	}
	
	public function addTestTest():void
	{
		testList.addTest(new SampleTest("testMethod1"));
		assertEquals(1, testList.getTests().length);
	}
	
	public function addTestListTest():void
	{
		var inner:TestList = new TestList();
		inner.addTest(new SampleTest("testMethod1"));
		inner.addTest(new SampleTest("testMethod2"));
		testList.addTestList(inner);
		assertEquals(2, inner.getTests().length);
		assertEquals(2, testList.getTests().length);
	}
	
	public function externalStaticMethodTest():void
	{
		testList.addTestClass(TestListCreator);
		assertEquals(6, testList.getTests().length);
	}
	
	public function cloneTest():void
	{
		testList.addTestClass(TestListCreator);
		
		var cloneList:TestList = testList.clone();
		
		var tests:Array = testList.getTests();
		var cloneTests:Array = cloneList.getTests();
		assertEquals(tests.length, cloneTests.length);
		
		
		var l:uint = tests.length;
		for (var i:uint = 0 ; i < l ; i++)
		{
			assertEquals(tests[i].toString(), cloneTests[i].toString());
		}
	}
	
	public function checkTestListDontIncludePublicOverridesTest():void
	{
		testList.addTestClass(SampleTest);
		var tests:Array = testList.getTests();
		for each (var test:Test in tests)
		{
			assertNotEquals("clone", test.description.method);
			assertNotEquals("isIgnored", test.description.method);
		}
	}
	
}
	
}

import astre.core.Astre;
import astre.core.Test;

internal class SampleTest extends Test
{
	
	public function SampleTest(name:String)
	{
		super(name);
	}
	
	public function testMethod1():void
	{
		
	}
	
	public function testMethod2():void
	{
		
	}
	
	override public function isIgnored():Boolean 
	{
		return super.isIgnored();
	}
	
	override public function clone():Test 
	{
		return new SampleTest(Astre::runMethodName);
	}
}

import astre.core.TestList;

internal class TestListCreator 
{
	
	public static function testList():TestList
	{
		var list:TestList = new TestList();
		list.addTest(new SampleTest("testMethod1"));
		list.addTest(new SampleTest("testMethod2"));
		
		
		var list1:TestList = new TestList();
		list1.addTest(new SampleTest("testMethod1"));
		list1.addTest(new SampleTest("testMethod2"));
		
		
		var list2:TestList = new TestList();
		list2.addTest(new SampleTest("testMethod1"));
		list2.addTest(new SampleTest("testMethod2"));
		
		list.addTestList(list1);
		list.addTestList(list2);
		return list;
	}
	
}