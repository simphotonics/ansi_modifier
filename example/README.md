# Ansi Modifier


## Introduction

The package provides an enhanced enum holding ANSI modifier codes and
extensions for preparing string for output to ANSI compliant consoles.

## Usage

Include [`ansi_modifier`][ansi_modifier] as a dependency
 in your `pubspec.yaml` file.

Modify strings by adding, replacing, or clearing existing ANSI modifiers.

  ```Dart
  // ignore_for_file: unused_local_variable
  import 'dart:collection';

  import 'package:benchmark_runner/benchmark_runner.dart';

  void main(List<String> args) async {
    final originalList = <int>[for (var i = 0; i < 1000; ++i) i];

    await asyncGroup('Async List:', () async {
      await asyncBenchmark('construct list of Future<int>', () async {
        final list = Future.value([for (var i = 0; i < 100; ++i) i]);
      }, emitStats: false);

      await asyncBenchmark('construct list of Future<int>, report stats',
          () async {
        final list = Future.value([for (var i = 0; i < 100; ++i) i]);
      }, emitStats: true);
    });

    group('List:', () {
      benchmark('construct list', () {
        var list = <int>[for (var i = 0; i < 1000; ++i) i];
      });

      benchmark('construct list', () {
        var list = <int>[for (var i = 0; i < 1000; ++i) i];
      }, emitStats: false);

      benchmark('construct list view', () {
        final listView = UnmodifiableListView(originalList);
      });
    });
  }

  ```

Run a single benchmark file as an executable:
```Console
$ dart benchmark/list_benchmark.dart
```

Run several benchmark files (ending with `_benchmark.dart`)
by calling the benchmark_runner and specifying a directory.
The directory name defaults to `benchmark`:

```Console
$ dart run benchmark_runner
```


![Console Output](https://raw.githubusercontent.com/simphotonics/benchmark_runner/main/images/console_output.png)

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
