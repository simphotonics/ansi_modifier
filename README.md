# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The extension type [`Ansi`][Ansi] provides ANSI escape codes and helper functions
which can be used to modify the font style of console output.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
in your `pubspec.yaml` file.


### 1. Changing the Font Style and Colour of Console Output

Ansi escape codes for changing the colour and font style are of
type [`FontModifier`][FontModifier]. They are available as
constant static values of their supertype [`Ansi`][Ansi]:
```Dart
final s = 'The ${Ansi.red}fox${Ansi.reset} jumps over the
  ${Ansi.green}fence${Ansi.reset};
```
It is advisable to terminate styled strings with an Ansi code that
resets the font style to the default style.

To make this easier, the package provides the String extension function
[`style`][style] to *add* new modifiers or
to *replace* existing ones. Using the function [`style][style] has the
additional benefit of being able to globally disable the output of font
modifying Ansi escape codes ( see section (#tips-and-tricks)).

The function [`clearStyle`][clearStyle] can be used *remove*
all Ansi escape codes of type [`FontModifier][FontModifier] from a string.

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

  // Strip all Ansi modifiers.
  print('\nStrip all Ansi modifiers: clearStyle()'.style(Ansi.underline));
  print(example.clearStyle());
}
```

Runnig the program above produces the following output:
![Console Output](https://github.com/simphotonics/ansi_modifier/raw/main/images/console_output.svg)


### 2. Moving the Current Cursor Position

Ansi escape codes for moving the current cursor position can be constructed
using the constructors
`Ansi.cursorUp`,
`Ansi.cursorDown`,
`Ansi.cursorForward`,
`Ansi.cursorBack`,
`Ansi.cursorNextLine`,
`Ansi.cursorPreviousLine`, and
`Ansi.cursorToColumn`, and `Ansi.cursorToPosition`.

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
![Progress Indicator](https://github.com/simphotonics/ansi_modifier/raw/main/images/progress_indicator.svg)


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

[FontModifier]: https://pub.dev/packages/ansi_modifier/latest/ansi_modifier/FontModifier-class.html

[style]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/style.html

[clearStyle]: https://pub.dev/documentation/ansi_modifier/latest/ansi_modifier/AnsiModifier/clearStyle.html
