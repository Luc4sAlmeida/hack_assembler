import 'token.dart';

abstract class IScanner {
  List<Token> scanTokens(String source, int linePos);
}

class Scanner implements IScanner {
  final keywords = {
    'M': TokenType.m,
    'D': TokenType.d,
    'MD': TokenType.md,
    'A': TokenType.a,
    'AM': TokenType.am,
    'AD': TokenType.ad,
    'AMD': TokenType.amd,
    'JGT': TokenType.jgt,
    'JEQ': TokenType.jeq,
    'JGE': TokenType.jge,
    'JLT': TokenType.jlt,
    'JNE': TokenType.jne,
    'JLE': TokenType.jle,
    'JMP': TokenType.jmp
  };

  late List<Token> tokens;
  late String source;

  int start = 0;
  int pos = 0;
  int linePos = 0;

  bool get end => source.length == pos;
  String advance() => source[pos++];

  String? peekNext() {
    print(pos + 1);
    print(source.length);

    if (pos + 1 >= source.length) return null;
    return source[pos + 1];
  }

  String? peek() {
    if (end) return null;
    return source[pos];
  }

  bool isAlphaNumeric(String? c) {
    return isDigit(c) || isAlpha(c);
  }

  bool isDigit(String? c) {
    if (c == null) return false;
    return double.tryParse(c) != null;
  }

  bool isAlpha(String? c) {
    return c?.contains(RegExp(r'^[a-zA-Z]*$')) ?? false;
  }

  bool match(String c) {
    if (end) return false;
    if (peekNext() != c) return false;

    pos++;
    return true;
  }

  void reset() {
    pos = 0;
    start = 0;
    linePos = 0;
    tokens = [];
  }

  void addToken(TokenType type) {
    addTokenLiteral(type, null);
  }

  void addTokenLiteral(TokenType type, dynamic literal) {
    _addToken(type, literal);
  }

  void _addToken(TokenType type, dynamic literal) {
    final lexeme = source.substring(start, pos);
    tokens.add(
      Token(
        type: type,
        lexeme: lexeme,
        literal: literal,
        line: linePos,
      ),
    );
  }

  @override
  List<Token> scanTokens(String source, int linePos) {
    reset();

    this.source = source;
    this.linePos = linePos;

    while (!end) {
      start = pos;
      processChar();
    }

    return tokens;
  }

  void processChar() {
    final char = advance();
    switch (char) {
      case '(':
        addToken(TokenType.leftParen);
        break;
      case ')':
        addToken(TokenType.rightParen);
        break;
      case '=':
        addToken(TokenType.equal);
        break;
      case '+':
        addToken(TokenType.plus);
        break;
      case '-':
        addToken(TokenType.minus);
        break;
      case '!':
        addToken(TokenType.negate);
        break;
      case '@':
        addToken(TokenType.at);
        break;
      case '&':
        addToken(TokenType.and);
        break;
      case '|':
        addToken(TokenType.or);
        break;
      case ';':
        addToken(TokenType.comma);
        break;
      case '/':
        processComments();
        break;

      case ' ':
      case '\r':
      case '\t':
        // Ignore whitespace.
        break;

      default:
        if (isDigit(char)) {
          processDigit();
        } else if (isAlpha(char)) {
          processIdentifier();
        } else {
          throw Exception('Undefined symbol: $char');
        }
    }
  }

  void processComments() {
    while (peek() != null) {
      advance();
    }
  }

  void processDigit() {
    while (isDigit(peek())) {
      advance();
    }

    final text = source.substring(start, pos);
    final digit = double.parse(text);

    addTokenLiteral(TokenType.number, digit);
  }

  void processIdentifier() {
    while (isAlpha(peek())) {
      advance();
    }

    final text = source.substring(start, pos);
    final tokenType = keywords[text] ?? TokenType.label;

    addToken(tokenType);
  }
}

//D=MD+1
