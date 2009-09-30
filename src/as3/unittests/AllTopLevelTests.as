package  
{
	import astre.AllAstreTests;
	import astre.core.TestList;

public class AllTopLevelTests 
{
	
	public static function testList():TestList
	{
		var list:TestList = new TestList();
		list.addTestList(new AllAstreTests());
		return list;
	}
	
}
	
}
