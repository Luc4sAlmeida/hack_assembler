import 'parser.dart';
import 'scanner.dart';
import 'token.dart';

abstract class IAssembler {
  /// Should returns an list of string with all the binary codes translated.
  /// [raw] -> File string
  Future<List<String>> assemble(List<String> sourceLines);
}

class HackAssembler implements IAssembler {
  final IScanner scanner;
  final IParser parser;

  HackAssembler({
    required this.scanner,
    required this.parser,
  });

  @override
  Future<List<String>> assemble(List<String> sourceLines) async {
    List<List<Token>> scannedTokens = [];

    for (int i = 0; i < sourceLines.length; i++) {
      final tokens = scanner.scanTokens(sourceLines[i], i);
      if (tokens.isNotEmpty) {
        scannedTokens.add(tokens);
      }
    }

    return parser.parse(scannedTokens);
  }
}
