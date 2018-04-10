find_path(BusStations, Start, Weights) :-
    findall([V, U, OriginCost], graph(V, U, OriginCost), Relations),
    fp_preparation_graph(Relations, Weights),
    fp_make_start_value(BusStations, RawCosts),
    fp_set_start_stations(Start, RawCosts, Costs),
    fp_dijkstra(BusStations, Costs),
    retractall(prepared_graph(_,_,_)).

fp_preparation_graph([], _).
fp_preparation_graph([ [V, U, OriginCost] | Relations], Weights) :-
    fp_scalarize_weights(OriginCost, Weights, TmpNormalazedCost),
    NormalazedCost is round(TmpNormalazedCost * 1000),
    assertz(prepared_graph(V, U, NormalazedCost)),
    fp_preparation_graph(Relations, Weights).

fp_scalarize_weights([], [], 0).
fp_scalarize_weights([C | OriginCost], [W | Weights], Result) :-
    fp_scalarize_weights(OriginCost, Weights, GetResult),
    Result is GetResult + C * W.

fp_make_start_value([], []).
fp_make_start_value([ V | BusStations ], [ [V, 1000000000] | Costs ]) :-
    fp_make_start_value(BusStations, Costs).

fp_set_start_stations(_, [], []).
fp_set_start_stations(Start, [ [ [Start, Number], _ ] | RawCosts ], [ [ [Start, Number], 0 ] | Costs ]) :-
    fp_set_start_stations(Start, RawCosts, Costs), !.
fp_set_start_stations(Start, [ Old | RawCosts], [ Old | Costs ]) :-
    fp_set_start_stations(Start, RawCosts, Costs).

fp_dijkstra([], _).
fp_dijkstra(BusStations, Costs) :-
    fp_find_current_min_cost(BusStations, Costs, 1000000000, MinCost),
    fp_get_current(BusStations, Costs, MinCost, V, NewBusStations),
    findall([U, W], prepared_graph(V, U, W), RawNext),
    fp_filtred_used_next(NewBusStations, RawNext, Next),
    fp_update(Costs, V, MinCost, Next, NewCosts),
    fp_dijkstra(NewBusStations, NewCosts),
    fp_make_path(V, MinCost, Next).

fp_find_current_min_cost(_, [], Result, Result).
fp_find_current_min_cost(BusStations, [ [V, _] | Costs ], Maybe, GetResult) :-
    \+ member(V, BusStations),
    fp_find_current_min_cost(BusStations, Costs, Maybe, GetResult), !.
fp_find_current_min_cost(BusStations, [ [_, C] | Costs ], Maybe, GetResult) :-
    C < Maybe,
    fp_find_current_min_cost(BusStations, Costs, C, GetResult), !.
fp_find_current_min_cost(BusStations, [ _ | Costs ], Maybe, GetResult) :-
    fp_find_current_min_cost(BusStations, Costs, Maybe, GetResult).

fp_get_current(_, [], _, _, _) :- !, fail.
fp_get_current(BusStations, [ [V, MinCost] | _] , MinCost, V, NewBusStations) :-
    member(V, BusStations), !,
    assertz(used(V, MinCost)),
    delete(BusStations, V, NewBusStations).
fp_get_current(BusStations, [ _ | Costs] , MinCost, V, NewBusStations) :-
    fp_get_current(BusStations, Costs, MinCost, V, NewBusStations).

fp_filtred_used_next(_, [], []).
fp_filtred_used_next(BusStations, [ [U, W] | RawNext ], [ [U, W] | Next ]) :-
    member(U, BusStations),
    fp_filtred_used_next(BusStations, RawNext, Next), !.
fp_filtred_used_next(BusStations, [ _ | RawNext ], Next) :-
    fp_filtred_used_next(BusStations, RawNext, Next).

fp_update([], _, _,  _, []).
fp_update([ [U, OldCost] | Costs ], V, CurCost, Next, [ [U, NewCost] | NewCosts ]) :-
    fp_get_next(U, Next, W),
    NewCost is CurCost + W,
    OldCost > NewCost,
    fp_update(Costs, V, CurCost, Next, NewCosts), !.
fp_update([ OldCost | Costs ], V, CurCost, Next, [ OldCost | NewCosts ]) :-
    fp_update(Costs, V, CurCost, Next, NewCosts).

fp_get_next(_, [], _) :- !, fail.
fp_get_next(U, [ [U, W] | _ ], W).
fp_get_next(U, [ _ | Next ], W) :- fp_get_next(U, Next, W).

fp_make_path(_, _, []).
fp_make_path(V, MinCost, [ [U, W] | Next ]) :-
    Maybe is MinCost + W,
    clause(used(U, Maybe), true),
    assertz(path(V, U)),
    fp_make_path(V, MinCost, Next), !.
fp_make_path(V, MinCost, [ _ | Next ]) :-
    fp_make_path(V, MinCost, Next).
