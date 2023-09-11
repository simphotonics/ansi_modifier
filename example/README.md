# Ansi Modifier - Example
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Usage
The example below shows how the to add, modify, and clear Ansi modifiers.

```Dart
import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
  print('Create colorized strings:');
  final blue = 'blueberry'.style(Ansi.blue + Ansi.italic);
  final green = 'green apple'.style(Ansi.green);
  final blueGreen = blue +
      ' and ' +
      green.style(
        Ansi.bold,
        method: Replace.none,
      );
  print('$blue, $green, $blueGreen');

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:');

  /// Replace first modifier:
  final yellowGreen = blueGreen.style(Ansi.yellow + Ansi.bold + Ansi.underline,
      method: Replace.first);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.style(Ansi.magenta, method: Replace.clearPrevious);

  /// Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.clearStyle()}');
}
```

## Features and bugs

If some Ansi modifiers are missing please file a enhancement request
at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/doc/api/ansi_modifier/Ansi-class.html

[style]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/style.html

[clearAnsi]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/asyncGroup.html
