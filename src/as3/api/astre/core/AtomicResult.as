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

package astre.core  
{
	import astre.core.Test;
	import astre.core.TestDescription;
	import astre.core.TestError;

/**
 * An <code class="prettyprint">AtomicResult</code> object holds information 
 * about an entity object that has been executed and has generated a result.
 * 
 * <p>An entity can be either a whole test or a single process of a test.</p>
 * 
 * <p>Generally, you do not create 
 * <code class="prettyprint">AtomicResult</code> yourself. Instead, you will 
 * often access them through 
 * <code class="prettyprint">astre.runner.Result</code> objects or through 
 * the <code class="prettyprint">ITestListener.testEnd()</code> method.<br/>
 * For example :</p>
 * <pre class="prettyprint">
 * 
 * var results:Array = myTestRunner.results.toArray();
 * 
 * for each (var atomicResult:AtomicResult in results)
 * {
 * 		trace(atomicResult.toResultString());
 * }
 * 
 * </pre>
 * 
 * 
 * @see astre.runner.Result
 * @see astre.processor.TestProcessor
 * @see astre.processor.ITestProcess
 * @see EResultType
 * @see TestDescription
 * 
 * @author lunar
 * 
 */
public class AtomicResult 
{
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	/**
	 * The type of the result.
	 * 
	 * @default null
	 */
	public var type:EResultType;
	
	/**
	 * The error that comes with this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * 
	 * @default null
	 */
	public var error:TestError;
	
	/**
	 * The description of the test 
	 * that was run and has generated a result.
	 * 
	 * @default null
	 */
	public var testDescription:TestDescription;
	
	/**
	 * The total time to run the entity that generated this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * 
	 * @default 0
	 */
	public var runtime:int;
	
	/**
	 * The total memory variation noticed while running the 
	 * entity that generated this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * 
	 * @default 0
	 */
	public var memoryVariation:Number;
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param type The type of the result.
	 * @param testDescription The description of the test 
	 * that is related to this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * @param error The error that comes with this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * @param runtime The total time to run the 
	 * entity related to this 
	 * <code class="prettyprint">AtomicResult</code>.
	 * @param memoryVariation The total memory variation 
	 * noticed while running the 
	 * entity related to this 
	 * <code class="prettyprint">AtomicResult</code>
	 */
	public function AtomicResult(
							type:EResultType, 
							testDescription:TestDescription, 
							error:TestError = null, 
							runtime:int = 0, 
							memoryVariation:Number = 0
						) 
	{
		super();
		this.type = type;
		this.testDescription = testDescription;
		this.error = error;
		this.runtime = runtime;
		this.memoryVariation = memoryVariation;
	}
	
	/**
	 * Merges this <code class="prettyprint">AtomicResult</code> with 
	 * the specified <code class="prettyprint">AtomicResult</code>.
	 * The worst result of those two 
	 * <code class="prettyprint">AtomicResult</code> is kept, while adding up 
	 * memory variation and runtime values.
	 * The seriousness is given by the ordinal value of the 
	 * <code class="prettyprint">EResultType</code> enumeration constant.
	 * Higher ordinal values represent more serious results than lower values.
	 * 
	 * @param otherResult the 
	 * <code class="prettyprint">AtomicResult</code> 
	 * to merge with this one.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var result:AtomicResult = new AtomicResult(EResultType.FAILURE, null);
	 * 
	 * result.worstMerge(new AtomicResult(EResultType.PASSED, null));
	 * // output : failure
	 * trace(result);
	 * 
	 * result.worstMerge(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
	 * // output : unexpectedError
	 * trace(result);
	 * </pre>
	 * 
	 * @see EResultType
	 */
	public function worstMerge(otherResult:AtomicResult):void
	{
		if (this.type.compareTo(otherResult.type) < 0)
		{
			this.type = otherResult.type;
			this.error = otherResult.error;
		}
		this.runtime += otherResult.runtime;
		this.memoryVariation += otherResult.memoryVariation;
	}
	
	/**
	 * Returns a clone of this <code class="prettyprint">AtomicResult</code>.
	 * @return a clone of this <code class="prettyprint">AtomicResult</code>.
	 */
	public function clone():AtomicResult
	{
		return new AtomicResult(
			this.type, 
			this.testDescription, 
			this.error, 
			this.runtime, 
			this.memoryVariation
		);
	}
	
	/**
	 * Merges this <code class="prettyprint">AtomicResult</code> with 
	 * the specified <code class="prettyprint">AtomicResult</code>.
	 * The best result of those two 
	 * <code class="prettyprint">AtomicResult</code> is kept, while adding up 
	 * memory variation and runtime values.
	 * The seriousness is given by the ordinal value of the 
	 * <code class="prettyprint">EResultType</code> enumeration constant.
	 * Higher ordinal values represent more serious results than lower values.
	 * 
	 * @param otherResult the 
	 * <code class="prettyprint">AtomicResult</code> 
	 * to merge with this one.
	 * 
	 * @example
	 * <pre class="prettyprint">
	 * var result:AtomicResult = new AtomicResult(EResultType.FAILURE, null);
	 * 
	 * result.bestMerge(new AtomicResult(EResultType.UNEXPECTED_ERROR, null));
	 * // output : failure
	 * trace(result);
	 * 
	 * result.bestMerge(new AtomicResult(EResultType.PASSED, null));
	 * // output : passed
	 * trace(result);
	 * </pre>
	 * 
	 */
	public function bestMerge(otherResult:AtomicResult):void
	{
		if (this.type.compareTo(otherResult.type) > 0)
		{
			this.type = otherResult.type;
			this.error = otherResult.error;
		}
		this.runtime += otherResult.runtime;
		this.memoryVariation += otherResult.memoryVariation;
	}
	
	/**
	 * Returns a full string representation 
	 * of this <code class="prettyprint">AtomicResult</code>.
	 * 
	 * <p>The returned string has the following pattern :<br/>
	 * 
	 * <blockquote>[<i>result type</i>] <i>test package</i>.
	 * <i>test class name</i>.<i>test method name</i>()<br/>
	 * <i>Error name</i> : <i>Error message</i><br/>
	 * Tester : <i>tester message</i> (optional line)
	 * </blockquote>
	 * 
	 * </p>
	 * 
	 * @return a full string representation 
	 * of this <code class="prettyprint">AtomicResult</code>.
	 */
	public function toResultString():String
	{
		var str:String = "";
		str = this.toString();
		if (this.error != null)
		{
			str = str.concat("\n"+error.message+" : \n"+getPertinentErrorStackTrace());
			var testerMessage:String = this.error.getTesterMessage();
			if (testerMessage != null && 
				testerMessage != "")
			{
				str = str.concat("\n\t Tester : "+testerMessage);
			}
		}
		return str;
	}
	
	/**
	 * Returns only pertinent lines from the error stacktrace. 
	 * Stack traces that are internal to astre are removed.
	 * 
	 * @return only pertinent lines from the error stacktrace. 
	 * Stack traces that are internal to astre are removed.
	 */
	public function getPertinentErrorStackTrace():String
	{
		var stackTrace:String = this.error.getStackTrace();
		if (stackTrace != null)
		{
			var lines:Array = stackTrace.split("\n");
			var pertinentLines:Array = lines.filter(filterStackTracesLines);
			return pertinentLines.join("\n");
		}
		else
		{
			return "";
		}
	}
	
	/**
	 * Returns a string representation of 
	 * this <code class="prettyprint">AtomicResult</code>
	 * @return a string representation of 
	 * this <code class="prettyprint">AtomicResult</code>
	 */
	public function toString():String
	{
		return "["+type.toString().toUpperCase()+"] "+testDescription.getDisplay();
	}
	
	/**
	 * @private
	 */
	private static function filterStackTracesLines(item:String, index:int, array:Array):Boolean
	{
		if (
			item.indexOf("astre.") != -1 || 
			item.indexOf("flash.events::EventDispatcher") != -1
		)
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	
}
	
}
