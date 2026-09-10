import 'package:ansi_modifier/ansi_modifier.dart';

void main(List<String> args) {
  // Create colorized strings.
  print('\nStyle string:'.style(Ansi.underline));
  final example =
      'blueberry'.style(Ansi.blueBright) +
      ' and ' +
      'green apple'.style(Ansi.greenBright);
  print(example);

  // Replace first font modifier code
  print(
    '\nReplace first Ansi modifier: EditMethod.replaceFirst'.style(
      Ansi.underline,
    ),
  );
  print(
    example.style(Ansi.yellow + Ansi.bold, editMethod: EditMethod.replaceFirst),
  );

  // Replace all existing font modifier codes.
  print(
    '\nReplace all Ansi modifiers: EditMethod.replaceAll'.style(Ansi.underline),
  );
  print(
    example.style(
      Ansi.redBright + Ansi.bold,
      editMethod: EditMethod.replaceAll,
    ),
  );

  // Clear previous font modifiers and re-style entire string.
  print(
    '\nClear previous modifiers and style entire string: EditMethod.clearExisting'
        .style(Ansi.underline),
  );
  print(example.style(Ansi.magenta, editMethod: EditMethod.clearExisting));

  // Keep existing Ansi modifiers and add styling.
  print(
    '\nAmend existing modifiers: EditMethod.addToExisting'.style(
      Ansi.underline,
    ),
  );
  print(example.style(Ansi.italic, editMethod: EditMethod.addToExisting));

  // Strip all Ansi modifiers.
  print('\nStrip all Ansi modifiers: clearStyle()'.style(Ansi.underline));
  print(example.clearStyle());
}
