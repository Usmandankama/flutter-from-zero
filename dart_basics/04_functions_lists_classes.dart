// Lesson 4 · Dart basics: functions, classes and lists
//
// Run it:   dart run dart_basics/04_functions_lists_classes.dart
// Or paste the whole file into https://dartpad.dev and press Run.

// --- Functions ------------------------------------------------------------

// A function is a named set of instructions you can use again and again.
// The int before the name is the type of answer it gives back.
// a and b are its parameters: the values you hand it.
int addUp(int a, int b) {
  return a + b;
}

// A function that fits on one line can use => instead of { return ...; }.
int multiply(int a, int b) => a * b;

// --- Classes ---------------------------------------------------------------

// A class is a blueprint for your own type. Every Person has a name and an age.
class Person {
  // Fields: the data each person carries.
  String name;
  int age;

  // The constructor: this.name stores the name you pass in, this.age the age.
  Person(this.name, this.age);

  // A method: a function that belongs to the class.
  void sayHello() {
    print("Hello, my name is $name and I am $age years old.");
  }
}

// Everything runs from main. Keep functions and classes outside it.
void main() {
  // --- Calling functions -------------------------------------------------

  int num1 = 5;
  int num2 = 10;

  int sum = addUp(num1, num2);
  print("The sum of $num1 and $num2 is: $sum"); // The sum of 5 and 10 is: 15

  // Use it again, this time passing the values directly.
  var total = addUp(30, 20);
  print("The total of 30 and 20 is: $total"); // The total of 30 and 20 is: 50

  int product = multiply(num1, num2);
  print(product); // 50

  // --- Making objects ----------------------------------------------------

  // Each Person made from the class is called an object.
  Person person = Person("Alice", 30);
  Person person2 = Person("Bob", 25);

  print("Name: ${person.name}, Age: ${person.age}"); // Name: Alice, Age: 30
  print("Name: ${person2.name}, Age: ${person2.age}"); // Name: Bob, Age: 25

  // The method saves typing the same print for every person.
  person.sayHello(); // Hello, my name is Alice and I am 30 years old.
  person2.sayHello(); // Hello, my name is Bob and I am 25 years old.

  // --- Lists: many values in order ---------------------------------------

  List<int> numbers = [1, 2, 3, 4, 5];
  print(numbers); // [1, 2, 3, 4, 5]

  numbers.add(6); // add puts a new value at the end.
  print(numbers); // [1, 2, 3, 4, 5, 6]
  print(numbers.length); // 6

  // remove takes out the value 3 (not the item at position 3).
  numbers.remove(3);
  print(numbers); // [1, 2, 4, 5, 6]

  // A list can hold any type. This one holds Strings.
  List<String> fruits = ["Apple", "Banana", "Orange"];
  print(fruits); // [Apple, Banana, Orange]
  print(fruits.length); // 3
}
