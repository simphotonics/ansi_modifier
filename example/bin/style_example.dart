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
