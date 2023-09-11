import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
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

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:');

  /// Replace first modifier:
  final customModifier = Ansi.combine({Ansi.yellow, Ansi.bold, Ansi.underline});
  final yellowGreen = blueGreen.style(customModifier, method: Replace.first);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.style(Ansi.magenta, method: Replace.clearPrevious);

  /// Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.clearStyle()}\n');
}
