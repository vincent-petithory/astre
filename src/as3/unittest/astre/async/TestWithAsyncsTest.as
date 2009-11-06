package astre.async 
{
	import astre.core.Assertion;
	import astre.core.Test;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;

public class TestWithAsyncsTest extends Test
{
	private var sprite:Sprite;
	
	public function TestWithAsyncsTest(name:String)
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function variousAsyncsTest():void
	{
		sprite = new Sprite();
		sprite.addEventListener("asyncType1", onEvent);
		this.addAsync(1000, sprite, "asyncType1", onEvent);
		this.addAsync(1500, sprite, "asyncType2", onEvent);
		this.addAsync(2000, sprite, "asyncType3", onEvent);
		this.addAsync(2500, sprite, "asyncType4", onEvent);
		this.addAsync(3000, sprite, "asyncType5", onEvent);
		this.addAsync(3500, sprite, "asyncType6", onEvent);
		this.addAsync(4000, sprite, "asyncType7", onEvent);
		this.addAsync(4500, sprite, "asyncType8", onEvent);
		this.addAsync(5000, sprite, "asyncType9", onEvent);
		
		setTimeout(dispatch, 750, "asyncType1");
		setTimeout(dispatch, 1250, "asyncType2");
		setTimeout(dispatch, 1750, "asyncType3");
		setTimeout(dispatch, 2250, "asyncType4");
		setTimeout(dispatch, 2750, "asyncType5");
		setTimeout(dispatch, 3250, "asyncType6");
		setTimeout(dispatch, 3750, "asyncType7");
		setTimeout(dispatch, 4250, "asyncType8");
		setTimeout(dispatch, 750, "asyncType9");
		
	}
	
	private function dispatch(eventType:String):void
	{
		sprite.dispatchEvent(new Event(eventType));
	}
	
	private function onEvent(event:Event):void
	{
		
	}
	
}
	
}
