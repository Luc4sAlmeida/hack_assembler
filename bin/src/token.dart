enum TokenType {
  m,
  d,
  md,
  a,
  am,
  ad,
  amd,

  equal,
  plus,
  minus,
  negate,

  at,

  and,
  or,

  leftParen,
  rightParen,
  comma,

  jgt,
  jeq,
  jge,
  jlt,
  jne,
  jle,
  jmp,

  label,
  number,

  eof,
}

class Token {
  final TokenType type;
  final String lexeme;
  final dynamic literal;
  final int line;

  Token({
    required this.type,
    required this.lexeme,
    required this.literal,
    required this.line,
  });

  @override
  String toString() {
    return '${type.name} ($lexeme) ($literal) [$line]';
  }
}
