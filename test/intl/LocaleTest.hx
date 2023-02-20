package intl;

/** Tests the features of the `Locale` class. **/
@:asserts final class LocaleTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `displayLanguage` property. **/
	@:variant("en-US", "English")
	@:variant("fr-FR", "français")
	@:variant("pt-BR", "português")
	public function testDisplayLanguage(input: String, output: String)
		return assert(new Locale(input).displayLanguage == output);

	/** Tests the `displayRegion` property. **/
	@:variant("en-US", "United States")
	@:variant("fr-FR", "France")
	@:variant("pt-BR", "Brasil")
	public function testDisplayRegion(input: String, output: String)
		return assert(new Locale(input).displayRegion == output);

	/** Tests the `language` property. **/
	@:variant("en-US", "en")
	@:variant("fr-FR", "fr")
	@:variant("pt-BR", "pt")
	public function testLanguage(input: String, output: String)
		return assert(new Locale(input).language == output);

	/** Tests the `region` property. **/
	@:variant("en-US", "US")
	@:variant("fr-FR", "FR")
	@:variant("pt-BR", "BR")
	public function testRegion(input: String, output: String)
		return assert(new Locale(input).region == output);

	/** Tests the `getDisplayLanguage()` method. **/
	@:variant("en", "English", "anglais")
	@:variant("fr", "French", "français")
	@:variant("pt", "Portuguese", "portugais")
	public function testGetDisplayLanguage(input: String, english: String, french: String) {
		asserts.assert(new Locale("en-US").getDisplayLanguage(input) == english);
		asserts.assert(new Locale("fr-FR").getDisplayLanguage(input) == french);
		return asserts.done();
	}

	/** Tests the `getDisplayRegion()` method. **/
	@:variant("US", "United States", "États-Unis")
	@:variant("FR", "France", "France")
	@:variant("BR", "Brazil", "Brésil")
	public function testGetDisplayRegion(input: String, english: String, french: String) {
		asserts.assert(new Locale("en-US").getDisplayRegion(input) == english);
		asserts.assert(new Locale("fr-FR").getDisplayRegion(input) == french);
		return asserts.done();
	}

	/** Tests the `toString()` method. **/
	@:variant("en-US")
	@:variant("fr-FR")
	@:variant("pt-BR")
	public function testToString(value: String)
		return assert(new Locale(value).toString() == value);
}
