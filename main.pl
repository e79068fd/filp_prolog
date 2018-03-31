:- include('make_graph.pl').
:- include('find_path.pl').

:- include('bd.pl').


main :-
    make_graph(BusStations),
    write(BusStations),
    Start = a,
    End = d,
    Weights = [0.5, 0.5, 0.5],
    find_path(BusStations, Start, Weights).