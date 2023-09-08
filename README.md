# Ansi Modifier


## Introduction

The package provides an enhanced enum holding ANSI modifier codes and
String extension methods for adding, replacing, and removing ANSI modifiers.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.

Modify strings by adding, replacing, or clearing existing ANSI modifiers using
the String
extension functions [`modify()`][modify()] and [`clearAnsi()`][clearAnsi()].

```Dart
import 'package:ansi_modifier/src/ansi.dart';

void main(List<String> args) {
  /// Create colorized strings.
  print('Create colorized strings:'.modify(Ansi.bold));
  final blue = 'A string.'.modify(Ansi.blue);
  print('A blue string:');
  print(blue);

  print('\nA green string:');
  final green = 'Another string'.modify(Ansi.green);
  print(green);

  print('\nA blue green string:');
  final blueGreen = blue + ' ' + green;
  print(blueGreen);

  /// Modify a previously colorized string.
  print('\nModify previously colorized strings:'.modify(Ansi.bold));

  /// Replace first modifier:
  final yellowGreen = blueGreen.modify(Ansi.yellow, method: Replace.first);
  print('A yellow green string:');
  print(yellowGreen);

  /// Replace all modifiers.
  final magenta =
      yellowGreen.modify(Ansi.magenta, method: Replace.clearPrevious);
  print('\nA magenta string:');
  print(magenta);

  /// Strip all Ansi modifiers.
  print('\nA standard string:');
  print(magenta.stripAnsi());
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

[tracker]: https://github.com/simphotonics/benchmark_runner/issues

[benchmark_harness]: https://pub.dev/packages/benchmark_harness

[benchmark_runner]: https://pub.dev/packages/benchmark_runner

[asyncBenchmark]: https://pub.dev/documentation/benchmark_runner/doc/api/benchmark_runner/asyncBenchmark.html

[asyncGroup]: https://pub.dev/documentation/benchmark_runner/doc/api/benchmark_runner/asyncGroup.html

[benchmark]: https://pub.dev/documentation/benchmark_runner/doc/api/benchmark_runner/benchmark.html

[group]: https://pub.dev/documentation/benchmark_runner/doc/api/benchmark_runner/group.html
