package astre.util 
{
	import astre.conditions.ArrayHasItem;
	import astre.core.Assertion;
	import astre.processor.ITestProcessor;
	import astre.processor.TestProcessor;
	import astre.core.Test;
	import astre.util.Reflection;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.*;

public class ReflectionTest extends Test
{
	
	public function ReflectionTest(name:String) 
	{
		super(name);
	}
	
	public function getMethodsTest():void
	{
		var methods:Array = Reflection.getMethods(BitmapData);
		
		var expected:Array = ["unlock","copyChannel","copyPixels",
							"getPixels","setPixel","pixelDissolve",
							"getColorBoundsRect","noise","hitTest",
							"perlinNoise","lock","scroll","draw",
							"applyFilter","dispose","fillRect",
							"threshold","floodFill","getPixel",
							"getPixel32","clone","setPixel32",
							"generateFilterRect","setPixels",
							"compare","colorTransform","merge",
							"paletteMap", "getVector", "histogram", 
							"setVector"];
							
		assertEquals(	
						expected.length, 
						methods.length, 
						"The number of analyzed methods does not match" 
					);
		
		for each (var methodName:String in expected)
		{
			assertConditionRespected(new ArrayHasItem(methods, methodName));
		}
		//assertArrayEquals(
					//expected, 
					//methods);
	}
	
	public function getClassNameTest():void
	{
		var className:String = Reflection.getClassName(BitmapData);
		var classNameTopLevel:String = Reflection.getClassName(Array);
		assertEquals(className, "BitmapData");
		assertEquals(classNameTopLevel, "Array");
	}
	
	public function getPackageTest():void
	{
		var packageName:String = Reflection.getPackage(BitmapData);
		var packageNameTopLevel:String = Reflection.getPackage(Array);
		assertEquals(packageName, "flash.display");
		assertEquals(packageNameTopLevel, "");
	}
	
	public function getClassNameTest2():void
	{
		var className:String = Reflection.getClassName(new BitmapData(1, 1));
		var classNameTopLevel:String = Reflection.getClassName(Array);
		assertEquals(className, "BitmapData");
		assertEquals(classNameTopLevel, "Array");
	}
	
	public function getPackageTest2():void
	{
		var packageName:String = Reflection.getPackage(new BitmapData(1, 1));
		var packageNameTopLevel:String = Reflection.getPackage(Array);
		assertEquals(packageName, "flash.display");
		assertEquals(packageNameTopLevel, "");
	}
	
	public function isImplementorOfTest():void
	{
		var clazz:Class = TestProcessor;
		assertTrue(Reflection.isImplementorOf(clazz, ITestProcessor));
	}
	
	public function isSubclassOfTest():void
	{
		var clazz:Class = ReflectionTest;
		assertTrue(Reflection.isSubClassOf(clazz, Test));
	}
	
}
	
}
