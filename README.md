# Ansi Modifier


## Introduction

The package provides the class [`Ansi`][Ansi] holding ANSI modifier codes and
String extension methods for adding, replacing, and removing ANSI modifiers.


## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.

Use the String extension functions [`modify`][modify] to add new modifiers or
to replace existing ones. The replacement method can be adjusted by setting the
optional argument `method`.

Use the function [`stripAnsi`][stripAnsi] to remove
all Ansi modifier from a string.

```Dart
import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
  print('Create colorized strings:');
  final blue = 'blueberry'.modify(Ansi.blue + Ansi.italic);
  final green = 'green apple'.modify(Ansi.green);
  final blueGreen = blue +
      ' and ' +
      green.modify(
        Ansi.bold,
        method: Replace.none,
      );
  print('$blue, $green, $blueGreen');

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:');

  /// Replace first modifier:
  final yellowGreen = blueGreen.modify(Ansi.yellow + Ansi.bold + Ansi.underline,
      method: Replace.first);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.modify(Ansi.magenta, method: Replace.clearPrevious);

  /// Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.stripAnsi()}');
}
```

Runnig the program above:
```Console
$ dart example/bin/color_example.dart
```
produces the following output on a Visual Studio Code terminal:

![Console Output](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/console_output.png)


## Tips and Tricks

* The String extension method [`modify`][modify] supports different
replacement modes that can be adjusted using the optional argument `method`.

* Ansi codes can be combined using the addition operator `Anis.red + Ansi.bold`,
or by using the factory constructor `Ansi.combine`.

## Features and bugs

If some Ansi modifiers are missing please file an enhancement request
at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/doc/api/ansi_modifier/Ansi-class.html

[modify]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/modify.html

[clearAnsi]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/asyncGroup.html
