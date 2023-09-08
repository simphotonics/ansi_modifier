import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
  print('Create colorized strings:'.modify(Ansi.bold));
  final blue = 'A string.'.modify(Ansi.blue);
  print('A blue string:');
  print(blue);

  print('\nA green string:');
  final green = 'Another string'.modify(Ansi.green);
  print(green);

  print('\nA blue green string:');
  final blueGreen = blue + ' ' + green;
  print(blueGreen);

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:'.modify(Ansi.bold));

  /// Replace first modifier:
  final yellowGreen = blueGreen.modify(Ansi.yellow, method: Replace.first);
  print('A yellow green string:');
  print(yellowGreen);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.modify(Ansi.magenta, method: Replace.clearPrevious);
  print('\nA magenta string:');
  print(magenta);

  /// Strip all Ansi modifiers.
  print('\nA standard string:');
  print(magenta.stripAnsi());
}
