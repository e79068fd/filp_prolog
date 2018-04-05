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

test :-
    show_stations([]),
    format("Set start station:~n",[]),
    get_station(Start, []),

    show_stations([Start]),
    format("Set end station:~n",[]),
    get_station(End, [Start]),

    write([Start, End]).

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
