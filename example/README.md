# Ansi Modifier - Example
[![Dart](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/ansi_modifier/actions/workflows/dart.yml)

## Usage
The example below shows how the to add, modify, and clear Ansi modifiers.

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

## Features and bugs

If some Ansi modifiers are missing please file an enhancement request
at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/doc/api/ansi_modifier/Ansi-class.html

[modify]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/modify.html

[clearAnsi]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/asyncGroup.html
