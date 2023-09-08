# Ansi Modifier


## Introduction

The package provides the class [`Ansi`][Ansi] holding ANSI modifier codes and
String extension methods for adding, replacing, and removing ANSI modifiers.


## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.

Use the String extension functions [`modify`][modify] to add new modifiers or
to replace existing ones. The replacement method can be adjusted by setting the
optional argument `method`.

Use the function [`stripAnsi`][stripAnsi] to remove
all Ansi modifier from a string.

```Dart
import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
  print('Create colorized strings:');
  final blue = 'blueberry'.modify(Ansi.blue + Ansi.italic);
  final green = 'green apple'.modify(Ansi.green);
  final blueGreen = blue +
      ' and ' +
      green.modify(
        Ansi.bold,
        method: Replace.none,
      );
  print('$blue, $green, $blueGreen');

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:');

  /// Replace first modifier:
  final yellowGreen = blueGreen.modify(Ansi.yellow + Ansi.bold + Ansi.underline,
      method: Replace.first);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.modify(Ansi.magenta, method: Replace.clearPrevious);

  /// Strip all Ansi modifiers.
  print('$yellowGreen, $magenta, ${magenta.stripAnsi()}');
}
```

Runnig the program above:
```Console
$ dart example/bin/color_example.dart
```
produces the following terminal output:

![Console Output](https://raw.githubusercontent.com/simphotonics/ansi_modifier/main/images/console_output.png)

A typical console output is shown above. The following colour-coding is used:
* The labels of synchronous benchmarks and groups are printed using <span style="color: #28B5D7">*cyan*</span>
foreground.
* The labels of asynchronous benchmarks and groups are
printed using <span style="color:#AE5AAE">*magenta*</span> foreground.
* The histogram block containing the *mean*
is printed using <span style="color:#11A874">*green*</span> foreground.
* The block containg the *median* is printed
using <span style="color:#2370C4">*blue*</span> foreground.
* If the same block contains mean and median it is printed
using <span style="color:#28B5D7">*cyan*</span> foreground.
* Error are printed using <span style="color:#CB605E"> *red* </span> foreground.


## Tips and Tricks

The scores reported by [`benchmark`][benchmark] and
[`asyncBenchmark`][asyncBenchmark]
refer to a *single* run of the benchmarked function.

Benchmarks do *not* need to be enclosed by a group.

A benchmark group may *not* contain another benchmark group.

By default, [`benchmark`][benchmark] and
[`asyncBenchmark`][asyncBenchmark] report score statistics. In order to generate
the report provided by [`benchmark_harness`][benchmark_harness] use the
optional argument `emitStats: false`.

Color output can be switched off by using the option: `--isMonochrome` when
calling the benchmark runner. When executing a single benchmark file the
corresponding option is `--define=isMonochrome=true`.

When running **asynchronous** benchmarks, it is recommended
to await the completion of the benchmark functions.
Otherwise, the scores might not be printed in the expected order making it
more difficult to read (grouped) benchmark results.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/ansi_modifier/issues

[ansi_modifier]: https://pub.dev/packages/ansi_modifier

[Ansi]: https://pub.dev/packages/ansi_modifier/doc/api/ansi_modifier/Ansi-class.html

[modify]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/modify.html

[clearAnsi]: https://pub.dev/documentation/ansi_modifier/doc/api/ansi_modifier/AnsiModifier/asyncGroup.html
