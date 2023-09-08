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
