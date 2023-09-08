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
      expect(planet.modify(Ansi.red), startsWith(Ansi.red.toString()));
      expect(planet.modify(Ansi.red), endsWith(Ansi.reset.toString()));
    });
    test('yellow', () {
      expect(sun.modify(Ansi.yellow), startsWith(Ansi.yellow.toString()));
      expect(sun.modify(Ansi.yellow), endsWith(Ansi.reset.toString()));
    });
  });
  group('clear():', () {
    final redMoon = moon.modify(Ansi.red);
    final greenPlanet = planet.modify(Ansi.green);
    test('simple string', () {
      expect(redMoon.stripAnsi(), moon);
      expect((' ' + redMoon).stripAnsi(), ' ' + moon);
    });
    test('complex string', () {
      expect((redMoon + greenPlanet).stripAnsi(), moon + planet);
    });
  });
  group('Replace:', () {
    test('starting', () {
      expect(
          moon.modify(Ansi.red).modify(Ansi.blue),
          startsWith(
            Ansi.blue.toString(),
          ));
      expect(
        moon.modify(Ansi.red).length,
        moon.modify(Ansi.blue).modify(Ansi.red).length,
      );
    });
    test('first', () {
      final risingRedMoon = 'rising ' + moon.modify(Ansi.red);
      final risingBlueMoon = risingRedMoon.modify(
        Ansi.blue,
        method: Replace.first,
      );
      expect(risingBlueMoon, startsWith('rising ' + Ansi.blue.code));
      expect(risingBlueMoon, endsWith(Ansi.reset.code));
    });
    test('none', () {
      final risingRedMoon = 'rising ' + moon.modify(Ansi.red);
      final blueRisingMoon = risingRedMoon.modify(
        Ansi.blue,
        method: Replace.none,
      );
      expect(blueRisingMoon, startsWith(Ansi.blue.code));
      expect(blueRisingMoon, contains(Ansi.red.code));
      expect(blueRisingMoon, endsWith(Ansi.reset.code));
    });
    test('clearPrevious', () {
      final risingRedMoon = 'rising ' + moon.modify(Ansi.red);
      final blueRisingMoon = risingRedMoon.modify(
        Ansi.blue,
        method: Replace.clearPrevious,
      );
      expect(blueRisingMoon, startsWith(Ansi.blue.code));
      expect(blueRisingMoon, isNot(contains(Ansi.red.code)));
      expect(blueRisingMoon, endsWith(Ansi.reset.code));
    });
  });
}
