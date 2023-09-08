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

/// Enumeration representing Ansi modifiers.
///
/// Used to print custom fonts and colorized output to Ansi compliant terminals.
class Ansi {
  /// Ansi modifier: Reset to default.
  static final reset = Ansi('0');

  /// Ansi modifier bold forground text.
  static final bold = Ansi('1');

  /// Ansi modifier italic foreground text.
  static final italic = Ansi('3');

  /// Ansi mofifiers underlined foreground text.
  static final underline = Ansi('4');

  /// Ansi modifier crossed out foreground text.
  static final crossedOut = Ansi('9');

  /// Ansi color modifier: black foreground.
  static final black = Ansi('30');

  /// Ansi color modifier: red foreground.
  static final red = Ansi('31');

  /// Ansi color modifier: green foreground.
  static final green = Ansi('32');

  /// Ansi color modifier: yellow foreground.
  static final yellow = Ansi('33');

  /// Ansi color modifier: blue foreground.
  static final blue = Ansi('34');

  /// Ansi color modifier: magenta foreground.
  static final magenta = Ansi('35');

  /// Ansi color modifier: magenta bold foreground.
  static final magentaBold = Ansi('1;35');

  /// Ansi color modifier: cyan foreground.
  static final cyan = Ansi('36');

  /// Ansi color modifier: cyan bold text.
  static final cyanBold = Ansi('1;36');

  /// Ansi color modifier: grey foreground
  static final grey = Ansi('2;37');

  /// Ansi color modifier: black background
  static final blackBg = Ansi('40');

  /// Ansi color modifier: red backgroound
  static final redBg = Ansi('41');

  /// Ansi color modifier: green background
  static final greenBg = Ansi('42');

  /// Ansi color modifier: yellow background
  static final yellowBg = Ansi('43');

  /// Ansi color modifier: blue background
  static final blueBg = Ansi('44');

  /// Ansi color modifier: magenta background
  static final magentaBg = Ansi('45');

  /// Ansi color modifier: cyan background
  static final cyanBg = Ansi('46');

  /// Ansi color modifier: white background
  static final whiteBg = Ansi('47');

  /// Ansi color modifier: bright red foreground.
  static final redBright = Ansi('91');

  /// Ansi color modifier: bright green foreground.
  static final greenBright = Ansi('92');

  /// Ansi color modifier: bright yellow foreground.
  static final yellowBright = Ansi('93');

  /// Ansi color modifier: bright blue foreground.
  static final blueBright = Ansi('94');

  /// Ansi color modifier: bright magenta foreground.
  static final magentaBright = Ansi('95');

  /// Ansi color modifier: grey bold foreground
  static final greyBold = Ansi('1;90');

  /// Ansi color modifier: white bold foreground
  static final whiteBold = Ansi('1;97');

  const Ansi(this.bareCode) : code = escLeft + bareCode + escRight;

  /// Factory constructor combining several Ansi modifiers.
  factory Ansi.combine(Set<Ansi> modifiers) {
    return Ansi(modifiers.map<String>((element) => element.bareCode).join(';'));
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
  Ansi operator +(Ansi other) => this == other
      ? this
      : Ansi(
          bareCode + ';' + other.bareCode,
        );

  @override
  String toString() {
    return code;
  }

  /// Used to globally enable/disable color output.
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
  /// Usage:
  /// ```Dart
  /// final message = 'Hello';
  /// final greenMessage = message.modify(Ansi.green);
  /// // greenMessage: '\u001B[32mHello\u001B[0m';
  /// final blueMessage = message.modify(Ansi.blue, method: Replace.starting);
  /// // blueMessage: '\u001B[34mHello\u001B[0m;
  /// ```
  String modify(
    Ansi modifier, {
    Replace method = Replace.starting,
  }) =>
      switch ((Ansi.status, method)) {
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
          modifier.code + stripAnsi() + resetSeq,
      };

  /// Returns the string unmofified if `this` ends with [resetSeq]. Otherwise
  /// appends [resetSeq] and returns the resulting string.
  String get _appendReset => endsWith(resetSeq) ? this : this + resetSeq;

  /// Regular expression matching an Ansi modifier.
  static final matchAnsi = RegExp(r'\u001B\[(\d+|;)+m', unicode: true);

  /// Removes all Ansi modifiers and returns the resulting string.
  String stripAnsi() {
    return isEmpty ? this : replaceAll(matchAnsi, '');
  }
}
