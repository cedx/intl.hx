//! --class-path src --library tink_core
import intl.Version;
import sys.FileSystem;
import sys.io.File;

/** Runs the script. **/
function main() {
	if (FileSystem.exists("docs")) Tools.removeDirectory("docs");

	Sys.command("haxe", ["--define", "doc-gen", "--no-output", "--xml", "var/api.xml", "build.hxml"]);
	Sys.command("lix", [
		"run", "dox",
		"--define", "description", "Provides a small subset of the International Components for Unicode (ICU), for Haxe.",
		"--define", "source-path", "https://github.com/cedx/intl.hx/blob/main/src",
		"--define", "themeColor", "0xffc105",
		"--define", "version", Version.packageVersion,
		"--define", "website", "https://github.com/cedx/intl.hx",
		"--input-path", "var",
		"--output-path", "docs",
		"--title", "ICU for Haxe",
		"--toplevel-package", "intl"
	]);

	File.copy("www/favicon.ico", "docs/favicon.ico");
}
