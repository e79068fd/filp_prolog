%:- include('bd.pl').

make_graph(BusStations) :-
    findall(Weights, station(_,_,Weights), WeightsList),
    mg_find_max_weights(WeightsList, MaxWeights),
    findall([Number, Chain], bus(Number, Chain), BusList),
    mg_make_first_wave_graph_node(BusList, MaxWeights, BusStations),
    mg_make_second_wave_graph_node(BusStations).

% mg_find_max_weights(WeightsList, MaxWeights)
mg_find_max_weights([], [0, 0]).
mg_find_max_weights([ [Dist, Time] | WeightsList], [MaxDist, MaxTime]) :-
    mg_find_max_weights(WeightsList, [PrevDist, PrevTime]),
    MaxDist is max(Dist, PrevDist),
    MaxTime is max(Time, PrevTime).


% mg_make_first_wave_graph_node(BusList, MaxWeights, BusStations).
mg_make_first_wave_graph_node([], _, []) :- !.
mg_make_first_wave_graph_node([ [Number, Chain] | BusList], MaxWeights, BusStations) :-
    mg_make_first_wave_graph_node(BusList, MaxWeights, GetOtherBusStations),
    mg_make_first_node(Number, Chain, MaxWeights, GetCurrentBusStations),
    append(GetCurrentBusStations, GetOtherBusStations, BusStations).

mg_make_first_node(_, [_], _, []) :- !.
mg_make_first_node(Number, [From, To | Chain], MaxWeights, BusStations) :-
    mg_make_first_node(Number, [To | Chain], MaxWeights, GetBusStations),
    V = [From, Number],
    U = [To, Number],
    station(From, To, Weights),
    mg_normalized_weights(Weights, MaxWeights, NormalizedWeights),
    assertz(graph(V, U, NormalizedWeights)),
    mg_add_bus_station(V, GetBusStations, TmpBusStations),
    mg_add_bus_station(U, TmpBusStations, BusStations), !.

mg_normalized_weights([], [], [0]). % 0 - это переход цена перехода между автобусами
mg_normalized_weights([W | Weights], [MW | MaxWeights], [NW | NormalizedWeights]) :-
    mg_normalized_weights(Weights, MaxWeights, NormalizedWeights),
    NW is W / MW.

mg_add_bus_station(BusStation, OldBusStations, [BusStation | OldBusStations]) :-
    \+ member(BusStation, OldBusStations), !.
mg_add_bus_station(_, OldBusStations, OldBusStations).

mg_make_second_wave_graph_node([]).
mg_make_second_wave_graph_node([ BusStation | BusStations]) :-
    mg_make_second_wave_graph_node(BusStations),
    mg_make_bus_relations_in_same_stations(BusStation, BusStations), !.

%mg_make_bus_relations_in_same_stations(Station, BusStataions)
mg_make_bus_relations_in_same_stations(_, []).
mg_make_bus_relations_in_same_stations([Station, FirstNumber], [ [Station, SecondNumber] | BusStataions ]) :-
    assertz(graph([Station, FirstNumber], [Station, SecondNumber], [0, 0, 1])),
    assertz(graph([Station, SecondNumber], [Station, FirstNumber], [0, 0, 1])),
    mg_make_bus_relations_in_same_stations([Station, FirstNumber], BusStataions), !.
mg_make_bus_relations_in_same_stations(BusStation, [_ | BusStations]) :-
    mg_make_bus_relations_in_same_stations(BusStation, BusStations).