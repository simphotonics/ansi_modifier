/// Left Ansi escape sequence
const escLeft = '\u001B[';

const escRight = 'm';

/// Ansi reset sequence
const resetSeq = '\u001B[0m';

/// Used to enable/disable Ansi escape sequences to console.
enum AnsiOutput { enabled, disabled }

/// Ansi modifier replacement method.
enum Replace {
  /// Existing Ansi modifiers are left untouched.
  none,

  /// If the [String] starts with an Ansi modifier, the modifier is replaced
  /// with the new modifier. Otherwise the new modifier is applied.
  starting,

  /// The first encountered Ansi modifier is replaced with the new modifier.
  /// If the string does not contain an Ansi modifier it is returned unchanged.
  first,

  /// All existing Ansi modifiers are removed and the new Ansi
  /// modifier is applied.
  clearPrevious,
}

/// Class representing Ansi modifiers.
///
/// Used to print custom fonts and colorized output to Ansi compliant terminals.
final class Ansi {
  /// Ansi modifier: Reset to default.
  static const reset = Ansi._('0');

  /// Ansi modifier bold foreground text.
  static const bold = Ansi._('1');

  /// Ansi modifier faint foreground text.
  static const faint = Ansi._('2');

  /// Ansi modifier italic foreground text.
  static const italic = Ansi._('3');

  /// Ansi mofifiers underlined foreground text.
  static const underline = Ansi._('4');

  /// Ansi modifier crossed out foreground text.
  static const crossedOut = Ansi._('9');

  /// Ansi modifier default font.
  static const defaultFont = Ansi._('10');

  /// Ansi modifier default intensity.
  static const defaultIntensity = Ansi._('22');

  /// Ansi color modifier: black foreground.
  static const black = Ansi._('30');

  /// Ansi color modifier: red foreground.
  static const red = Ansi._('31');

  /// Ansi color modifier: green foreground.
  static const green = Ansi._('32');

  /// Ansi color modifier: yellow foreground.
  static const yellow = Ansi._('33');

  /// Ansi color modifier: blue foreground.
  static const blue = Ansi._('34');

  /// Ansi color modifier: magenta foreground.
  static const magenta = Ansi._('35');

  /// Ansi color modifier: magenta bold foreground.
  static const magentaBold = Ansi._('1;35');

  /// Ansi color modifier: cyan foreground.
  static const cyan = Ansi._('36');

  /// Ansi color modifier: cyan bold text.
  static const cyanBold = Ansi._('1;36');

  /// Ansi color modifier: grey foreground
  static const grey = Ansi._('2;37');

  /// Ansi color modifier: default foreground colour.
  static const defaultFg = Ansi._('39');

  /// Ansi color modifier: black background
  static const blackBg = Ansi._('40');

  /// Ansi color modifier: red backgroound
  static const redBg = Ansi._('41');

  /// Ansi color modifier: green background
  static const greenBg = Ansi._('42');

  /// Ansi color modifier: yellow background
  static const yellowBg = Ansi._('43');

  /// Ansi color modifier: blue background
  static const blueBg = Ansi._('44');

  /// Ansi color modifier: magenta background
  static const magentaBg = Ansi._('45');

  /// Ansi color modifier: cyan background
  static const cyanBg = Ansi._('46');

  /// Ansi color modifier: white background
  static const whiteBg = Ansi._('47');

  /// Ansi color modifier: default background colour.
  static const defaultBg = Ansi._('39');

  /// Ansi color modifier: bright red foreground.
  static const redBright = Ansi._('91');

  /// Ansi color modifier: bright green foreground.
  static const greenBright = Ansi._('92');

  /// Ansi color modifier: bright yellow foreground.
  static const yellowBright = Ansi._('93');

  /// Ansi color modifier: bright blue foreground.
  static const blueBright = Ansi._('94');

  /// Ansi color modifier: bright magenta foreground.
  static const magentaBright = Ansi._('95');

  /// Ansi color modifier: grey bold foreground
  static const greyBold = Ansi._('1;90');

  /// Ansi color modifier: white bold foreground
  static const whiteBold = Ansi._('1;97');

  const Ansi._(this.bareCode) : code = escLeft + bareCode + escRight;

  /// Write Ansi.cursorUp to stdout to move the
  /// cursor up.
  ///
  /// To move several characters up provide the input parameter `n`.
  const Ansi.cursorUp([int n = 1])
      : code = escLeft + '${n}A',
        bareCode = 'A';

  /// Write Ansi.cursorDown to stdout to move the
  /// cursor down.
  ///
  /// To move several characters down provide the input parameter `n`.
  const Ansi.cursorDown([int n = 1])
      : code = escLeft + '${n}B',
        bareCode = 'B';

  /// Write Ansi.cursorForward to stdout to move the
  /// cursor forward.
  ///
  /// To move several characters forward provide the input parameter `n`.
  const Ansi.cursorForward([int n = 1])
      : code = escLeft + '${n}C',
        bareCode = 'C';

