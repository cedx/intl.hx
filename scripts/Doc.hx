//! --class-path src --library tink_core
import intl.Version;
import sys.FileSystem;
import sys.io.File;
using Lambda;

/** Builds the documentation. **/
function main() {
	["CHANGELOG.md", "LICENSE.md"].iter(file -> File.copy(file, 'docs/${file.toLowerCase()}'));
	if (FileSystem.exists("docs/api")) Tools.removeDirectory("docs/api");

	Sys.command("haxe --define doc-gen --no-output --xml var/api.xml build.hxml");
	Sys.command("lix", ["run", "dox",
		"--define", "description", "Provides a small subset of the International Components for Unicode (ICU), for Haxe.",
		"--define", "source-path", "https://github.com/cedx/intl.hx/blob/main/src",
		"--define", "themeColor", "0xea8220",
		"--define", "version", Version.packageVersion,
		"--define", "website", "https://github.com/cedx/intl.hx",
		"--input-path", "var",
		"--output-path", "docs/api",
		"--title", "ICU for Haxe",
		"--toplevel-package", "intl"
	]);

	File.copy("docs/favicon.ico", "docs/api/favicon.ico");
}
