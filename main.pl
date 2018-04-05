:- include('make_graph.pl').
:- include('find_path.pl').
:- include('make_answer.pl').

:- include('bd.pl').


main :-
    make_graph(BusStations),

    show_stations([]),
    format("Set start station:~n",[]),
    get_station(Start, []),

    show_stations([Start]),
    format("Set end station:~n",[]),
    get_station(End, [Start]),

    format("Set weights. Format weights is [Dist, Time, Changes] where Dist,Time,Changes is number in range (0..1]. If weights are positive number but are not in range, it will be normalization.~n",[]),
    get_weights(Weights),

    find_path(BusStations, Start, Weights),
    make_answer(Start, End, Result),
    write(Result).

show_stations(Ignore) :-
    format("Station name:~n", []),
    station_name(ID, Name),
    \+ member(ID, Ignore),
    format("~d ~a~n", [ID, Name]),
    fail;true.

try_get(Term, Comparator) :-
    catch(read(Term), _, fail),
    call_with_args(Comparator, Term), ! ;
    format("Not correct input. Try again!~n", []),
    try_get(Term, Comparator).

get_station(Station, Ignore) :-
    try_get(Station, number),
    \+ member(Station, Ignore),
    station_name(Station, _), ! ;
    format("Not correct bus station. Try again!~n", []),
    get_station(Station, Ignore).

get_weights(Weights) :-
    try_get(RawWeights, checker_weights),
    length(RawWeights, L), L = 3,
    sum_list(RawWeights, Sum),
    normalization_weights(RawWeights, Sum, Weights), ! ;
    format("Not correct weights. Try again!~n", []),
    get_weights(Weights).

checker_weights([]).
checker_weights([W | Weights]) :-
    number(W),
    W > 0,
    checker_weights(Weights).

normalization_weights([], _, []).
normalization_weights([ RW | RawWeights ], Sum, [ W | Weights ]) :-
    W is RW / Sum,
    normalization_weights(RawWeights, Sum, Weights).
