make_graph(BusStations) :-
    findall(Weights, bus(_,_,_,Weights), WeightsList),
    find_max_weights(WeightsList, MaxWeights),
    findall([Number, From, To, Weights], bus(Number, From, To, Weights), BusList),
    make_first_wave_graph_node(BusList, MaxWeights, BusStations),
    make_second_wave_graph_node(BusStations).

% find_max_weights(WeightsList, MaxWeights)
find_max_weights([], [0, 0, 0]).
find_max_weights([ [Dist, Time, Price] | WeightsList], [MaxDist, MaxTime, MaxPrice]) :-
    find_max_weights(WeightsList, [PrevDist, PrevTime, PrevPrice]),
    MaxDist is max(Dist, PrevDist),
    MaxTime is max(Time, PrevTime),
    MaxPrice is max(Price, PrevPrice).


% make_first_wave_graph_node(BusList, MaxWeights, BusStations).
make_first_wave_graph_node([], _, []).
make_first_wave_graph_node([ [Number, From, To, Weights] | BusList], MaxWeights, BusStations) :-
    make_first_wave_graph_node(BusList, MaxWeights, GetBusStations),
    V = [From, Number],
    U = [To, Number],
    normalized_weights(Weights, MaxWeights, NormalizedWeights),
    assertz(graph(V, U, NormalizedWeights)),
    add_bus_station(V, GetBusStations, TmpBusStations),
    add_bus_station(U, TmpBusStations, BusStations).

normalized_weights([], [], [0]). % 0 - это переход цена перехода между автобусами
normalized_weights([W | Weights], [MW | MaxWeights], [NW | NormalizedWeights]) :-
    normalized_weights(Weights, MaxWeights, NormalizedWeights),
    NW is W / MW.

add_bus_station(BusStation, OldBusStations, [BusStation | OldBusStations]) :-
    \+ member(BusStation, OldBusStations), !.
add_bus_station(_, OldBusStations, OldBusStations).

make_second_wave_graph_node([]).
make_second_wave_graph_node([ BusStation | BusStations]) :-
    make_second_wave_graph_node(BusStations),
    make_bus_relations_in_same_stations(BusStation, BusStations).

%make_bus_relations_in_same_stations(Station, BusStataions)
make_bus_relations_in_same_stations(_, []).
make_bus_relations_in_same_stations([Station, FirstNumber], [ [Station, SecondNumber] | BusStataions ]) :-
    assertz(graph([Station, FirstNumber], [Station, SecondNumber], [0, 0, 0, 1])),
    assertz(graph([Station, SecondNumber], [Station, FirstNumber], [0, 0, 0, 1])),
    make_bus_relations_in_same_stations([Station, FirstNumber], BusStataions), !.
make_bus_relations_in_same_stations(BusStation, [_ | BusStations]) :-
    make_bus_relations_in_same_stations(BusStation, BusStations).