package astre.util 
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.IExternalizable;

/**
 * As the tests for the astre.util.TraceUtil class 
 * requires visual verifications on result traces,
 * this test class will not be automated, and has to be run alone.
 */
public class TraceUtilVerification extends Sprite
{
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function TraceUtilVerification() 
	{
		super();
		arrayVerify();
		dictionaryVerify();
		objectVerify();
		classExtendsVerify();
		classImplementsVerify();
		objectPublicPropertiesVerify();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function arrayVerify():void
	{
		var array:Array = new Array();
		
		for (var i:uint = 0 ; i < 10 ; i++)
		{
			array.push(Math.random()*20);
		}
		
		TraceUtil.array(array);
		TraceUtil.array(array, "myArray");
	}
	
	public function dictionaryVerify():void
	{
		var dictionary:Dictionary = new Dictionary();
		
		var keys:Array = new Array();
		var values:Array = new Array();
		
		for (var i:uint = 0 ; i < 10 ; i++)
		{
			keys.push(new Error("error"+Math.floor(Math.random()*1000)));
			values.push(Math.random()*20);
		}
		
		for (var j:uint = 0 ; j < 10 ; j++)
		{
			dictionary[keys[j]] = values[j];
		}
		
		TraceUtil.dictionary(dictionary);
		TraceUtil.dictionary(dictionary, "myDictionary");
	}
	
	public function objectVerify():void
	{
		var object:Object = new Object();
		
		var keys:Array = new Array();
		var values:Array = new Array();
		
		for (var i:uint = 0 ; i < 10 ; i++)
		{
			keys.push("key"+Math.floor(Math.random()*1000));
			values.push(Math.random()*20);
		}
		
		for (var j:uint = 0 ; j < 10 ; j++)
		{
			object[keys[j]] = values[j];
		}
		TraceUtil.object(object);
		TraceUtil.object(object, "myObject");
	}
	
	public function classExtendsVerify():void
	{
		TraceUtil.classExtends(Sprite, DisplayObject);
		TraceUtil.classExtends(Sprite, Shape);
	}
	
	public function classImplementsVerify():void
	{
		TraceUtil.classImplements(Sprite, IBitmapDrawable);
		TraceUtil.classImplements(Sprite, IExternalizable);
	}
	
	public function objectPublicPropertiesVerify():void
	{
		TraceUtil.objectPublicProperties(new CustomSprite());
		TraceUtil.objectPublicProperties(new CustomSprite(), "myCustomSprite");
		TraceUtil.objectPublicProperties(CustomSprite, "CustomSprite");
	}
	
}
	
}
import flash.display.Sprite;

class CustomSprite extends Sprite
{
	
	public static const NUM:Number = 10;
	public static var value:Number = 10;
	public static function get someValue():Number {return 10;}
	
	public const someConstantNumber:Number = 10;
	public const someConstantString:String = "Value";
	
	public var oneVar:String = "someValue";
	public var anotherVar:Number = 10;
	
	public function get readWriteVar():String
	{
		return "readWriteValue";
	}
	
	public function set readWriteVar(value:String):void
	{
		
	}
	
	public function get readOnlyVar():String
	{
		return "readOnlyValue";
	}
	
	public function set writeOnlyVar(value:String):void
	{
		
	}
	
}
