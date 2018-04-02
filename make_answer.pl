make_answer(Start, End, Result) :-
    path(Prev, [End, Number]),
    ma_dfs(Start, Prev, GetAnswer),
    TmpAnswer = [ [End, Number] | GetAnswer ],
    ma_fold(TmpAnswer, Result).

ma_dfs(Stop, Current, [ Current ]) :- Current = [Stop, _], !.
ma_dfs(Stop, Current, [ Current | GetAnswer ]) :-
    path(Prev, Current),
    ma_dfs(Stop, Prev, GetAnswer).

ma_fold([ Current ], [ [Number, Start, Start, [0, 0]] ]) :- Current = [Start, Number].
ma_fold([To | Other], Answers) :-
    ma_fold(Other, [ PrevAnswer | GetOtherAnswers]),
    ma_mix(To, PrevAnswer, Result),
    append(Result, GetOtherAnswers, Answers).

ma_mix(Current, Answer, [ [Number, GetStart, CurrentStation, [AnsDist, AnsTime]] ]) :-
    Current = [CurrentStation, Number],
    Answer = [Number, GetStart, GetEnd, [GetDist, GetTime]],
    station(GetEnd, CurrentStation, [Dist, Time]),
    AnsDist is GetDist + Dist,
    AnsTime is GetTime + Time, !.
ma_mix(Current, Answer, [ [Number, Station, Station, [0, 0]], Answer ]) :-
    Current = [Station, Number],
    Answer = [_, _, Station, _].



