import '../enum/ansi_output.dart';
import '../enum/edit_method.dart';

/// A String representing an Ansi compliant modifier.
extension type const Ansi._(String code) {
  /// Ansi modifier: Reset to default: 0.
  static const reset = FontModifier(0);

  /// Ansi modifier bold foreground text: 1.
  static const bold = FontModifier(1);

  /// Ansi modifier faint foreground text: 2.
  static const faint = FontModifier(2);

  /// Ansi modifier italic foreground text: 3.
  static const italic = FontModifier(3);

  /// Ansi mofifiers underlined foreground text: 4.
  static const underline = FontModifier(4);

  /// Ansi modifier crossed out foreground text: 9.
  static const crossedOut = FontModifier(9);

  /// Ansi modifier default font: 10.
  static const defaultFont = FontModifier(10);

  /// Ansi modifier default intensity: 12.
  static const defaultIntensity = FontModifier(22);

  /// Ansi color modifier: black foreground: 30.
  static const black = FontModifier(30);

  /// Ansi color modifier: red foreground: 31.
  static const red = FontModifier(31);

  /// Ansi color modifier: green foreground: 32.
  static const green = FontModifier(32);

  /// Ansi color modifier: yellow foreground: 33.
  static const yellow = FontModifier(33);

  /// Ansi color modifier: blue foreground: 34.
  static const blue = FontModifier(34);

  /// Ansi color modifier: magenta foreground: 35.
  static const magenta = FontModifier(35);

  /// Ansi color modifier: cyan foreground: 36.
  static const cyan = FontModifier(36);

  /// Ansi color modifier: grey foreground: 37
  static const grey = FontModifier(37);

  /// Ansi color modifier: default foreground colour: 39.
  static const defaultForeground = FontModifier(39);

  /// Ansi color modifier: black background: 40.
  static const blackBackground = FontModifier(40);

  /// Ansi color modifier: red background: 41
  static const redBackground = FontModifier(41);

  /// Ansi color modifier: green background: 42.
  static const greenBackground = FontModifier(42);

  /// Ansi color modifier: yellow background: 43.
  static const yellowBackground = FontModifier(43);

  /// Ansi color modifier: blue background: 44.
  static const blueBackground = FontModifier(44);

  /// Ansi color modifier: magenta background: 45.
  static const magentaBackground = FontModifier(45);

  /// Ansi color modifier: cyan background: 46.
  static const cyanBackground = FontModifier(46);

  /// Ansi color modifier: white background: 47.
  static const whiteBackground = FontModifier(47);

  /// Ansi color modifier: default background colour: 39.
  static const defaultBackground = FontModifier(39);

  /// Ansi color modifier: bright red foreground: 91.
  static const redBright = FontModifier(91);

  /// Ansi color modifier: bright grey foreground: 90.
  static const greyLight = FontModifier(90);

  /// Ansi color modifier: bright green foreground: 92.
  static const greenBright = FontModifier(92);

  /// Ansi color modifier: bright yellow foreground: 93.
  static const yellowBright = FontModifier(93);

  /// Ansi color modifier: bright blue foreground: 94.
  static const blueBright = FontModifier(94);

  /// Ansi color modifier: bright magenta foreground: 95.
  static const magentaBright = FontModifier(95);

  /// Ansi color modifier: white foreground: 97
  static const whiteBold = FontModifier(97);

  /// Ansi escap sequence left.
  static const escLeft = '\u001B[';

  /// Print this string to visualize the Ansi modifier codes.
  String get debug => Error.safeToString(code);

  /// Set [status] to `false` to globally disable Ansi styling.
  /// (The default value is `true`.)
  ///
  /// Ansi styling may also be disabled from the command line:
  /// ```Console
  /// $ dart <executable> --define=isMonochrome=true
  /// ```
  static AnsiOutput status = bool.fromEnvironment('isMonochrome')
      ? AnsiOutput.disabled
      : AnsiOutput.enabled;
}

/// A [String] representing an Ansi compliant font modifier.
extension type const FontModifier._(String code) implements Ansi {
  /// Ansi escape symbol right.
  static const escRight = 'm';

  /// The separator used when combining several codes.
  static const separator = ';';

  /// A const constructor creating a [FontModifier] from an integer code.
  const new(int code) : code = Ansi.escLeft + '$code' + escRight;

  /// A const constructor combining the font modifying
  /// Ansi codes [first] and [second].
  const new combine(int first, int second)
    : code = first == second
          ? Ansi.escLeft + '$first' + escRight
          : Ansi.escLeft + '$first' + separator + '$second' + escRight;

  FontModifier operator +(FontModifier other) => code == other.code
      ? this
      : FontModifier._(
          Ansi.escLeft + bareCode + separator + other.bareCode + escRight,
        );

  /// Returns the bare modifier code without the left and right
  /// escape characters.
  String get bareCode => code.substring(2, code.indexOf(escRight));
}

