// Lesson 3 · Dart basics: variables, types and null safety
//
// Run it:   dart run dart_basics/03_variables.dart
// Or paste the whole file into https://dartpad.dev and press Run.

void main() {
  // --- Variables and types ---------------------------------------------

  // A String holds text.
  String name = 'Amina';

  // An int holds a whole number. We keep naira amounts as whole numbers.
  int lunch = 2500;

  // A double holds a number with a decimal point.
  double dollarRate = 0.00065;

  // A bool is either true or false.
  bool isPaid = true;

  print(name);
  print(lunch);
  print(dollarRate);
  print(isPaid);

  // --- var: let Dart work out the type ---------------------------------

  var transport = 1500; // Dart knows this is an int.
  transport = 1800; // We can change it...
  // transport = 'eighteen hundred'; // ...but not to a different type.

  // --- final and const: values that never change -----------------------

  final today = DateTime.now(); // Decided when the program runs.
  const currencySymbol = '₦'; // Decided before the program runs.
  // currencySymbol = '\$'; // Error: a const can't be changed.

  // --- Doing maths -------------------------------------------------------

  int total = lunch + transport;
  print('Total: $total'); // Total: 4300

  int left = 10000 - total;
  print('Left from ₦10,000: $left'); // 5700

  double inDollars = total * dollarRate;
  print('In dollars: ${inDollars.toStringAsFixed(2)}');

  // --- Putting values inside text (string interpolation) ---------------

  // $name puts a variable in the text. ${...} puts in any expression.
  print('$name spent $currencySymbol$total today.');
  print('That is ${total > 5000 ? 'a lot' : 'not bad'}.');
  print('Today is ${today.day}/${today.month}/${today.year}.');

  // --- Null safety -------------------------------------------------------

  // A normal variable can never be null. Dart checks this for you.
  String category = 'Food';
  // category = null; // Error.

  // Add a ? to the type when a value is allowed to be missing.
  // noteFor (at the bottom of this file) gives back null when there's no note.
  String? note = noteFor('Suya');
  print(note); // null

  // ?? means "use this instead if it's null".
  print(note ?? 'No note');

  // Check for null first, and Dart lets you use it safely.
  if (note != null) {
    print(note.length);
  }

  note = 'Bought from Mama Nkechi';
  print(note.length); // Dart knows note isn't null any more.

  // ?. means "only do this if it's not null".
  String? riceNote = noteFor('Rice');
  String? garriNote = noteFor('Garri');
  print(riceNote?.length); // 28
  print(garriNote?.length); // null, instead of a crash.

  // Turning text into a number can fail, so int.tryParse gives you an int?.
  int? typed = int.tryParse('2500');
  int? badlyTyped = int.tryParse('two thousand');
  print(typed); // 2500
  print(badlyTyped); // null

  print('$category: ${typed ?? 0}');
}

// Gives back a note for some items, and null for the rest.
String? noteFor(String item) {
  if (item == 'Rice') return 'Bought in bulk at the market';
  return null;
}
