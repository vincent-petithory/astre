package  
{
	import astre.api.*;;

public class AllTopLevelTests 
{
	
	public static function testSuite():TestSuite
	{
		var list:TestList = new TestList();
		list.add(new AllAstreTests());
		return list;
	}
	
}
	
}
