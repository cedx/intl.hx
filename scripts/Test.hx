/** Runs the test suite. **/
function main() for (file in ["java", "js", "php"]) {
	Sys.println('> Testing the "$file" target...');
	Sys.command('haxe test_$file.hxml');
}