  /// Write Ansi.cursorBack to stdout to move the
  /// cursor back.
  ///
  /// To move several character back provide the input parameter `n`.
  const Ansi.cursorBack([int n = 1])
      : code = escLeft + '${n}D',
        bareCode = 'D';

  /// Write Ansi.cursorNextLine to stdout to move the
  /// cursor to the next line.
  ///
  /// To move several lines provide the input parameter `n`.
  const Ansi.cursorNextLine([int n = 1])
      : code = escLeft + '${n}E',
        bareCode = 'E';

  /// Write `Ansi.cursorPreviousLine()` to stdout to move the
  /// cursor to the beginning of the previous line.
  ///
  /// To move several lines provide the input parameter `n`.
  const Ansi.cursorPreviousLine([int n = 1])
      : code = escLeft + '${n}F',
        bareCode = 'F';

  /// Write Ansi.cursorToColumn to stdout to move the
  /// cursor to the column [n].
  const Ansi.cursorToColumn(int n)
      : code = escLeft + '${n}G',
        bareCode = 'G';

  /// Factory constructor combining several Ansi modifiers.
  factory Ansi.combine(Set<Ansi> modifiers) {
    // Extract modifiers:
    final bareCodes = (modifiers
            .map<String>((element) => element.bareCode)
            .join(';')
            .split(';')
          ..sort())
        .toSet()
        .join(';');

    return Ansi._(bareCodes);
  }

  /// Returns the escaped Ansi code.
  /// ```
  /// print(Ansi.red.code); // Prints \u001B[31m
  /// ```
  final String code;

  /// Returns the bare Ansi code.
  /// ```
  /// print(Ansi.red.bareCode); // Prints 31
  /// ```
  final String bareCode;

  /// Creates a new Ansi object by joining the bare Ansi codes separated by a
  /// semicolon character.
  Ansi operator +(Ansi other) =>
      this == other ? this : Ansi.combine({this, other});

  /// Returns `true` if [other] is of type [Ansi] and
  /// `bareCode == other.bareCode`. Returns `false` otherwise.
  bool operator ==(Object other) {
    if (other is Ansi) {
      return bareCode == other.bareCode;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => bareCode.hashCode;

  @override
  String toString() {
    return code;
  }

  /// Set [status] to `false` to globally disable Ansi styling.
  /// By default [status] is `true`.
  ///
  ///
  /// To disable Ansi styling when running a Dart script use the
  /// command line option:
  /// ```
  /// dart --define=isMonochrome=true
  /// ```
  static AnsiOutput status = bool.fromEnvironment(
    'isMonochrome',
  )
      ? AnsiOutput.disabled
      : AnsiOutput.enabled;
}

extension AnsiModifier on String {
  /// Applies an Ansi compliant modifier to the string and returns it.
  ///
  /// Note: Returns the string unmodified if [Ansi.status] is set to
  /// [AnsiOutput.disabled].
  ///
  ///
  ///
  /// Usage:
  /// ```Dart
  /// var message = 'The ' + 'grass'.style(Ansi.green + Ansi.italic);
  /// // message: 'The \u001B[3;32mgrass\u001B[0m';
  /// message = message.style(Ansi.yellow, method: Replace.first);
  /// // message: 'The \u001B[33mgrass\u001B[0m;
  /// message = message.style(Ansi.bold);
  /// // message = '\u001B[1mThe \u001B[33mgrass\u001B[0m;
  /// ```
  String style(
    Ansi modifier, {
    Replace method = Replace.starting,
  }) =>
      isEmpty
          ? this
          : switch ((Ansi.status, method)) {
              (AnsiOutput.disabled, _) => this,
              (AnsiOutput.enabled, Replace.first) =>
                replaceFirst(matchAnsi, modifier.code),
              (AnsiOutput.enabled, Replace.starting) => startsWith(escLeft)
                  ? replaceFirst(
                      matchAnsi,
                      modifier.code,
                    )
                  : (modifier.code + this)._appendReset,
              (AnsiOutput.enabled, Replace.none) =>
                (modifier.code + this)._appendReset,
              (AnsiOutput.enabled, Replace.clearPrevious) =>
                modifier == Ansi.reset
                    ? clearStyle()
                    : modifier.code + clearStyle() + resetSeq,
            };

  /// Returns the string unmofified if `this` ends with [resetSeq]. Otherwise
  /// appends [resetSeq] and returns the resulting string.
  String get _appendReset => endsWith(resetSeq) ? this : this + resetSeq;

  /// Regular expression matching an Ansi modifier.
  static final matchAnsi = RegExp(r'\u001B\[(\d+|;)+m', unicode: true);

  /// Removes all Ansi modifiers and returns the resulting string.
  String clearStyle() {
    return isEmpty ? this : replaceAll(matchAnsi, '');
  }
}
