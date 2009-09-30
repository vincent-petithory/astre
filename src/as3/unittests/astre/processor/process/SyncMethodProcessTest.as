package astre.processor.process 
{

import astre.core.Assertion;
import astre.core.EResultType;
import astre.processor.ITestProcess;
import astre.core.Test;

public class SyncMethodProcessTest extends Test
{
	
	private var process:ITestProcess;

	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	public function SyncMethodProcessTest(name:String) 
	{
		super(name);
	}
	
	override public function tearDown():void 
	{
		process = null;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function catchAssertionErrorTest():void
	{
		process = new FailSyncProcess();
		this.addAsync(500, process, TestProcessEvent.TEST_PROCESS_END, onProcess1);
		process.run();
	}
	
	public function catchUnexpectedErrorTest():void
	{
		process = new UnexpectedErrorSyncProcess();
		this.addAsync(500, process, TestProcessEvent.TEST_PROCESS_END, onProcess2);
		process.run();
	}
	
	private function onProcess1(e:TestProcessEvent):void 
	{
		assertEquals(EResultType.FAILURE, e.testProcess.testProcessResult.type);
	}
	
	private function onProcess2(e:TestProcessEvent):void 
	{
		assertEquals(EResultType.UNEXPECTED_ERROR, e.testProcess.testProcessResult.type);
	}
	
}

}

import astre.core.Assertion;
import astre.core.Test;
import astre.processor.process.SyncMethodProcess;
import flash.display.Sprite;

internal class FailSyncProcess extends SyncMethodProcess
{
	public function FailSyncProcess()
	{
		super(new XTest(), null);
	}
	
	override protected function runSyncProcess():void 
	{
		Assertion.fail("Forced to fail");
	}
	
}

internal class MemoryUsageSyncProcess extends SyncMethodProcess
{
	public function MemoryUsageSyncProcess()
	{
		super(new XTest(), null);
	}
	
	override protected function runSyncProcess():void 
	{
		var a:Array = new Array();
		for (var i:uint = 0 ; i < 1000 ; i++)
		{
			a.push(Math.random()*1000);
		}
	}
	
}


internal class UnexpectedErrorSyncProcess extends SyncMethodProcess
{
	public function UnexpectedErrorSyncProcess()
	{
		super(new XTest(), null);
	}
	
	override protected function runSyncProcess():void 
	{
		var sprite:Sprite;
		sprite.numChildren;
	}
	
}

internal class XTest extends Test
{
	public function XTest()
	{
		super("method");
	}
	
	public function method():void {}
}