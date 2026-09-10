
## 1.1.0
* The class `Ansi` is now an extension type on `String`.
* The class `FontModifier` is a subclass of `Ansi`.
* The extension method `style()` now supports the edit methods:
`EditMethod.add` (default),
`EditMethod.addToExisting`,
`EditMethod.clearExisting`,
`EditMethod.replaceFirst`,
`EditMethod.replaceAll`.

## 1.0.0
* Requires Dart ^3.13.0.
* Uses short constructor syntax.

## 0.1.5
* Updated dev dependencies.

## 0.1.4
* Added progress indicator example

## 0.1.3
* Updated dev dependencies.
* Corrected documentation.

## 0.1.2
* Added named constructor for generating ansi sequences that move the
  current cursor position. (`Use with stdout.write()`).
* Added example showing how to move the current cursor position.
* Updated `dart.yml` actions.

## 0.1.1
* Added Ansi modifiers.

## 0.1.0
* Breaking change: renamed method `modify()` -> `style()` and
  `removeAnsi()` -> `clearStyle()`.

## 0.0.1
* Initial version
