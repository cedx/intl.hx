package intl;

/** Tests the features of the `Locale` class. **/
@:asserts final class LocaleTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `displayLanguage` property. **/
	@:variant("de-DE", "Deutsch")
	@:variant("en-US", "English")
	@:variant("es-MX", "español")
	@:variant("fr-FR", "français")
	@:variant("it-IT", "italiano")
	@:variant("pt-BR", "português")
	public function testDisplayLanguage(input: String, output: String)
		return assert(new Locale(input).displayLanguage == output);

	/** Tests the `displayRegion` property. **/
	@:variant("de-DE", "Deutschland")
	@:variant("en-US", "United States")
	@:variant("es-MX", "México")
	@:variant("fr-FR", "France")
	@:variant("it-IT", "Italia")
	@:variant("pt-BR", "Brasil")
	public function testDisplayRegion(input: String, output: String)
		return assert(new Locale(input).displayRegion == output);

	/** Tests the `language` property. **/
	@:variant("de-DE", "de")
	@:variant("en-US", "en")
	@:variant("es-MX", "es")
	@:variant("fr-FR", "fr")
	@:variant("it-IT", "it")
	@:variant("pt-BR", "pt")
	public function testLanguage(input: String, output: String)
		return assert(new Locale(input).language == output);

	/** Tests the `region` property. **/
	@:variant("de-DE", "DE")
	@:variant("en-US", "US")
	@:variant("es-MX", "MX")
	@:variant("fr-FR", "FR")
	@:variant("it-IT", "IT")
	@:variant("pt-BR", "BR")
	public function testRegion(input: String, output: String)
		return assert(new Locale(input).region == output);

	/** Tests the `getDisplayLanguage()` method. **/
	@:variant("de", "German", "allemand")
	@:variant("en", "English", "anglais")
	@:variant("es", "Spanish", "espagnol")
	@:variant("fr", "French", "français")
	@:variant("it", "Italian", "italien")
	@:variant("pt", "Portuguese", "portugais")
	public function testGetDisplayLanguage(input: String, english: String, french: String) {
		asserts.assert(new Locale("en-US").getDisplayLanguage(input) == english);
		asserts.assert(new Locale("fr-FR").getDisplayLanguage(input) == french);
		return asserts.done();
	}

	/** Tests the `getDisplayRegion()` method. **/
	@:variant("DE", "Germany", "Allemagne")
	@:variant("US", "United States", "États-Unis")
	@:variant("MX", "Mexico", "Mexique")
	@:variant("FR", "France", "France")
	@:variant("IT", "Italy", "Italie")
	@:variant("BR", "Brazil", "Brésil")
	public function testGetDisplayRegion(input: String, english: String, french: String) {
		asserts.assert(new Locale("en-US").getDisplayRegion(input) == english);
		asserts.assert(new Locale("fr-FR").getDisplayRegion(input) == french);
		return asserts.done();
	}

	/** Tests the `toString()` method. **/
	@:variant("de-DE")
	@:variant("en-US")
	@:variant("fr-FR")
	@:variant("it-IT")
	@:variant("pt-BR")
	public function testToString(value: String)
		return assert(new Locale(value).toString() == value);
}
