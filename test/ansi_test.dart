import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:test/test.dart';

// Left Ansi escape sequence
const escLeft = '\u001B[';

// Right FontModifier escape character
const escRight = 'm';

void main() {
  group('Constructors:', () {
    test('factory FontModifier.combine', () {
      final ansi = FontModifier.combine(4, 5);
      expect(ansi.bareCode, '4;5');
    });
  });
  group('Accessors', () {
    test('fields', () {
      expect(
        Ansi.red,
        isA<FontModifier>()
            .having(
              (ansi) => ansi.code,
              'escaped code',
              '${escLeft}31$escRight',
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
      expect(FontModifier.combine(36, 1), (Ansi.cyan + Ansi.bold));
    });
    test('Equals', () {
      expect(Ansi.red, Ansi.red);
      expect(Ansi.red, FontModifier(31));
    });
    test('bareCode', () {
      expect((Ansi.bold + Ansi.italic).bareCode, '1;3');
      expect(Ansi.cursorToPosition(row: 5, column: 7).bareCode, '5;7H');
    });
  });
}
