:- include('bd.pl').

:- include('make_graph.pl').


main :-
    make_graph(BusStations),
    Start = a,
    End = d,
    Weights = [0.5, 0.5, 0.5, 0.5],
    findall([V, U, OriginCost], graph(V, U, OriginCost), Relations),
    preparation_graph(Relations, Weights),
    make_start_value(BusStations, RawCosts),
    set_start_stations(Start, RawCosts, Costs),
    path_find(BusStations, Costs),
    retractall(prepared_graph(_,_,_)).

preparation_graph([], _).
preparation_graph([ [V, U, OriginCost] | Relations], Weights) :-
    scalarize_weights(OriginCost, Weights, NormalazedCost),
    assertz(prepared_graph(V, U, NormalazedCost)),
    preparation_graph(Relations, Weights).

scalarize_weights([], [], 0).
scalarize_weights([C | OriginCost], [W | Weights], Result) :-
    scalarize_weights(OriginCost, Weights, GetResult),
    Result is GetResult + C * W.

make_start_value([], []).
make_start_value([ V | BusStations ], [ [V, 1000000000] | Costs ]) :-
    make_start_value(BusStations, Costs).

set_start_stations(_, [], []).
set_start_stations(Start, [ [ [Start, Number], _ ] | RawCosts ], [ [ [Start, Number], 0 ] | Costs ]) :-
    set_start_stations(Start, RawCosts, Costs), !.
set_start_stations(Start, [ Old | RawCosts], [ Old | Costs ]) :-
    set_start_stations(Start, RawCosts, Costs).

%dijkstra
path_find([], _).
path_find(BusStations, Costs) :-
    find_current_min_cost(BusStations, Costs, 1000000000, MinCost),
    get_current(BusStations, Costs, MinCost, V, NewBusStations),
    findall([U, W], prepared_graph(V, U, W), RawNext),
    filtred_used_next(NewBusStations, RawNext, Next),
    update(Costs, V, MinCost, Next, NewCosts),
    path_find(NewBusStations, NewCosts),
    make_path(V, MinCost, Next).

find_current_min_cost(_, [], Result, Result).
find_current_min_cost(BusStations, [ [V, _] | Costs ], Maybe, GetResult) :-
    \+ member(V, BusStations),
    find_current_min_cost(BusStations, Costs, Maybe, GetResult), !.
find_current_min_cost(BusStations, [ [_, C] | Costs ], Maybe, GetResult) :-
    C < Maybe,
    find_current_min_cost(BusStations, Costs, C, GetResult), !.
find_current_min_cost(BusStations, [ _ | Costs ], Maybe, GetResult) :-
    find_current_min_cost(BusStations, Costs, Maybe, GetResult).

get_current(_, [], _, _, _) :- !, fail.
get_current(BusStations, [ [V, MinCost] | _] , MinCost, V, NewBusStations) :-
    member(V, BusStations), !,
    assertz(used(V, MinCost)),
    delete(BusStations, V, NewBusStations).
get_current(BusStations, [ _ | Costs] , MinCost, V, NewBusStations) :-
    get_current(BusStations, Costs, MinCost, V, NewBusStations).

filtred_used_next(_, [], []).
filtred_used_next(BusStations, [ [U, W] | RawNext ], [ [U, W] | Next ]) :-
    member(U, BusStations),
    filtred_used_next(BusStations, RawNext, Next), !.
filtred_used_next(BusStations, [ _ | RawNext ], Next) :-
    filtred_used_next(BusStations, RawNext, Next).

update([], _, _,  _, []).
update([ [U, OldCost] | Costs ], V, CurCost, Next, [ [U, NewCost] | NewCosts ]) :-
    get_next(U, Next, W),
    NewCost is CurCost + W,
    OldCost > NewCost,
    update(Costs, V, CurCost, Next, NewCosts), !.
update([ OldCost | Costs ], V, CurCost, Next, [ OldCost | NewCosts ]) :-
    update(Costs, V, CurCost, Next, NewCosts).

get_next(_, [], _) :- !, fail.
get_next(U, [ [U, W] | _ ], W).
get_next(U, [ _ | Next ], W) :- get_next(U, Next, W).

make_path(_, _, []).
make_path(V, MinCost, [ [U, W] | Next ]) :-
    Maybe is MinCost + W,
    clause(used(U, Maybe), true),
    assertz(path(V, U)),
    make_path(V, MinCost, Next), !.
make_path(V, MinCost, [ _ | Next ]) :-
    make_path(V, MinCost, Next).
