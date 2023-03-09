package intl;

/** Provides the list of supported units. **/
enum abstract Unit(String) to String {
	var Acre = "acre";
	var Bit = "bit";
	var Byte = "byte";
	var Celsius = "celsius";
	var Centimeter = "centimeter";
	var Day = "day";
	var Degree = "degree";
	var Fahrenheit = "fahrenheit";
	var FluidOunce = "fluid-ounce";
	var Foot = "foot";
	var Gallon = "gallon";
	var Gigabit = "gigabit";
	var Gigabyte = "gigabyte";
	var Gram = "gram";
	var Hectare = "hectare";
	var Hour = "hour";
	var Inch = "inch";
	var Kilobit = "kilobit";
	var Kilobyte = "kilobyte";
	var Kilogram = "kilogram";
	var Kilometer = "kilometer";
	var Liter = "liter";
	var Megabit = "megabit";
	var Megabyte = "megabyte";
	var Meter = "meter";
	var Mile = "mile";
	var MileScandinavian = "mile-scandinavian";
	var Milliliter = "milliliter";
	var Millimeter = "millimeter";
	var Millisecond = "millisecond";
	var Minute = "minute";
	var Month = "month";
	var Ounce = "ounce";
	var Percent = "percent";
	var Petabyte = "petabyte";
	var Pound = "pound";
	var Second = "second";
	var Stone = "stone";
	var Terabit = "terabit";
	var Terabyte = "terabyte";
	var Week = "week";
	var Yard = "yard";
	var Year = "year";
}

/** Defines the unit formatting style. **/
enum abstract UnitDisplay(String) to String {

	/** Long formatting. **/
	var Long = "long";

	/** Narrow formatting. **/
	var Narrow = "narrow";

	/** Short formatting. **/
	var Short = "short";
}
