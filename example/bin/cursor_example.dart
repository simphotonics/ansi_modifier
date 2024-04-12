import 'dart:io';

import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  print('Moving the cursor:');

  stdout.write('Hello world!');
  stdout.write(Ansi.cursorToColumn(1));
  stdout.write('Say Hi to the ' + 'moon'.style(Ansi.yellow) + '!');
  stdout.write(Ansi.cursorForward(10));
  stdout.write('Hi there.');
  print('');
}
