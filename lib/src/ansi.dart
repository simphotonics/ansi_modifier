/// Left Ansi escape sequence
const _escLeft = '\u001B[';

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
enum Ansi {
  /// Ansi modifier: Reset to default.
  reset(resetSeq),

  /// Ansi color modifier: red foreground.
  red('\u001B[31m'),

  /// Ansi color modifier: bright red foreground.
  redBright('\u001B[91m'),

  /// Ansi color modifier: green foreground.
  green('\u001B[32m'),

  /// Ansi color modifier: bright green foreground.
  greenBright('\u001B[92m'),

  /// Ansi color modifier: yellow foreground.
  yellow('\u001B[33m'),

  /// Ansi color modifier: bright yellow foreground.
  yellowBright('\u001B[93m'),

  /// Ansi color modifier: blue foreground.
  blue('\u001B[34m'),

  /// Ansi color modifier: bright blue foreground.
  blueBright('\u001B[94m'),

  /// Ansi color modifier: magenta foreground.
  magenta('\u001B[35m'),

  /// Ansi color modifier: magenta foreground.
  magentaBright('\u001B[95m'),

  /// Ansi color modifier: magenta bold foreground.
  magentaBold('\u001B[1;35m'),

  /// Ansi color modifier: cyan foreground.
  cyan('\u001B[36m'),

  /// Ansi color modifier: cyan bold text.
  cyanBold('\u001B[1;36m'),

  /// Ansi color modifier: grey foreground
  grey('\u001B[2;37m'),

  /// Ansi color modifier: grey bold foreground
  greyBold('\u001B[1;90m'),

  /// Ansi color modifier: white bold foreground
  whiteBold('\u001B[1;97m'),

  /// Ansi modifier bold forground text.
  bold('\u001B[1m'),

  /// Ansi modifier italic foreground text.
  italic('\u001B[3m'),

  /// Ansi modifier crossed out foreground text.
  crossedOut('\u001B[9m');

  const Ansi(this.code);

  /// Returns the Ansi code.
  final String code;

  /// Returns a set of all registered Ansi modifiers.
  static final Set<String> modifiers = Ansi.values
      .map(
        (e) => e.code,
      )
      .toSet();

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
        (AnsiOutput.enabled, Replace.starting) => startsWith(_escLeft)
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
