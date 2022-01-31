import 'buses.dart';

abstract class Instruction {
  final Bit opCode;
  Instruction(
    this.opCode,
  );
}

class AInstruction implements Instruction {
  @override
  Bit get opCode => Bit.zero;

  AInstruction();
}

class CInstruction implements Instruction {
  @override
  Bit get opCode => Bit.one;

  CInstruction();
}
