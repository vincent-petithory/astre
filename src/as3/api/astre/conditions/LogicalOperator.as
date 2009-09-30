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

package astre.conditions 
{

/**
 * An enumeration of logical operators that you use to combine 
 * boolean operands.
 * 
 * @see CombinedCondition
 * 
 * @author lunar
 * 
 */
public class LogicalOperator 
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	/**
	 * The logical <code class="prettyprint">OR</code> operator.
	 * 
	 * <p>Here is the truth table of the <code class="prettyprint">OR</code> 
	 * operator :</p>
	 * 
	 * <table class="innertable">
	 *     <tr>
	 * 			<th>A</th>
	 * 			<th>B</th>
	 * 			<th>S</th>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *     </tr>
	 *  </table>
	 * 
	 */
	public static const OR:uint = 10;
	
	/**
	 * The logical <code class="prettyprint">AND</code> operator.
	 * 
	 * <p>Here is the truth table of the <code class="prettyprint">AND</code> 
	 * operator :</p>
	 * 
	 * <table class="innertable">
	 *     <tr>
	 * 			<th>A</th>
	 * 			<th>B</th>
	 * 			<th>S</th>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *			<td><code class="prettyprint">0</code></td>
	 *     </tr>
	 *     <tr>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *			<td><code class="prettyprint">1</code></td>
	 *     </tr>
	 *  </table>
	 * 
	 */
	public static const AND:uint = 11;
	
}
	
}
