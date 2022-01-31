import 'token.dart';

class SymbolTable {
  int lastMemoryAlloc = 16;
  Map<String, int> table = {};

  void loadUp(List<List<Token>> tokens) {
    for (var instruction in tokens) {
      for (var item in instruction) {
        if (item.type == TokenType.label) {
          _add(item.lexeme);
        }
      }
    }
  }

  void _add(String label) {
    if (table.containsKey(label)) {
      return;
    }

    table[label] = lastMemoryAlloc++;
  }

  int get(String label) {
    return table[label] ?? lastMemoryAlloc; // this not look right.
  }
}
