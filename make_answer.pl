:- dynamic(answer/4).

make_answer(Start, End) :-
    findall(EndCost, used([End, _], EndCost), EndCosts),
    min_list(EndCosts, MinCost),
    used(EndNode, MinCost),
    EndNode = [End, _],
    path(Prev, EndNode),
    Prev = [PrevStation, _],
    PrevStation \= End,
    ma_dfs(Start, Prev, GetAnswer),
    TmpAnswer = [ EndNode | GetAnswer ],
    ma_fold(TmpAnswer, Result),
    ma_sum(Result, AllDist, AllTime),
    length(Result, TmpChanges),
    Changes is TmpChanges - 1,
    assertz(answer(AllDist, AllTime, Changes, Result)),
    fail ; true.

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

ma_sum([], 0, 0).
ma_sum([ [_, _, _, [Dist, Time]] | Results ], AllDist, AllTime) :-
    ma_sum(Results, GetDist, GetTime),
    AllDist is GetDist + Dist,
    AllTime is GetTime + Time.
