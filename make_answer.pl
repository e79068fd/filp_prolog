:- include('bd.pl').

path([b,2],[d,2]).
path([c,2],[d,2]).
path([c,1],[c,2]).
path([b,1],[b,2]).
path([a,1],[c,1]).
path([a,1],[b,1]).

test :-
    Start = a,
    End = d,
    %make_answer(Start, End, Answers),
    path(Prev, [End, Number]),
    dfs(Start, Prev, GetAnswer),
    TmpAnswer = [ [End, Number] | GetAnswer ],
    %reverse(TmpAnswer, Answer),
    fold(TmpAnswer, Answer),
    write(Answer),nl.

dfs(Stop, Current, [ Current ]) :- Current = [Stop, _], !.
dfs(Stop, Current, [ Current | GetAnswer ]) :-
    path(Prev, Current),
    dfs(Stop, Prev, GetAnswer).

fold([ Current ], [ [Number, Start, Start, [0, 0]] ]) :- Current = [Start, Number].
fold([To | Other], Answers) :-
    fold(Other, [ PrevAnswer | GetOtherAnswers]),
    mix(To, PrevAnswer, Result),
    append(Result, GetOtherAnswers, Answers).

mix(Current, Answer, [ [Number, GetStart, CurrentStation, [AnsDist, AnsTime]] ]) :-
    Current = [CurrentStation, Number],
    Answer = [Number, GetStart, GetEnd, [GetDist, GetTime]],
    station(GetEnd, CurrentStation, [Dist, Time]),
    AnsDist is GetDist + Dist,
    AnsTime is GetTime + Time, !.
mix(Current, Answer, [ [Number, Station, Station, [0, 0]], Answer ]) :-
    Current = [Station, Number],
    Answer = [_, _, Station, _].