/// A [String] representing an Ansi compliant cursor modifier.
extension type const CursorModifier._(String code) implements Ansi {
  /// Write Ansi.cursorUp to stdout to move the
  /// cursor up.
  ///
  /// To move several characters up provide the input parameter `n`.
  const new up([int n = 1]) : code = Ansi.escLeft + '${n}A';

  /// Write Ansi.cursorDown to stdout to move the
  /// cursor down.
  ///
  /// To move several characters down provide the input parameter `n`.
  const new down([int n = 1]) : code = Ansi.escLeft + '${n}B';

  /// Write Ansi.cursorForward to stdout to move the
  /// cursor forward.
  ///
  /// To move several characters forward provide the input parameter `n`.
  const new forward([int n = 1]) : code = Ansi.escLeft + '${n}C';

  /// Write Ansi.cursorBack to stdout to move the
  /// cursor back.
  ///
  /// To move several character back provide the input parameter `n`.
  const new back([int n = 1]) : code = Ansi.escLeft + '${n}D';

  /// Write Ansi.cursorNextLine to stdout to move the
  /// cursor to the next line.
  ///
  /// To move several lines provide the input parameter `n`.
  const new nextLine([int n = 1]) : code = Ansi.escLeft + '${n}E';

  /// Write `Ansi.cursorPreviousLine()` to stdout to move the
  /// cursor to the beginning of the previous line.
  ///
  /// To move several lines provide the input parameter `n`.
  const new previousLine([int n = 1]) : code = Ansi.escLeft + '${n}F';

  /// Write Ansi.cursorToColumn to stdout to move the
  /// cursor to the column [n].
  const new toColumn(int n) : code = Ansi.escLeft + '${n}G';

  const new toPosition({required int row, required int column})
    : code = Ansi.escLeft + '$row;${column}H';

  /// Returns the bare code without the left escape symbol.
  String get bareCode => code.substring(2);
}

extension AnsiModifier on String {
  /// Applies an Ansi compliant modifier to a string and returns it.
  /// * Returns the string unmodified if [Ansi.status] is set to
  ///  [AnsiOutput.disabled].
  /// * The optional parameter [editMethod] accepts the enum values: <br/>
  ///   [EditMethod.add], [EditMethod.addToExisting], [EditMethod.clearExisting],
  ///   <br/>[EditMethod.replaceAll], and [EditMethod.replaceFirst].
  /// ```Dart
  /// // Usage
  /// final example = 'blueberry'.style(Ansi.blueBright) + ' and ' +
  /// 'green apple'.style(Ansi.greenBright + Ansi.italic);
  /// ```
  String style(FontModifier ansi, {EditMethod editMethod = EditMethod.add}) =>
      isEmpty || Ansi.status == AnsiOutput.disabled
      ? this
      : switch (editMethod) {
          EditMethod.add => ansi.code + this + Ansi.reset.code,
          EditMethod.addToExisting => _replace(ansi, (existing) {
            return existing + ansi;
          }),
          EditMethod.clearExisting =>
            ansi == Ansi.reset
                ? clearStyle()
                : ansi.code + clearStyle() + '${Ansi.reset}',
          EditMethod.replaceFirst => replaceFirst(matchNonReset, ansi.code),
          EditMethod.replaceAll => replaceAll(matchNonReset, ansi.code),
        };

  /// Searches for strings representing a [FontModifier] and replaces them
  /// with [ansi].
  /// * The function [callback] can be used to merge the existing
  ///   modifier with [ansi].
  /// * By default the modifier [Ansi.reset] is skipped. To include this
  /// modifier set [includeReset] to `true`.
  String _replace(
    FontModifier ansi,
    FontModifier Function(FontModifier existingCode) callback, {
    bool includeReset = false,
  }) {
    final regex = includeReset ? matchAll : matchNonReset;
    final b = StringBuffer();
    int currentPosition = 0;

    final matches = regex.allMatches(this);

    for (final match in matches) {
      b.write(
        substring(currentPosition, match.start),
      ); // Part of string before modifier
      b.write(callback(FontModifier._(match.group(0)!))); // Modifier
      currentPosition = match.end;
    }
    b.write(substring(currentPosition)); // Remaining string
    return b.toString();
  }

  /// Regular expression matching a [FontModifier] modifier.
  /// ```
  /// // Usage
  /// final matches = matchAnsi.match(this);
  /// final bareCode = match[]
  /// ```
  static final matchNonReset = RegExp(
    r'\u001B\[(?!0m)((?:\d+;)*\d+)m',
    unicode: true,
  );

  static final matchAll = RegExp(r'\u001B\[((?:\d+;)*\d+)m', unicode: true);

  /// Removes all Ansi modifiers and returns the resulting string.
  String clearStyle() {
    return isEmpty ? this : replaceAll(matchAll, '');
  }

  String get debug => Error.safeToString(this);
}
