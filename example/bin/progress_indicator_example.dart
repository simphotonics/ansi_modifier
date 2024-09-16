import 'dart:io';

import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) async {
  final stream = Stream<String>.periodic(
      const Duration(milliseconds: 500),
      (i) =>
          'Progress timer: '.style(Ansi.grey) +
          ((i * 500 / 1000).toString() + ' s').style(Ansi.green));

  final subscription = stream.listen((event) {
    stdout.write(Ansi.cursorToColumn(1));
    stdout.write(event);
  });

  /// Delay cause by expensive numerical operation ...
  await Future.delayed(Duration(seconds: 5), () {
    print('\n');
    print('After 5 seconds.'.style(Ansi.green));
  });

  await subscription.cancel();
}
