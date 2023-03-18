package intl;

import intl.Collator.CollatorStrength;

/** Tests the features of the `Collator` class. **/
final class CollatorTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `compare()` method. **/
	@:variant("a", "b", Primary, -1)
	@:variant("a", "à", Primary, 0)
	@:variant("a", "A", Primary, 0)
	@:variant("a", "b", Secondary, -1)
	@:variant("a", "à", Secondary, -1)
	@:variant("a", "A", Secondary, 0)
	@:variant("a", "b", Tertiary, -1)
	@:variant("a", "à", Tertiary, #if js 0 #else -1 #end)
	@:variant("a", "A", Tertiary, -1)
	@:variant("a", "b", Identical, -1)
	@:variant("a", "à", Identical, -1)
	@:variant("a", "A", Identical, -1)
	public function testCompare(source: String, target: String, strength: CollatorStrength, output: Int)
		return assert(new Collator("fr-FR", {strength: strength}).compare(source, target) == output);

	/** Tests the `sort()` method. **/
	@:variant(["à", "b", "A"], Primary, #if java ["A", "à", "b"] #else ["à", "A", "b"] #end)
	@:variant(["à", "b", "A"], Secondary, ["A", "à", "b"])
	@:variant(["à", "b", "A"], Tertiary, #if js ["à", "A", "b"] #else ["A", "à", "b"] #end)
	@:variant(["à", "b", "A"], Identical, ["A", "à", "b"])
	public function testSort(input: Array<String>, strength: CollatorStrength, output: Array<String>) {
		new Collator("fr-FR", {strength: strength}).sort(input);
		return compare(output, input);
	}
}
