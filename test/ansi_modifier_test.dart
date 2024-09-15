import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:ansi_modifier/src/ansi.dart';
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
      expect((' ' + redMoon).clearStyle(), ' ' + moon);
    });
    test('complex string', () {
      expect((redMoon + greenPlanet).clearStyle(), moon + planet);
    });
  });
  group('Reset:', () {
    test('replace starting', () {
      expect(
          ('The ' + 'fox'.style(Ansi.bold)).style(Ansi.reset),
          startsWith(
            Ansi.reset.code,
          ));
    });
  });
  group('Replace:', () {
    test('starting', () {
      expect(
          moon.style(Ansi.red).style(Ansi.blue),
          startsWith(
            Ansi.blue.toString(),
          ));
      expect(
        moon.style(Ansi.red).length,
        moon.style(Ansi.blue).style(Ansi.red).length,
      );
    });
    test('first', () {
      final risingRedMoon = 'rising ' + moon.style(Ansi.red);
      final risingBlueMoon = risingRedMoon.style(
        Ansi.blue,
        method: Replace.first,
      );
      expect(risingBlueMoon, startsWith('rising ' + Ansi.blue.code));
      expect(risingBlueMoon, endsWith(Ansi.reset.code));
    });
    test('none', () {
      final risingRedMoon = 'rising ' + moon.style(Ansi.red);
      final blueRisingMoon = risingRedMoon.style(
        Ansi.blue,
        method: Replace.none,
      );
      expect(blueRisingMoon, startsWith(Ansi.blue.code));
      expect(blueRisingMoon, contains(Ansi.red.code));
      expect(blueRisingMoon, endsWith(Ansi.reset.code));
    });
    test('clearPrevious', () {
      final risingRedMoon = 'rising ' + moon.style(Ansi.red);
      final blueRisingMoon = risingRedMoon.style(
        Ansi.blue,
        method: Replace.clearPrevious,
      );
      expect(blueRisingMoon, startsWith(Ansi.blue.code));
      expect(blueRisingMoon, isNot(contains(Ansi.red.code)));
      expect(blueRisingMoon, endsWith(Ansi.reset.code));
      expect(
        blueRisingMoon.style(Ansi.reset, method: Replace.clearPrevious),
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
