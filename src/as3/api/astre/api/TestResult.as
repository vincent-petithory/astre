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

package astre.api 
{
	import astre.core.AtomicResult;
	import astre.core.manipulation.ResultSortRule;

/**
 * A <code class="prettyprint">TestResult</code> object aggregates 
 * <code class="prettyprint">AtomicResult</code> objects.
 * It provides filter and sort features as well as convenient 
 * informations on the whole results.
 * 
 * @see astre.core.AtomicResult
 * 
 * @author lunar
 * 
 */
public class TestResult 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * Specifies to include none of the results for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const NOTHING:uint = 0;
	
	/**
	 * Specifies to include the 
	 * <code class="prettyprint">AtomicResult</code> whose result type is 
	 * <code class="prettyprint">EResultType.IGNORED</code> for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const IGNORED:uint = 1;
	
	/**
	 * Specifies to include the 
	 * <code class="prettyprint">AtomicResult</code> whose result type is 
	 * <code class="prettyprint">EResultType.UNEXPECTED_ERROR</code> for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const ERRORS:uint = 2;
	
	/**
	 * Specifies to include the 
	 * <code class="prettyprint">AtomicResult</code> whose result type is 
	 * <code class="prettyprint">EResultType.FALURE</code> for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const FAILURES:uint = 4;
	
	/**
	 * Specifies to include the 
	 * <code class="prettyprint">AtomicResult</code> whose result type is 
	 * <code class="prettyprint">EResultType.PASSED</code> for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const PASSED:uint = 8;
	
	/**
	 * Specifies to include all the results types for 
	 * the result filter methods.
	 * 
	 * @see #filterResults()
	 * 
	 */
	public static const ALL:uint = 15;
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * @private
	 * Internal storage of the results.
	 */
	private var resultArray:Array;
	
	/**
	 * Has the value <code class="prettyprint">true</code> if 
	 * all the tests have been passed (or ignored).
	 * Otherwise, the value is <code class="prettyprint">false</code>.
	 */
	public function get isSuccessful():Boolean
	{
		return resultArray.every(allTestsAreSuccessfulEvery);
	}
	
	/**
	 * The total runtime taken to run all the tests.
	 */
	public function get totalRuntime():Number
	{
		var runtime:Number = 0;
		for each (var result:AtomicResult in resultArray)
		{
			runtime += result.runtime;
		}
		return runtime;
	}
	
	/**
	 * The total memory variation noticed during the tests processing.
	 */
	public function get totalMemoryVariation():Number
	{
		var memory:Number = 0;
		for each (var result:AtomicResult in resultArray)
		{
			memory += result.memoryVariation;
		}
		return memory;
	}
	
	/**
	 * The total number of <code class="prettyprint">AtomicResult</code> 
	 * objects recorded in this <code class="prettyprint">TestResult</code>.
	 */
	public function get numResults():uint
	{
		return resultArray.length;
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 */
	public function TestResult() 
	{
		super();
		resultArray = new Array();
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Adds an <code class="prettyprint">AtomicResult</code> to 
	 * this <code class="prettyprint">TestResult</code>.
	 * 
	 * @param atomicResult the <code class="prettyprint">AtomicResult</code> 
	 * to be added.
	 */
	public function addAtomicResult(atomicResult:AtomicResult):void
	{
		resultArray.push(atomicResult);
	}
	
	/**
	 * Returns a sub-result of this <code class="prettyprint">TestResult</code>.
	 * 
	 * @param options The filter options to apply. You may use integers 
	 * or the static properties defined by the 
	 * <code class="prettyprint">TestResult</code> class. You may combine 
	 * several options by using the 
	 * <code class="prettyprint">|</code> (bitwise OR) operator, as this 
	 * example shows :<br/>
	 * 
	 * <pre class="prettyprint">
	 * 
	 * // Will return all the results whose type is 
	 * // EResultType.FAILURE and EResultType.PASSED
	 * myResult.filterResults(	
	 * 						TestResult.FAILURES | 
	 * 						TestResult.PASSED 
	 * 					);
	 * 
	 * </pre>
	 * By default, all the results are included.
	 * 
	 * @return a sub-result of this <code class="prettyprint">TestResult</code> 
	 * depending of the specified options.
	 * 
	 * @see EResultType
	 * @see #NOTHING
	 * @see #IGNORED
	 * @see #ERRORS
	 * @see #FAILURES
	 * @see #PASSED
	 * @see #ALL
	 * 
	 */
	public function filterResults(options:uint = 0xf):TestResult
	{
		var results:Array;
		switch (options)
		{
			case 1: 
				// ignored
				results = resultArray.filter(ignoredFilter);
				break;
			case 2: 
				// errors
				results = resultArray.filter(errorsFilter);
				break;
			case 3: 
				// errors | ignored
				results = resultArray.filter(
								notFailuresFilter
							).filter(notPassedFilter);
				break;
			case 4: 
				// failures
				results = resultArray.filter(failuresFilter);
				break;
			case 5: 
				// failures | ignored
				results = resultArray.filter(
								notPassedFilter
							).filter(notErrorsFilter);
				break;
			case 6: 
				// failures | errors
				results = resultArray.filter(
								notPassedFilter
							).filter(notIgnoredFilter);
				break;
			case 7: 
				// failures | errors | ignored
				results = resultArray.filter(notPassedFilter);
				break;
			case 8: 
				// passed
				results = resultArray.filter(passedFilter);
				break;
			case 9: 
				// passed | ignored
				results = resultArray.filter(
								notFailuresFilter
							).filter(notErrorsFilter);
				break;
			case 10: 
				// passed | errors
				results = resultArray.filter(
								notIgnoredFilter
							).filter(notFailuresFilter);
				break;
			case 11: 
				// passed | errors | ignored
				results = resultArray.filter(notFailuresFilter);
				break;
			case 12: 
				// passed | failures
				results = resultArray.filter(
								notErrorsFilter
							).filter(notIgnoredFilter);
				break;
			case 13: 
				// passed | failures | ignored
				results = resultArray.filter(notErrorsFilter);
				break;
			case 14: 
				// passed | failures | errors
				results = resultArray.filter(notIgnoredFilter);
				break;
			case 15: 
				// passed | failures | errors | ignored
				results = resultArray.slice();
				break;
			case 0: 
			default: 
				// no results. Not very useful...
				results = new Array();
		}
		var result:TestResult = new TestResult();
		result.resultArray = results;
		return result;
	}
	
	/**
	 * Sorts this <code class="prettyprint">TestResult</code> results with 
	 * this specified <code class="prettyprint">ResultSortRule</code>.
	 * 
	 * @param rule The rule to apply to this 
	 * <code class="prettyprint">TestResult</code>.
	 * 
	 * @see astre.runner.manipulation.ResultSortRule
	 * @see astre.runner.manipulation.resultRules
	 * 
	 */
	public function sort(rule:ResultSortRule):void
	{
		resultArray.sort(rule.compare);
	}
	
	/**
	 * Returns an array of all the 
	 * <code class="prettyprint">AtomicResult</code> objects in this 
	 * <code class="prettyprint">TestResult</code>.
	 * 
	 * @return an array of all the 
	 * <code class="prettyprint">AtomicResult</code> objects in this 
	 * <code class="prettyprint">TestResult</code>.
	 */
	public function toArray():Array
	{
		return this.resultArray.slice();
	}
	
	/**
	 * Returns an xml representation of this <code class="prettyprint">TestResult</code>.
	 * @return an xml representation of this <code class="prettyprint">TestResult</code>.
	 */
	public function toXML():XML 
	{
		var xmlResults:XML = new XML("<results />");
		xmlResults.@success = isSuccessful.toString();
		xmlResults.@runtime = totalRuntime.toString();
		xmlResults.@memory = totalMemoryVariation.toString();
		xmlResults.@numTests = numResults.toString();
		xmlResults.@numFailures = this.filterResults(TestResult.FAILURES).numResults.toString();
		xmlResults.@numErrors = this.filterResults(TestResult.ERRORS).numResults.toString();
		xmlResults.@numIgnored = this.filterResults(TestResult.IGNORED).numResults.toString();
		
		var results:Array = this.resultArray;
		for each (var atomicResult:AtomicResult in results)
		{
			var arxml:XML = new XML("<result />");
			arxml.@runtime = atomicResult.runtime.toString();
			arxml.@memory = atomicResult.memoryVariation.toString();
			arxml.@type = atomicResult.type.name;
			var errorxml:XML = new XML("<error />");
			if (atomicResult.error != null)
			{
				errorxml.@exists = true;
				errorxml.@stackTrace = atomicResult.error.getStackTrace();
				errorxml.@testerMessage = atomicResult.error.getTesterMessage();
			}
			else
			{
				errorxml.@exists = false;
			}
			arxml.appendChild(errorxml);
			
			var descriptionxml:XML = new XML("<test />");
			descriptionxml.@packageName = atomicResult.testDescription.packageName;
			descriptionxml.@className = atomicResult.testDescription.className;
			descriptionxml.@method = atomicResult.testDescription.method;
			arxml.appendChild(descriptionxml);
			xmlResults.appendChild(arxml);
		}
		return xmlResults;
	}
	
	/**
	 * Returns a clone of this <code class="prettyprint">TestResult</code>.
	 * @return a clone of this <code class="prettyprint">TestResult</code>.
	 */
	public function clone():TestResult
	{
		var r:Array = new Array();
		for each (var ar:AtomicResult in resultArray)
		{
			r.push(ar.clone());
		}
		var result:TestResult = new TestResult();
		result.resultArray = r;
		return result;
	}
	
	//------------------------------
	//
	// Sort and filter functions
	//
	//------------------------------
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <code class="prettyprint">EResultType.FAILURE</code>.
	 */
	private static var failuresFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type == EResultType.FAILURE;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <code class="prettyprint">EResultType.PASSED</code>.
	 */
	private static var passedFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type == EResultType.PASSED;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <code class="prettyprint">EResultType.UNEXPECTED_ERROR</code>.
	 */
	private static var errorsFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type == EResultType.UNEXPECTED_ERROR;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <code class="prettyprint">EResultType.IGNORED</code>.
	 */
	private static var ignoredFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type == EResultType.IGNORED;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <b>not</b> <code class="prettyprint">EResultType.FAILURE</code>.
	 */
	private static var notFailuresFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type != EResultType.FAILURE;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <b>not</b> <code class="prettyprint">EResultType.PASSED</code>.
	 */
	private static var notPassedFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type != EResultType.PASSED;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <b>not</b> <code class="prettyprint">EResultType.UNEXPECTED_ERROR</code>.
	 */
	private static var notErrorsFilter:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return item.type != EResultType.UNEXPECTED_ERROR;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * <b>not</b> <code class="prettyprint">EResultType.IGNORED</code>.
	 */
	private static var notIgnoredFilter:Function = function(
												item:AtomicResult, 
												index:int, 
												array:Array
											):Boolean
	{
		return item.type != EResultType.IGNORED;
	}
	
	/**
	 * @private
	 * A filter function that returns 
	 * <code class="prettyprint">true</code> if the 
	 * specified <code class="prettyprint">AtomicResult</code> type is 
	 * neither <code class="prettyprint">EResultType.FAILURE</code> 
	 * nor <code class="prettyprint">EResultType.UNEXPECTED_ERROR</code>.
	 */
	private static var allTestsAreSuccessfulEvery:Function = function(
														item:AtomicResult, 
														index:int, 
														array:Array
													):Boolean
	{
		return 	item.type != EResultType.FAILURE && 
				item.type != EResultType.UNEXPECTED_ERROR;
	}
	
}
	
}
