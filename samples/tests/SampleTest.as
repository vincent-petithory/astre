package tests 
{
    import astre.api.*;
    
    public class SampleTest extends Test 
    {
        public var value1:int;
        
        public var value2:int;
        
        public function SampleTest()
        {
            super();
        }
        
        public function setUp():void
        {
            value1 = 2;
            value2 = 3;
        }
        
        public function testAddFail():void
        {
            var result:int = value1 + value2 + 1; //force failure with +1
            assertTrue(result == 5, "result is not 5");
        }
        
        public function testAddOk():void
        {
            var result:int = value1 + value2;
            assertTrue(result == 5, "result is not 5");
        }
        
        public function testDivideByZero():void
        {
            var zero:int = 0;
            var result:int = 8 / zero;
            
            //forced failure
            //assertEquals(8, result);
        }
        
        ignore function testEquals():void
        {
            // should fail but is ignored, so it's ok.
            assertEquals(12, 12);
            
            var twelve:String = (12).toString(16);
            assertEquals(twelve, "c");
            
            assertEquals(0x000000000c, 0x000000000c);
            
            //forced failure
            assertEquals(12.0, 11.99, "Capacity");
            
            //passing test
            //assertEquals( 12.0, 12, "Capacity" );
        }
        
        public function testEqualsObject():void
        {
            var obj1:Object = {a:1, b:2, c:3};
            var obj2:Object = {a:1, b:2, c:4};
            var obj3:Object = obj1;
            
            //forced failure
            //assertEquals(obj1, obj2);
            
            //passing test
            assertEquals( obj1, obj3 );
        }
        
        public function testErrorThrow():void
        {
            //throw new Error("this is a basic error");
        }
    }
}


