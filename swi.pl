:- dynamic c/2.

field([],_).

field([X|XC], YC):- field1(X,YC), field(XC,YC).

field1(_,[]).

field1(X,[Y|YC]):- assert(c([X,Y],' ')), field1(X,YC).

p_field:-
    findall(X,c([X,_],_),XL),
    sort(XL,XS),
    findall(Y,c([_,Y],_),YL),
    sort(YL,Y1S),


    reverse(Y1S,YS),
    write('   '),
    p_line(XS), nl,
    p_field1(YS,XS).

p_field1([],_).
p_field1([Y|YL],XL):-
    write(Y),
    write(' | '),
    p_field2(Y,XL),nl,
    write('   '),
    p_line(XL),nl,
    p_field1(YL,XL).


p_field2(_,[]).
p_field2(Y, [X|XL]):-
    c([X,Y],P),
    write(P),
    write(' | '),
    p_field2(Y,XL).


p_line([]).
p_line([_|XL]):-
    write('--- '),
    p_line(XL).


o(1,[X,Y],[X1,Y],[X2,Y],[X3,Y],[X4,Y]):-
    X1 is X+1,
    X2 is X+2,
    X3 is X+3,
    X4 is X+4.
o(2,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3],[X4,Y4]):-
    X1 is X+1, Y1 is Y+1,
    X2 is X+2, Y2 is Y+2,
    X3 is X+3, Y3 is Y+3,
    X4 is X+4, Y4 is Y+4.
o(3,[X,Y],[X,Y1],[X,Y2],[X,Y3],[X,Y4]):-
    Y1 is Y+1,
    Y2 is Y+2,
    Y3 is Y+3,
    Y4 is Y+4.
o(4,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3],[X4,Y4]):-
    X1 is X+1,Y1 is Y-1,
    X2 is X+2,Y2 is Y-2,
    X3 is X+3,Y3 is Y-3,
    X4 is X+4, Y4 is Y-4.

win(P):-
    c(C1,P),
    o(_,C1,C2,C3,C4,C5),
    c(C2,P),
    c(C3,P),
    c(C4,P)
    ,c(C5,P),
    nl,
    write([win,C1,C2,C3,C4,C5]),
    nl,
    p_field.

win(_):-
    nl,
    p_field.

%player (user)
move_p(C):-
    c(C,' '),
    retract(c(C,' ')),
    assert(c(C,o)),
    win(o).

reset:-
    retractall(c(_,_)),
    field([5,1,2,3,4,0,6,7,8,9],[5,1,2,3,4,0,6,7,8,9]),
    p_field.


%xxxx_
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,x),
    c(C5,' '),
    retract(c(C5,' ')),
    assert(c(C5,x)),
    write([C5,ID, 'xxxxX']),nl,
    win(x).

%_xxxx
move_c:-c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,x),
    c(C5,x),
    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,ID, '_xxxx']),nl,
    win(x).

%xxx_x
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,' '),
    c(C5,x),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID, 'xxxXx']),nl,
    win(x).


%x_xxx
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,x),
    c(C5,x),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID, 'xXxxx']),nl,
    win(x).


%xx_xx
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,x),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID, 'xxXxx']),nl,
    win(x).


%ooooX
move_c:-c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),
    c(C3,o),
    c(C4,o),
    c(C5,' '),
    retract(c(C5,' ')),
    assert(c(C5,x)),
    write([C5,ID, 'ooooX']),nl,
    win(x).

%Xoooo
move_c:-c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),    
    c(C3,o),
    c(C4,o),
    c(C5,o),
    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,ID, 'Xoooo']),nl,
    win(x).


%oooXo
move_c:-c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),    
    c(C3,o),
    c(C4,' '),
    c(C5,o),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID, 'oooXo']),nl,
    win(x).


%oXooo
move_c:-c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),    
    c(C3,o),
    c(C4,o),
    c(C5,o),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID, 'oXooo']),nl,
    win(x).


%ooXoo
move_c:-c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),    
    c(C3,' '),
    c(C4,o),
    c(C5,o),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID, 'ooXoo']),nl,
    win(x).


% _xxx_ 
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,x),
    c(C5,' '),
    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,ID,'_xxx_']), nl,
    win(x).

% xxx__
move_c :-
    c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,' '),
    c(C5,' '),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID,'xxx__']), nl,
    win(x).

