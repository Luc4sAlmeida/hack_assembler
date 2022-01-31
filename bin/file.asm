(LOOP) // This is an line of comment

    @SCREEN
    D=A

    @screenAddr
    M=D

    @i
    M=0

    @8192
    M=A
    D=M

    @max
    M=D

    @KBD
    D=M;

    @DRAW
    D; JGT

    @CLEAR
    0; JMP

(DRAW)
    @i
    D=M;

    @screenAddr
    A=M+D;
    M=-1

    @i
    M=D+1

    @max
    M=M-1
    D=M;

    @DRAW
    D; JGT

    @LOOP
    0; JMP

(CLEAR)
    @i
    D=M;

    @screenAddr
    A=M+D;
    M=0

    @i
    M=D+1

    @max
    M=M-1
    D=M;

    @CLEAR
    D; JGT

    @LOOP
    0; JMP


