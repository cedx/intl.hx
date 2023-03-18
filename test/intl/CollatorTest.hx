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
}
