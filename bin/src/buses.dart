enum Bit { zero, one }

extension BitExt on Bit {
  int toInt() {
    if (this == Bit.zero) {
      return 0;
    } else {
      return 1;
    }
  }
}

class BitFactory {
  static Bit fromString(String string) {
    if (string[0] == '0') {
      return Bit.zero;
    } else {
      return Bit.one;
    }
  }
}

abstract class Bus {}

class Bit4Bus implements Bus {
  late Bit b0;
  late Bit b1;
  late Bit b2;
  late Bit b3;

  Bit4Bus(String value) {
    b0 = BitFactory.fromString(value[0]);
    b1 = BitFactory.fromString(value[1]);
    b2 = BitFactory.fromString(value[2]);
    b3 = BitFactory.fromString(value[3]);
  }

  @override
  String toString() {
    return '${b0.toInt()}${b1.toInt()}${b2.toInt()}${b3.toInt()}';
  }
}

class Bit8Bus implements Bus {
  late Bit4Bus b1;
  late Bit4Bus b2;

  Bit8Bus(String value) {
    b1 = Bit4Bus(value.substring(0, 4));
    b2 = Bit4Bus(value.substring(5, 7));
  }

  @override
  String toString() {
    return '${b1.toString()}${b2.toString()}';
  }
}

class Bit16Bus implements Bus {
  late Bit8Bus b1;
  late Bit8Bus b2;

  Bit16Bus(String value) {
    b1 = Bit8Bus(value.substring(0, 7));
    b2 = Bit8Bus(value.substring(8, 15));
  }

  @override
  String toString() {
    return '${b1.toString()}${b2.toString()}';
  }
}
