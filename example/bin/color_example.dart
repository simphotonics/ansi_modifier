import 'dart:io';

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

  // Create custom Anis modifier
  final customModifier = Ansi.combine({Ansi.yellow, Ansi.bold, Ansi.underline});

  // Replace first modifier:
  final yellowGreen = blueGreen.style(customModifier, method: Replace.first);

  // Replace all modifiers.
  final magenta =
      yellowGreen.style(Ansi.magenta, method: Replace.clearPrevious);

  // Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.clearStyle()}\n');

  print('Moving the cursor:');
  stdout.write('Hello world!');
  stdout.write(Ansi.cursorToColumn(1));
  stdout.write('Say hi to the ' + 'moon'.style(Ansi.yellow) + '!');
  stdout.write(Ansi.cursorForward(10));
  stdout.write('Hi there.');
  print('');
}
