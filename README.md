# Ansi Modifier
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Introduction

The extension type [`Ansi`][Ansi] provides ANSI escape codes and helper functions
which can be used to modify the font style of console output and to move the
cursor.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
in your `pubspec.yaml` file.


### 1. Changing the Font Style and Color of Console Output

The easiest way of changing the colour and font style of console output
is by using the String extension method [`style`][style]:
```Dart
final s = 'The ' + 'red'.style(Ansi.red) + ' fox jumps '
  'over the ' + 'green'.style(Ansi.green + Ansi.italic) + ' fence';
print(s);
```
On an Ansi compliant terminal, the code lines above produce the
following console output:
![Console Output](https://github.com/simphotonics/ansi_modifier/raw/main/images/console_output.svg)

The method [`style`][style] supports different
edit modes that can be used to modify existing Ansi escape codes.

<details> <summary> Click to show source code. </summary>

```Dart
import 'package:ansi_modifier/ansi_modifier.dart';

void main(List<String> args) {
  // Create colorized strings.
  print('\nStyle string:'.style(Ansi.underline) + ': EditMethod.add (default)');
  final example =
      'blueberry'.style(Ansi.blueBright) +
      ' and ' +
      'green apple'.style(Ansi.greenBright);
  print(example);

  // Replace first font modifier code
  print(
    '\nReplace first Ansi escape code'.style(Ansi.underline) +
        ': EditMethod.replaceFirst',
  );
  print(
    example.style(Ansi.yellow + Ansi.bold, editMethod: EditMethod.replaceFirst),
  );

  // Replace all existing font modifier codes.
  print(
    '\nReplace all Ansi escape codes'.style(Ansi.underline) +
        ': EditMethod.replaceAll',
  );
  print(
    example.style(
      Ansi.redBright + Ansi.bold,
      editMethod: EditMethod.replaceAll,
    ),
  );

  // Clear previous font modifiers and re-style entire string.
  print(
    '\nClear previous Ansi codes and style entire string'.style(
          Ansi.underline,
        ) +
        ': EditMethod.clearExisting',
  );
  print(example.style(Ansi.magenta, editMethod: EditMethod.clearExisting));

  // Keep existing Ansi escape codes and add styling.
  print(
    '\nAmend existing modifiers'.style(Ansi.underline) +
        ': EditMethod.addToExisting'.style(Ansi.underline),
  );
  print(example.style(Ansi.italic, editMethod: EditMethod.addToExisting));

  // Strip all Ansi escape codes.
  print(
    '\nStrip all Ansi escape codes'.style(Ansi.underline) +
        ': clearStyle()'.style(Ansi.underline),
  );
  print(example.clearStyle());
}
```
</details>

The program above produces the following output:
![Console Output](https://github.com/simphotonics/ansi_modifier/raw/main/images/console_output_style.svg)


Instead of using the convenience method [`style`][style], one can use the
Ansi escape codes that are available as
constant static values of the extension type [`Ansi`][Ansi]:
```Dart
final s = 'The ${Ansi.red}fox${Ansi.reset} jumps over the
  ${Ansi.green}fence${Ansi.reset};
```

It is advisable to terminate styled strings with an Ansi code that
resets the font style to the default style.


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

* The function [`clearStyle`][clearStyle] can be used *remove*
all Ansi escape codes of type [`FontModifier][FontModifier] from a string.
* The String extension method [`style`][style] supports different
replacement modes that can be adjusted using the optional argument `editMethod`.
* Ansi codes can be combined using the addition operator `Ansi.red + Ansi.bold`.
* Using the function [`style][style] to add Ansi codes provides the option of
  globally disabling Ansi output by setting:
  ```Dart
  Ansi.status = AnsiOutput.disabled;
  ```
  When running a Dart script the same effect can be achieved by using the
  the option:
  ```Console
  $ dart --define=isMonochrome=true example/bin/color_example.dart
  ```


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
