import 'dart:math';

import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:test/test.dart';

final sun = 'sun';
final moon = 'moon';
final star = 'star';
final planet = 'planet';

void main() {
  group('Color:', () {
    test('red', () {
      expect(planet.style(Ansi.red), startsWith(Ansi.red.toString()));
      expect(planet.style(Ansi.red), endsWith(Ansi.reset.toString()));
    });
    test('yellow', () {
      expect(sun.style(Ansi.yellow), startsWith(Ansi.yellow.toString()));
      expect(sun.style(Ansi.yellow), endsWith(Ansi.reset.toString()));
    });
  });
  group('clearStyle():', () {
    final redMoon = moon.style(Ansi.red);
    final greenPlanet = planet.style(Ansi.green);
    test('simple string', () {
      expect(redMoon.clearStyle(), moon);
      expect((' $redMoon').clearStyle(), ' $moon');
    });
    test('complex string', () {
      expect((redMoon + greenPlanet).clearStyle(), moon + planet);
    });
  });
  group('Reset:', () {
    test('replace starting', () {
      expect(
        ('The ${'fox'.style(Ansi.bold)}').style(Ansi.reset),
        startsWith(Ansi.reset.code),
      );
    });
  });
  group('EditMethod:', () {
    test('add', () {
      expect(
        moon.style(Ansi.red).style(Ansi.blue),
        '\x1B[34m\x1B[31mmoon\x1B[0m\x1B[0m',
      );
    });
    test('addToExisting', () {
      expect(
        (sun + ' ' + moon.style(Ansi.red)).style(
          Ansi.italic,
          editMethod: EditMethod.addToExisting,
        ),
        'sun \x1B[31;3mmoon\x1B[0m',
      );
    });

    test('replaceFirst', () {
      expect(
        moon
            .style(Ansi.red)
            .style(Ansi.blue, editMethod: EditMethod.replaceFirst),
        startsWith(Ansi.blue.toString()),
      );
      expect(
        moon.style(Ansi.red).length,
        moon
            .style(Ansi.blue)
            .style(Ansi.red, editMethod: EditMethod.replaceFirst)
            .length,
      );
    });
    test('replaceAll', () {
      final moonAndStar =
          'rising ${moon.style(Ansi.red)} and ${star.style(Ansi.red)}';
      final blueMoonAndStar = moonAndStar.style(
        Ansi.blue,
        editMethod: EditMethod.replaceAll,
      );
      expect(
        blueMoonAndStar,
        'rising \x1B[34mmoon\x1B[0m and \x1B[34mstar\x1B[0m',
      );
    });

    test('clearExisting', () {
      final risingRedMoon = 'rising ${moon.style(Ansi.red)}';
      final blueRisingMoon = risingRedMoon.style(
        Ansi.blue,
        editMethod: EditMethod.clearExisting,
      );
      expect(blueRisingMoon, startsWith(Ansi.blue.code));
      expect(blueRisingMoon, isNot(contains(Ansi.red.code)));
      expect(blueRisingMoon, endsWith(Ansi.reset.code));
      expect(
        blueRisingMoon.style(Ansi.reset, editMethod: EditMethod.clearExisting),
        'rising moon',
      );
    });
  });
  group('Ansi output', () {
    test('enabled', () {
      final status = Ansi.status;
      Ansi.status = AnsiOutput.enabled;
      expect('string'.style(Ansi.bold), startsWith(Ansi.bold.code));
      expect('string'.style(Ansi.bold), endsWith(Ansi.reset.code));
      Ansi.status = status;
    });
    test('disabled', () {
      final status = Ansi.status;
      Ansi.status = AnsiOutput.disabled;
      expect('string'.style(Ansi.bold), startsWith('str'));
      expect('string'.style(Ansi.bold), endsWith('ing'));
      Ansi.status = status;
    });
  });
}
