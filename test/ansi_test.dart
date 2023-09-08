import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:test/test.dart';

void main() {
  group('Constructors:', () {
    test('factory Ansi.combine', () {
      final ansi = Ansi.combine({Ansi.red, Ansi.italic});
      expect(
        ansi.bareCode,
        Ansi.italic.bareCode + ';' + Ansi.red.bareCode,
        reason: 'Bare code are sorted!',
      );
    });
  });
  group('Accessors', () {
    test('fields', () {
      expect(
        Ansi.red,
        isA<Ansi>()
            .having(
              (ansi) => ansi.code,
              'escaped code',
              escLeft + '31' + escRight,
            )
            .having((ansi) => ansi.bareCode, 'bare code', '31'),
      );
    });

    test('status', () {
      expect(Ansi.status, AnsiOutput.enabled);
    });
  });
  group('Operator:', () {
    test('+', () {
      expect(
        Ansi.combine({Ansi.cyan, Ansi.bold}),
        (Ansi.cyan + Ansi.bold),
      );
    });
    test('Equals', () {
      expect(Ansi.red, Ansi.red);
      expect(Ansi.red + Ansi.bold, Ansi.bold + Ansi.red);
    });
    test('bareCode', () {
      expect(
        (Ansi.bold + Ansi.italic).bareCode,
        (Ansi.italic + Ansi.bold).bareCode,
      );
    });
  });
}
