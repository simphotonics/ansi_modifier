# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The package provides the class [`Ansi`][Ansi] holding ANSI modifier codes and
the String extension methods [`modify`][modify] and [`removeAnsi`][removeAnsi]
for adding, replacing, and removing ANSI modifiers.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.

Use the String extension function [`modify`][modify] to add new modifiers or
to replace existing ones. Use the function [`removeAnsi`][removeAnsi] to remove
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
  print('$yellowGreen, $magenta, ${magenta.removeAnsi()}');
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

[removeAnsi]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/removeAnsi.html
