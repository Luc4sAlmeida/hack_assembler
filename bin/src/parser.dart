import 'buses.dart';
import 'instruction.dart';
import 'symbol_table.dart';
import 'token.dart';

abstract class IParser {
  List<String> parse(List<List<Token>> tokens);
}

class Parser implements IParser {
  final SymbolTable symbolTable = SymbolTable();

  @override
  List<String> parse(List<List<Token>> tokens) {
    final instructions = <Instruction>[];

    // First let's us load the symbol table with everything that we find.
    symbolTable.loadUp(tokens);

    for (var instruction in tokens) {
      final translatedInstruction = processInstruction(instruction);
      instructions.add(translatedInstruction);
    }

    return [];
  }

  Instruction processInstruction(List<Token> instruction) {
    if (instruction.first.type == TokenType.at) {
      return _processInstructionTypeA(instruction);
    } else {
      return _processInstructionTypeC(instruction);
    }
  }

  Instruction _processInstructionTypeA(List<Token> instruction) {
    return AInstruction();
  }

  Instruction _processInstructionTypeC(List<Token> instruction) {
    return CInstruction();
  }
}
