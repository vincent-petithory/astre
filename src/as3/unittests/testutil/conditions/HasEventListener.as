package testutil.conditions 
{
	import astre.conditions.Condition;
	import flash.events.IEventDispatcher;

public class HasEventListener extends Condition
{
	
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var dispatcher:IEventDispatcher;
	private var eventType:String;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function HasEventListener(dispatcher:IEventDispatcher, eventType:String) 
	{
		super();
		this.dispatcher = dispatcher;
		this.eventType = eventType;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	override protected function processCondition():Boolean 
	{
		return dispatcher.hasEventListener(eventType);
	}
	
	override protected function getUnexpectedConditionFalseMessage():String 
	{
		return "Expected < "+dispatcher+" > to have an event listener for < "+eventType+" > event type but has not";
	}
	
	override protected function getUnexpectedConditionTrueMessage():String 
	{
		return "< "+dispatcher+" > unexpectedly has an event listener for < "+eventType+" > event type";
	}
	
}
	
}
