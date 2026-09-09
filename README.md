# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The class [`Ansi`][Ansi] provides ANSI escape codes which can be used to
style and animate console output, and to change to current cursor position.


## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
in your `pubspec.yaml` file.


### 1. Changing the Font Style and Colour of Console Output

Use the String extension function [`style`][style] to *add* new modifiers or
to *replace* existing ones.

Use the function [`clearStyle`][clearStyle] to *remove*
all Ansi modifier from a string.

```Dart

import 'package:ansi_modifier/ansi_modifier.dart';

void main(List<String> args) {
  // Create colorized strings.
  print('\nStyle string:'.style(Ansi.underline));
  final example =
      'blueberry'.style(Ansi.blueBright) +
      ' and ' +
      'green apple'.style(Ansi.greenBright);
  print(example);

  // Replace first font modifier code
  print(
    '\nReplace first Ansi modifier: EditMethod.replaceFirst'.style(
      Ansi.underline,
    ),
  );
  print(
    example.style(Ansi.yellow + Ansi.bold, editMethod: EditMethod.replaceFirst),
  );

  // Replace all existing font modifier codes.
  print(
    '\nReplace all Ansi modifiers: EditMethod.replaceAll'.style(Ansi.underline),
  );
  print(
    example.style(
      Ansi.redBright + Ansi.bold,
      editMethod: EditMethod.replaceAll,
    ),
  );

  // Clear previous font modifiers and re-style entire string.
  print(
    '\nClear previous modifiers and style entire string: EditMethod.clearExisting'
        .style(Ansi.underline),
  );
  print(example.style(Ansi.magenta, editMethod: EditMethod.clearExisting));

  // Keep existing Ansi modifiers and add styling.
  print(
    '\nAmend existing modifiers: EditMethod.addToExisting'.style(
      Ansi.underline,
    ),
  );
  print(example.style(Ansi.italic, editMethod: EditMethod.addToExisting));
  print(example.style(Ansi.underline, editMethod: EditMethod.add));

  // Strip all Ansi modifiers.
  print('\nStrip all Ansi modifiers: clearStyle()'.style(Ansi.underline));
  print(example.clearStyle());
}
```

Runnig the program above produces the following output:
![Console Output](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/console_output.gif)


### 2. Moving the Current Cursor Position

Ansi codes for moving the current cursor position can be constructed using the
constructors `CursorModifier.up`,
`CursorModifier.down`,
`CursorModifier.forward`,
`CursorModifier.back`,
`CursorModifier.nextLine`,
`CursorModifier.previousLine`, and
`CursorModifier.toColumn`, and `CursorModifier.toPosition`.

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
    stdout.write(CursorModifier.toColumn(1));
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
replacement modes that can be adjusted using the optional argument `editMethod`.
* Ansi codes can be combined using the addition operator `Ansi.red + Ansi.bold`.
* Ansi output can be globally disabled by setting
`Ansi.status = AnsiOutput.disabled` or by using the option:
  ```Console
  $ dart --define=isMonochrome=true example/bin/color_example.dart
  ```
  when running a Dart script from the terminal.

## Features and bugs

If Ansi modifiers that are useful to you are missing, you are welcome to
create pull request or raise an enhancement request
at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/latest/ansi_modifier/Ansi-class.html

[style]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/style.html

[clearStyle]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/clearStyle.html
