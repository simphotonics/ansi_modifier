import 'package:ansi_modifier/ansi_modifier.dart';

void main(List<String> args) {
  final s =
      'The ' +
      'red'.style(Ansi.redBright + Ansi.bold) +
      ' fox jumps '
          'over the ' +
      'green'.style(Ansi.greenBright + Ansi.italic) +
      ' fence.';
  print(s);
}
