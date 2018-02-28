:- dynamic(graph/3).
graph( [a, 1], [b, 1], 2).
graph( [b, 1], [c, 1], 2).
graph( [a, 1], [c, 1], 2).
graph( [c, 1], [a, 1], 2).
graph( [c, 1], [b, 1], 2).
graph( [b, 1], [a, 1], 2).

graph( [b, 1], [b, 2], 1).
graph( [b, 2], [b, 1], 1).
graph( [c, 1], [c, 2], 1).
graph( [c, 2], [c, 1], 1).

graph( [d, 2], [b, 2], 2).
graph( [b, 2], [c, 2], 2).
graph( [d, 2], [c, 2], 2).
graph( [c, 2], [d, 2], 2).
graph( [c, 2], [b, 2], 2).
graph( [b, 2], [d, 2], 2).

main :- BusStations = [ [a, 1], [b, 1], [b, 2], [c, 1], [c, 2], [d, 2] ],
    make_start_value(BusStations, RawCosts, RawPath),
    set_start_stations(a, RawCosts, Costs),
    path_find(BusStations, Costs, RawPath, Path), write(Path).

test :- clause(graph( [a, 1], [b, 1], 1), true).

make_start_value([], [], []).
make_start_value([ V | BusStations ], [ [V, 1000000000] | Costs ], [ [ V, V ] | Path ]) :-
    make_start_value(BusStations, Costs, Path).

set_start_stations(_, [], []).
set_start_stations(Start, [ [ [Start, Number], _ ] | RawCosts ], [ [ [Start, Number], 0 ] | Costs ]) :-
    set_start_stations(Start, RawCosts, Costs), !.
set_start_stations(Start, [ Old | RawCosts], [ Old | Costs ]) :-
    set_start_stations(Start, RawCosts, Costs).

%dijkstra
path_find([], _, Path, Path).
path_find(BusStations, Costs, Path, GetPath) :-
    find_current_min_cost(BusStations, Costs, 1000000000, MinCost),
    get_current(BusStations, Costs, MinCost, V, NewBusStations),
    findall([U, W], graph(V, U, W), RawNext),
    filtred_used_next(NewBusStations, RawNext, Next),
    update(Costs, Path, V, MinCost, Next, NewCosts, NewPath),
    path_find(NewBusStations, NewCosts, NewPath, GetPath),
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

%get_current(BusStations, Costs, MinCost, V, NewBusStations)
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

%update( _,  _, _, _, [],  _,  _) :- !, fail.
update([], [], _, _,  _, [], []).
update([ [U, OldCost] | Costs ], [ _ | Path], V, CurCost, Next, [ [U, NewCost] | NewCosts ], [ [U, V] | NewPath ]) :-
    get_next(U, Next, W),
    NewCost is CurCost + W,
    OldCost > NewCost,
    update(Costs, Path, V, CurCost, Next, NewCosts, NewPath), !.
update([ OldCost | Costs ], [ OldPath | Path ], V, CurCost, Next, [ OldCost | NewCosts ], [ OldPath | NewPath ]) :-
    update(Costs, Path, V, CurCost, Next, NewCosts, NewPath).

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