% __xxx
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,x),
    c(C5,x),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'__xxx']), nl,
    win(x).

% xx__x
move_c :-
    c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,' '),
    c(C5,x),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID,'xx__x']), nl,
    win(x).

% x__xx
move_c :-
    c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,' '),
    c(C4,x),
    c(C5,x),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID,'x__xx']), nl,
    win(x).



% _ooo_ 
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),
    c(C3,o),
    c(C4,o),
    c(C5,' '),
    retract(c(C5,' ')),
    assert(c(C5,x)),
    write([C5,ID,'_ooo_']), nl,
    win(x).

% ooo__ 
move_c :-
    c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),
    c(C3,o),
    c(C4,' '),
    c(C5,' '),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID,'ooo__']), nl,
    win(x).

% __ooo
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,o),
    c(C4,o),
    c(C5,o),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'__ooo']), nl,
    win(x).

% o_o_o
move_c :-
    c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,o),
    c(C4,' '),
    c(C5,o),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'o_o_o']), nl,
    win(x).


% oo__o
move_c :-
    c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,o),
    c(C3,' '),
    c(C4,' '),
    c(C5,o),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID,'oo__o']), nl,
    win(x).

% o__oo
move_c :-
    c(C1,o),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,' '),
    c(C4,o),
    c(C5,o),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID,'o__oo']), nl,
    win(x).



%xx_x_
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,_),
    c(C4,x),
    c(C5,_),
    retract(c(C5,' ')),
    assert(c(C5,x)),
    write([C5,ID, 'xx_x_']),nl,
    win(x).


%_xx_x
move_c:-c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,_),
    c(C5,x),
    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,ID, '_xx_x']),nl,
    win(x).

%x_xx_
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,x),
    c(C5,' '),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID, 'x_xx_']),nl,
    win(x).

% x_x_x
move_c :-
    c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,' '),
    c(C5,x),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'x_x_x']), nl,
    win(x).

% x_x__
move_c :-
    c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,' '),
    c(C5,' '),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'attack x_x__']), nl,
    win(x).

% __x_x
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,' '),
    c(C5,x),
    retract(c(C2,' ')),
    assert(c(C2,x)),
    write([C2,ID,'attack __x_x']), nl,
    win(x).

% _x_x_
move_c :-
    c(C1,' '),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,' '),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,ID,'attack _x_x_']), nl,
    win(x).

%cross c3 attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,' '),
    c(C6, ' '),
    o(ID2,C6,C7,C3,C8,C9),
    ID1 \= ID2,
    c(C7,x),
    c(C8,x),
    c(C9,' '),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,'cross C3']),
    nl,
    win(x).

%parallel fork attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,' '),
    c(C5,' '),
    o(ID2,C1,C6,C7,C8,C9),
    ID1 \= ID2,
    c(C6,x),
    c(C7,' '),
    c(C8,x),
    c(C9,' '),
    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,'parallel fork']),
    nl,
    win(x).

%diagonal fork attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,' '),

    o(ID2,C1,C6,C7,C8,C9),
    ID1 \= ID2,
    c(C6,x),
    c(C7,' '),
    c(C8,x),
    c(C9,' '),

    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,'diagonal fork']),
    nl,
    win(x).


%mixed fork attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,' '),
    c(C5,' '),

    o(ID2,C1,C6,C7,C8,C9),
    ID1 \= ID2,
    c(C6,x),
    c(C7,' '),
    c(C8,' '),
    c(C9,x),

    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,'mixed fork']),
    nl,
    win(x).

%broken three fork attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,' '),

    o(ID2,C1,C6,C7,C8,C9),
    ID1 \= ID2,
    c(C6,x),
    c(C7,' '),
    c(C8,' '),
    c(C9,x),

    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,'broken three fork']),
    nl,
    win(x).

%double three fork attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,' '),
    c(C3,x),
    c(C4,x),
    c(C5,' '),

    o(ID2,C1,C6,C7,C8,C9),
    ID1 \= ID2,
    c(C6,' '),
    c(C7,x),
    c(C8,' '),
    c(C9,x),

    retract(c(C1,' ')),
    assert(c(C1,x)),
    write([C1,'double three fork']),
    nl,
    win(x).


move_c:-
    c(C,' '),
    retract(c(C,' ')),
    assert(c(C,x)),
    write([C, 'empty place']),
    win(x).