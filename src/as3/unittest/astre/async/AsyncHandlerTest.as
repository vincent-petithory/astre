package astre.async 
{
	import astre.core.Assertion;
	import astre.core.Test;
	import flash.display.Sprite;

public class AsyncHandlerTest extends Test
{
	private var asyncHandler:AsyncHandler;
	
	public function AsyncHandlerTest(name:String) 
	{
		super(name);
	}
	
	override public function setUp():void 
	{
		asyncHandler = new AsyncHandler();
	}
	
	override public function tearDown():void 
	{
		asyncHandler = null;
	}
	
	public function getAsyncCheckoutByIdTest():void
	{
		
		const NUM_CHECKOUTS:int = 1000;
		var someCheckout:IAsyncCheckout;
		var checkoutIndex:int = Math.floor(Math.random()*NUM_CHECKOUTS);
		for (var i:int = 0 ; i < 1000 ; i++)
		{
			var checkout:IAsyncCheckout = new AsyncCheckout(asyncHandler.getUniqueId());
			if (i == checkoutIndex)
			{
				someCheckout = checkout;
			}
			asyncHandler.addCheckout(checkout);
		}
		var returnedCheckout:IAsyncCheckout = asyncHandler.getAsyncCheckoutById(someCheckout.id);
		
		assertEquals(someCheckout, returnedCheckout);
	}
	
	public function getUniqueIdTest():void
	{
		for (var i:int = 0 ; i < 1000 ; i++)
		{
			var checkout:IAsyncCheckout = new AsyncCheckout(asyncHandler.getUniqueId());
			asyncHandler.addCheckout(checkout);
		}
		var ids:Array = new Array();
		while (asyncHandler.hasAsync())
		{
			ids.push(asyncHandler.getNextAsync());
		}
		var fail:Boolean = false;
		while(ids.length > 0)
		{
			var id:uint = ids.pop();
			var index:int = ids.indexOf(id);
			if (index != -1)
			{
				fail = true;
			}
		}
		assertFalse(fail);
	}
	
}
	
}
