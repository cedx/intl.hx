package intl;

/** Tests the features of the `Region` class. **/
@:asserts final class RegionTest {

	/** Creates a new test. **/
	public function new() {}

	#if (java || php)
	/** Tests the `all` property. **/
	public function testAll() {
		final regions = Region.all;
		asserts.assert(regions.length > 200 && regions.length < 300);
		asserts.assert(regions.shift() == "AD");
		asserts.assert(regions.pop() == "ZW");
		return asserts.done();
	}
	#end

	/** Tests the `getDisplayName()` method. **/
	@:variant("de", "Frankreich")
	@:variant("en", "France")
	@:variant("es", "Francia")
	@:variant("fr", "France")
	@:variant("it", "Francia")
	@:variant("pt", "França")
	public function testGetDisplayName(input: String, output: String)
		return assert(new Region("FR").getDisplayName(input) == output);
}
