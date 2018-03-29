make_graph(BusStations) :-
    findall(Weights, bus(_,_,_,Weights), WeightsList),
    mg_find_max_weights(WeightsList, MaxWeights),
    findall([Number, From, To, Weights], bus(Number, From, To, Weights), BusList),
    mg_make_first_wave_graph_node(BusList, MaxWeights, BusStations),
    mg_make_second_wave_graph_node(BusStations).

% mg_find_max_weights(WeightsList, MaxWeights)
mg_find_max_weights([], [0, 0, 0]).
mg_find_max_weights([ [Dist, Time, Price] | WeightsList], [MaxDist, MaxTime, MaxPrice]) :-
    mg_find_max_weights(WeightsList, [PrevDist, PrevTime, PrevPrice]),
    MaxDist is max(Dist, PrevDist),
    MaxTime is max(Time, PrevTime),
    MaxPrice is max(Price, PrevPrice).


% mg_make_first_wave_graph_node(BusList, MaxWeights, BusStations).
mg_make_first_wave_graph_node([], _, []).
mg_make_first_wave_graph_node([ [Number, From, To, Weights] | BusList], MaxWeights, BusStations) :-
    mg_make_first_wave_graph_node(BusList, MaxWeights, GetBusStations),
    V = [From, Number],
    U = [To, Number],
    mg_normalized_weights(Weights, MaxWeights, NormalizedWeights),
    assertz(graph(V, U, NormalizedWeights)),
    mg_add_bus_station(V, GetBusStations, TmpBusStations),
    mg_add_bus_station(U, TmpBusStations, BusStations).

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
    mg_make_bus_relations_in_same_stations(BusStation, BusStations).

%mg_make_bus_relations_in_same_stations(Station, BusStataions)
mg_make_bus_relations_in_same_stations(_, []).
mg_make_bus_relations_in_same_stations([Station, FirstNumber], [ [Station, SecondNumber] | BusStataions ]) :-
    assertz(graph([Station, FirstNumber], [Station, SecondNumber], [0, 0, 0, 1])),
    assertz(graph([Station, SecondNumber], [Station, FirstNumber], [0, 0, 0, 1])),
    mg_make_bus_relations_in_same_stations([Station, FirstNumber], BusStataions), !.
mg_make_bus_relations_in_same_stations(BusStation, [_ | BusStations]) :-
    mg_make_bus_relations_in_same_stations(BusStation, BusStations).