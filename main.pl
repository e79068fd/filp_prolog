:- include('make_graph.pl').
:- include('find_path.pl').
:- include('make_answer.pl').

:- include('bd.pl').


main :-
    make_graph(BusStations),
    write(BusStations),nl,
    Start = 1,
    End = 4,
    Weights = [0.5, 0.5, 0.5],
    find_path(BusStations, Start, Weights),
    make_answer(Start, End, Result),
    write(Result).