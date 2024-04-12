# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The package provides the class [`Ansi`][Ansi] holding ANSI modifier codes and
the String extension methods [`style`][style] and [`clearStyle`][clearStyle]
for adding, replacing, and removing ANSI modifiers.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.


### 1. Changing the Font Style and Colour of Console Output
Use the String extension function [`style`][style] to add new modifiers or
to replace existing ones. Use the function [`clearStyle`][clearStyle] to remove
all Ansi modifier from a string.

```Dart
import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  // Create colorized strings.
  print('\nCreate colorized strings:');
  final blue = 'blueberry'.style(Ansi.blue + Ansi.italic);
  final green = 'green apple'.style(Ansi.green);
  final blueGreen = blue +
      ' and ' +
      green.style(
        Ansi.bold,
        method: Replace.none,
      );
  print('$blue, $green, $blueGreen');

  // Modify a previously colorized string.
  print('\nModify previously colorized strings:');

  // Create custom Ansi modifier.
  final customModifier = Ansi.combine({Ansi.yellow, Ansi.bold, Ansi.underline});

  // Replace first modifier:
  final yellowGreen = blueGreen.style(customModifier, method: Replace.first);

  // Replace all modifiers.
  final magenta =
      yellowGreen.style(Ansi.magenta, method: Replace.clearPrevious);

  // Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.clearStyle()}\n');
}
```

Runnig the program above:
```Console
$ dart example/bin/color_example.dart
```
produces the following output:

![Console Output](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/console_output.png)


### 2. Moving the Current Cursor Position

Ansi codes for moving the current cursor position can be constructed using the
constructors `.cursorUp`, `.cursorDown`,
`.cursorForward`,
`.cursorBack`,
`.cursorNextLine`,
`.cursorPreviousLine`, and
`.cursorToColumn`.
These codes can be used e.g. to create shell progress indicators and timers.

The example below shows how to change the current cursor position by
using Dart's `stdout` function `write`.

```Dart
import 'dart:io';

import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  print('Moving the cursor:');

  stdout.write('Hello world!');
  stdout.write(Ansi.cursorToColumn(1)); // Moving to the first column.
  stdout.write('Say Hi to the moon!');
  stdout.write(Ansi.cursorForward(10)); // Moving forward by 10 characters.
  stdout.write('Hi there.');
  print('');
}
```
The program above produces the following console output:
```Console
$ dart example/bin/cursor_example.dart
Moving the cursor:
Say Hi to the moon!          Hi there.
```


## Tips and Tricks

* The String extension method [`style`][style] supports different
replacement modes that can be adjusted using the optional argument `method`.

* Ansi codes can be combined using the addition operator `Anis.red + Ansi.bold`,
or by using the factory constructor `Ansi.combine`.

* Ansi output can be globally disabled by setting
`Ansi.status = AnsiOutput.disabled` or by using the option:
  ```Console
  $ dart --define=isMonochrome=true example/bin/color_example.dart

  ```

## Features and bugs

If some Ansi modifiers are missing please file an enhancement request
at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/latest/ansi_modifier/Ansi-class.html

[style]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/style.html

[clearStyle]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/clearStyle.html
