# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The package provides the class [`Ansi`][Ansi] holding ANSI modifier codes and
the String extension methods [`style`][style] and [`clearStyle`][clearStyle]
for adding, replacing, and removing ANSI modifiers.
It provides Ansi codes for changing the current cursor position.

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

Runnig the program above produces the following output:
![Console Output](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/console_output.gif)


### 2. Moving the Current Cursor Position

Ansi codes for moving the current cursor position can be constructed using the
constructors `.cursorUp`, `.cursorDown`,
`.cursorForward`,
`.cursorBack`,
`.cursorNextLine`,
`.cursorPreviousLine`, and
`.cursorToColumn`.

The example below shows how to change the cursor position
using Dart's `stdout` function `write` in order to display a
progress indicator:

```Dart
import 'dart:io';

import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) async {

  // Emit a periodic stream
  final stream = Stream<String>.periodic(
      const Duration(milliseconds: 500),
      (i) =>
          'Progress timer: '.style(Ansi.grey) +
          ((i * 500 / 1000).toString() + ' s').style(Ansi.green));

  // Listen to the stream and output progress indicator
  final subscription = stream.listen((event) {
    // Place cursor to first column to overwrite previous string.
    stdout.write(Ansi.cursorToColumn(1));
    stdout.write(event);
  });

  /// Add delay ...
  await Future.delayed(Duration(seconds: 5), () {
    print('\n');
    print('After 5 seconds.'.style(Ansi.green));
  });

  await subscription.cancel();
}
```
The program above produces the following console output:
![Progress Indicator](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/progress_indicator.gif)


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
