import 'dart:io';

import 'src/assembler.dart';
import 'src/parser.dart';
import 'src/scanner.dart';

Future<void> main(List<String> arguments) async {
  File file = File('./file.asm');
  List<String> sourceCode = file.readAsLinesSync();

  IAssembler assembler = HackAssembler(
    scanner: Scanner(),
    parser: Parser(),
  );

  final asmSource = await assembler.assemble(sourceCode);
}
