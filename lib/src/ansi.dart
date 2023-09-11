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
  static final reset = Ansi._('0');

  /// Ansi modifier bold forground text.
  static final bold = Ansi._('1');

  /// Ansi modifier italic foreground text.
  static final italic = Ansi._('3');

  /// Ansi mofifiers underlined foreground text.
  static final underline = Ansi._('4');

  /// Ansi modifier crossed out foreground text.
  static final crossedOut = Ansi._('9');

  /// Ansi color modifier: black foreground.
  static final black = Ansi._('30');

  /// Ansi color modifier: red foreground.
  static final red = Ansi._('31');

  /// Ansi color modifier: green foreground.
  static final green = Ansi._('32');

  /// Ansi color modifier: yellow foreground.
  static final yellow = Ansi._('33');

  /// Ansi color modifier: blue foreground.
  static final blue = Ansi._('34');

  /// Ansi color modifier: magenta foreground.
  static final magenta = Ansi._('35');

  /// Ansi color modifier: magenta bold foreground.
  static final magentaBold = Ansi._('1;35');

  /// Ansi color modifier: cyan foreground.
  static final cyan = Ansi._('36');

  /// Ansi color modifier: cyan bold text.
  static final cyanBold = Ansi._('1;36');

  /// Ansi color modifier: grey foreground
  static final grey = Ansi._('2;37');

  /// Ansi color modifier: black background
  static final blackBg = Ansi._('40');

  /// Ansi color modifier: red backgroound
  static final redBg = Ansi._('41');

  /// Ansi color modifier: green background
  static final greenBg = Ansi._('42');

  /// Ansi color modifier: yellow background
  static final yellowBg = Ansi._('43');

  /// Ansi color modifier: blue background
  static final blueBg = Ansi._('44');

  /// Ansi color modifier: magenta background
  static final magentaBg = Ansi._('45');

  /// Ansi color modifier: cyan background
  static final cyanBg = Ansi._('46');

  /// Ansi color modifier: white background
  static final whiteBg = Ansi._('47');

  /// Ansi color modifier: bright red foreground.
  static final redBright = Ansi._('91');

  /// Ansi color modifier: bright green foreground.
  static final greenBright = Ansi._('92');

  /// Ansi color modifier: bright yellow foreground.
  static final yellowBright = Ansi._('93');

  /// Ansi color modifier: bright blue foreground.
  static final blueBright = Ansi._('94');

  /// Ansi color modifier: bright magenta foreground.
  static final magentaBright = Ansi._('95');

  /// Ansi color modifier: grey bold foreground
  static final greyBold = Ansi._('1;90');

  /// Ansi color modifier: white bold foreground
  static final whiteBold = Ansi._('1;97');

  const Ansi._(this.bareCode) : code = escLeft + bareCode + escRight;

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
  /// ---
  /// To disable Ansi styling when running a script use the
  /// command line option:
  /// ```
  /// dart --define=isMonochrome=false
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
