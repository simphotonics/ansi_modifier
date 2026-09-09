import 'dart:io';

import 'package:ansi_modifier/ansi_modifier.dart';

void main(List<String> args) async {
  // Emit a periodic stream
  final stream = Stream<String>.periodic(
    const Duration(milliseconds: 500),
    (i) =>
        'Progress timer: '.style(Ansi.grey) +
        ('${i * 500 / 1000} s').style(Ansi.greenBright),
  );
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
