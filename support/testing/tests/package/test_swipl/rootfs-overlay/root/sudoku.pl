% taken from:
% https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku

:- use_module(library(clpfd)).

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).

problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,3,_,8,5],
            [_,_,1,_,2,_,_,_,_],
            [_,_,_,5,_,7,_,_,_],
            [_,_,4,_,_,_,1,_,_],
            [_,9,_,_,_,_,_,_,_],
            [5,_,_,_,_,_,_,7,3],
            [_,_,2,_,1,_,_,_,_],
            [_,_,_,_,4,_,_,_,9]]).

top :- writeln("Sudoku solution:"),
    problem(1, Rows), sudoku(Rows), maplist(portray_clause, Rows),
    Rows = [[9, 8, 7, 6, 5, 4, 3, 2, 1],
            [2, 4, 6, 1, 7, 3, 9, 8, 5],
            [3, 5, 1, 9, 2, 8, 7, 4, 6],
            [1, 2, 8, 5, 3, 7, 6, 9, 4],
            [6, 3, 4, 8, 9, 2, 1, 5, 7],
            [7, 9, 5, 4, 6, 1, 8, 3, 2],
            [5, 1, 9, 2, 8, 6, 4, 7, 3],
            [4, 7, 2, 3, 1, 9, 5, 6, 8],
            [8, 6, 3, 7, 4, 5, 2, 1, 9]].
