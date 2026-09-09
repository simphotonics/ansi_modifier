/// Ansi modifier replacement method.
enum EditMethod {
  /// The Ansi [FontModifier] is added to the beginning of the string,
  /// and the reset modifier [Ansi.reset] is added at the end of the string.
  add,

  /// New modifiers are added to existing modifiers.
  addToExisting,

  /// All existing Ansi modifiers are removed and the new Ansi
  /// modifier is applied to the entire string.
  clearExisting,

  /// The first encountered Ansi modifier is replaced with the new modifier.
  /// If the string does not contain an Ansi modifier it is returned unchanged.
  replaceFirst,

  /// All existing modifiers are replaced with the new modifier.
  /// If the string does not contain an Ansi modifier it is returned unchanged.
  replaceAll,
}
