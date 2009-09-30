package astre.processor 
{
	import astre.processor.mockobjects.BaseMockTest;
	import astre.processor.mockobjects.MainMethodBTest;
	import astre.processor.mockobjects.MainMethodDTest;
	import astre.processor.mockobjects.MainMethodITest;
	import astre.processor.mockobjects.MainMethodNTest;
	import astre.processor.mockobjects.SetUpBTest;
	import astre.processor.mockobjects.SetUpDTest;
	import astre.processor.mockobjects.SetUpITest;
	import astre.processor.mockobjects.SetUpNTest;
	import astre.processor.mockobjects.TearDownBTest;
	import astre.processor.mockobjects.TearDownDTest;
	import astre.processor.mockobjects.TearDownITest;
	import astre.processor.mockobjects.TearDownNTest;
	import astre.processor.process.ETestProcessPhase;
	import astre.runner.ITestRunner;
	import astre.runner.RunRequest;
	import astre.runner.TestProgressEvent;
	import astre.runner.TestRunner;
	import astre.core.Test;
	import flash.events.IEventDispatcher;

public class TestProcessorTest extends Test
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var runner:ITestRunner;
	private var expectedSequence:Array;
	private var actualSequence:Array;
	private var expectedProcessesRun:uint;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	public function TestProcessorTest(name:String) 
	{
		super(name);
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	//------------------------------
	// Overrides
	//------------------------------
	
	override public function setUp():void 
	{
		runner = new TestRunner();
		actualSequence = new Array();
		expectedProcessesRun = 0;
	}
	
	override public function tearDown():void 
	{
		runner = null;
		actualSequence = null;
		expectedSequence = null;
		expectedProcessesRun = 0;
	}
	
	//------------------------------
	// Test methods that check
	// the processes flow
	//------------------------------
	
	//------------------------------
	// SUN
	//------------------------------
	
	public function setUpNNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpNTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	//------------------------------
	// SUI
	//------------------------------
	
	public function setUpINTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpITest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function setUpIITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpITest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function setUpIDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpITest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function setUpIBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpITest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// SUD
	//------------------------------
	
	public function setUpDNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpDTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function setUpDITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpDTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function setUpDDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpDTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function setUpDBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpDTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// SUB
	//------------------------------
	
	public function setUpBNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpBTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function setUpBITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpBTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function setUpBDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpBTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function setUpBBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(SetUpBTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// TDN
	//------------------------------
	
	public function tearDownNNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(TearDownNTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	//------------------------------
	// TDI
	//------------------------------
	
	public function tearDownINTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownITest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function tearDownIITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownITest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function tearDownIDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownITest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function tearDownIBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownITest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// TDD
	//------------------------------
	
	public function tearDownDNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownDTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function tearDownDITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownDTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function tearDownDDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownDTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function tearDownDBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownDTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// TDB
	//------------------------------
	
	public function tearDownBNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownBTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function tearDownBITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownBTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function tearDownBDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownBTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function tearDownBBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD
			);
		createTest(TearDownBTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// MMN
	//------------------------------
	
	public function mainMethodNNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodNTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	//------------------------------
	// MMI
	//------------------------------
	
	public function mainMethodINTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodITest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function mainMethodIITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodITest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function mainMethodIDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodITest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function mainMethodIBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodITest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// MMD
	//------------------------------
	
	public function mainMethodDNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodDTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function mainMethodDITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodDTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function mainMethodDDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodDTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function mainMethodDBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodDTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// MMB
	//------------------------------
	
	public function mainMethodBNTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodBTest, BaseMockTest.TRIGGER_NOTHING, expectedSequence);
		
	}
	
	public function mainMethodBITest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodBTest, BaseMockTest.TRIGGER_IMMEDIATE, expectedSequence);
		
	}
	
	public function mainMethodBDTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodBTest, BaseMockTest.TRIGGER_DEFERRED, expectedSequence);
		
	}
	
	public function mainMethodBBTest():void
	{
		expectedSequence = new Array(
				ETestProcessPhase.SET_UP, 
				ETestProcessPhase.MAIN_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_TIMEOUT, 
				ETestProcessPhase.ASYNC_METHOD, 
				ETestProcessPhase.TEAR_DOWN
			);
		createTest(MainMethodBTest, BaseMockTest.TRIGGER_BOTH, expectedSequence);
		
	}
	
	//------------------------------
	// Shared methods
	//------------------------------
	
	private function onProgress(event:TestProgressEvent, sequence:Array):void
	{
		actualSequence.push(event.processPhase);
		expectedProcessesRun++;
		if (expectedProcessesRun == expectedSequence.length)
		{
			assertArrayEquals(expectedSequence, actualSequence);
		}
		else
		{
			this.addDeferredAsync(1500, runner.progressNotifier, TestProgressEvent.TEST_PROGRESS, onProgress, sequence);
		}
	}
	
	private function createTest(testClass:Class, method:String, sequence:Array):void
	{
		this.addDeferredAsync(1500, runner.progressNotifier, TestProgressEvent.TEST_PROGRESS, onProgress, sequence);
		runner.runWith(RunRequest.singleTest(new testClass(method)));
	}
	
}
	
}

