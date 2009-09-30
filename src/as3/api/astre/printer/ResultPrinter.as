////////////////////////////////////////////////////////////////////////////
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
// 
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
// 
// The Original Code is Astre framework.
// 
// The Initial Developer of the Original Code is 
// Vincent Petithory   "vincent.petithory@gmail.com".
// Portions created by the Initial Developer are Copyright (C) 2008-2009 
// the Initial Developer. All Rights Reserved.
// 
// Contributor(s): 
////////////////////////////////////////////////////////////////////////////

package astre.printer 
{
	import astre.core.AtomicResult;
	import astre.core.EResultType;
	import astre.core.Test;
	import astre.runner.AbstractTestListener;
	import astre.runner.ITestRunner;
	import astre.runner.Result;
	import astre.runner.RunConfiguration;
	import flash.utils.getQualifiedClassName;

/**
 * A <code class="prettyprint">ResultPrinter</code> is a 
 * <code class="prettyprint">ITestListener</code> that 
 * logs test results as long as they are incoming, as well as 
 * printing a header information and a footer summary for 
 * the run to which it is associated.
 * 
 * @author lunar
 * 
 */
public class ResultPrinter extends AbstractTestListener
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * A flag that indicates if the whole stack traces 
	 * or only pertinent lines should be printed.
	 * 
	 * @default false
	 */
	public var showWholeStackTraces:Boolean = false;
	
	/**
	 * A flag that indicates if messages from the 
	 * tester should be printed.
	 * 
	 * <p>A tester message is an optional message passed to 
	 * an assert method.</p>
	 * 
	 * @default true
	 * 
	 * @see astre.core.Assertion
	 * 
	 */
	public var showTesterMessages:Boolean = true;
	
	/**
	 * A flag that indicates if the result of tests that 
	 * passed should be printed.
	 * 
	 * @default true
	 */
	public var showPassedTestResults:Boolean = false;
	
	/**
	 * A flag that indicates if the result of tests that 
	 * were ignored should be printed.
	 * 
	 * @default true
	 */
	public var showIgnoredTests:Boolean = false;
	
	/**
	 * The function that will be used to log the results. The specified 
	 * function must accept at least one parameter of any type. 
	 * Other parameters must be optional. By default, 
	 * the global function <code class="prettyprint">trace()</code> is 
	 * used.
	 * 
	 * @default DEFAULT_LOGGER_FUNCTION
	 */
	public var loggerFunction:Function;
	
	/**
	 * The default function used to log the results.
	 * @default trace
	 */
	public static const DEFAULT_LOGGER_FUNCTION:Function = trace;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param showWholeStackTraces A flag that indicates if 
	 * the whole stack traces 
	 * or only pertinent lines should be printed.
	 * @param showTesterMessages A flag that indicates 
	 * if messages from the tester should be printed.
	 * @param showPassedTestResults A flag that indicates 
	 * if the result of tests that passed should be printed.
	 * @param showIgnoredTests A flag that indicates 
	 * if the result of tests that were ignored should be printed.
	 * @param loggerFunction
	 */
	public function ResultPrinter(
									showWholeStackTraces:Boolean = false, 
									showTesterMessages:Boolean = true, 
									showPassedTestResults:Boolean = false, 
									showIgnoredTests:Boolean = false, 
									loggerFunction:Function = null
								) 
	{
		super();
		this.showWholeStackTraces = showWholeStackTraces;
		this.showTesterMessages = showTesterMessages;
		this.showPassedTestResults = showPassedTestResults;
		this.showIgnoredTests = showIgnoredTests;
		if (loggerFunction == null)
		{
			this.loggerFunction = DEFAULT_LOGGER_FUNCTION;
		}
		else
		{
			this.loggerFunction = loggerFunction;
		}
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * @inheritDoc
	 */
	override public function runStart(runner:ITestRunner):void 
	{
		var d:Date = new Date();
		
		print("---- START PROCESSING NEW TEST SUITE ----");
		print("> Started on "+formatMonthOrDay(d.month)+"/"+
			formatMonthOrDay(d.date)+"/"+d.fullYear+" "+d.toTimeString());
		print("> "+runner.numTests+" test"+
			(runner.numTests == 1 ? "" : "s")+" to run."
		);
		print("> Configuration :");
		print("\tTestRunnerClass : "+getQualifiedClassName(runner));
		print("\tTestProcessorClass : "+getQualifiedClassName(runner.runConfiguration.testProcessorClass));
	}
	
	/**
	 * @inheritDoc
	 */
	override public function runEnd(runner:ITestRunner):void 
	{
		var d:Date = new Date();
		var numPassed:uint = 
			runner.results.getResults(Result.PASSED).numResults;
		var numFailures:uint = 
			runner.results.getResults(Result.FAILURES).numResults;
		var numErrors:uint = 
			runner.results.getResults(Result.ERRORS).numResults;
		var numIgnored:uint = 
			runner.results.getResults(Result.IGNORED).numResults;
		var numTests:uint = 
			runner.results.getResults(Result.ALL).numResults;
		
		print("---- END PROCESSING ----");
		print("> Ended on "+formatMonthOrDay(d.month)+"/"+
			formatMonthOrDay(d.day)+"/"+d.fullYear+" "+d.toTimeString());
		print("> Tests run : "+runner.numTestsRun+"/"+runner.numTests);
		print("> Result detail :");
		print("\tPassed : "+numPassed);
		print("\tFailures : "+numFailures);
		print("\tErrors : "+numErrors);
		print("\tIgnored : "+numIgnored);
		print("\tExecution time : "+runner.results.totalRuntime+"ms");
	}
	
	/**
	 * @inheritDoc
	 */
	override public function testEnd(test:Test, result:AtomicResult):void 
	{
		var resultType:EResultType = result.type;
		if (resultType == EResultType.PASSED && !showPassedTestResults)
		{
			return;
		}
		if (resultType == EResultType.IGNORED && !showIgnoredTests)
		{
			return;
		}
		var str:String = result.toString();
		if (result.error)
		{
			str += "\n";
			var testerMessage:String = result.error.getTesterMessage();
			if (showTesterMessages && 
				testerMessage != null && testerMessage != "")
			{
				str += "\t Tester message : "+testerMessage+"\n";
			}
			
			if (showWholeStackTraces)
			{
				var stackTrace:String = result.error.getStackTrace();
				if (stackTrace != null && stackTrace != "")
				{
					str += stackTrace+"\n";
				}
			}
			else
			{
				str += result.getPertinentErrorStackTrace();
			}
		}
		print(str);
	}
	
	/**
	 * Logs the specified string.
	 * @param string The string to be logged.
	 */
	public function print(string:String):void
	{
		this.loggerFunction(string);
	}
	
	/**
	 * @private
	 */
	private function formatMonthOrDay(number:Number):String
	{
		if (number < 10)
		{
			return "0"+number.toString();
		}
		else
		{
			return number.toString();
		}
	}
	
}
	
}
