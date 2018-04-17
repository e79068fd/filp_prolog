:- include('make_graph.pl').
:- include('find_path.pl').
:- include('make_answer.pl').

:- include('bd.pl').


main :-
    make_graph(BusStations),

    show_stations([]),
    format("Выбрать стартовую остановку:~n",[]),
    get_station(Start, []),

    show_stations([Start]),
    format("Выбрать конечную остановку:~n",[]),
    get_station(End, [Start]),

    format("Установить веса. Формат весов [Растояние, Время, Пересадки], где Растояние, Время, Пересадки это целые положительные числа.~n",[]),
    get_weights(Weights),

    find_path(BusStations, Start, Weights),
    make_answer(Start, End),
    findall([AllDist, AllTime, Changes, Result], answer(AllDist, AllTime, Changes, Result), Answers),
    show_answer(Answers),
    retractall(answer(_,_,_,_)),
    retractall(used(_,_)),
    retractall(path(_,_)),
    retractall(graph(_,_,_)), !.

show_stations(Ignore) :-
    format("Список станций:~n", []),
    station_name(ID, Name),
    \+ member(ID, Ignore),
    format("~d ~a~n", [ID, Name]),
    fail;true.

try_get(Term, Validator) :-
    catch(read(Term), _, fail),
    call_with_args(Validator, Term), ! ;
    format("Некорректный ввод. Повторить ввод!~n", []),
    try_get(Term, Validator).

get_station(Station, Ignore) :-
    try_get(Station, number),
    \+ member(Station, Ignore),
    station_name(Station, _), ! ;
    format("Выбран некорректный номер остановки. Повторить ввод!~n", []),
    get_station(Station, Ignore).

get_weights(Weights) :-
    try_get(RawWeights, checker_weights),
    length(RawWeights, L), L = 3,
    sum_list(RawWeights, Sum),
    normalization_weights(RawWeights, Sum, Weights), ! ;
    format("Установленны некорректные веса. Повторить ввод!~n", []),
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

show_answer([]).
show_answer([ [AllDist, AllTime, Changes, Results] | Answers]) :-
    show_answer(Answers),
    format("~nВсе растояние: ~2f(км); Все время: ~2f(минут); Количество пересадок: ~d~n", [AllDist, AllTime, Changes]),
    show_result(Results).

show_result([]).
show_result([ [Number, Start, End, [Dist, Time]] | Results ]) :-
    show_result(Results),
    station_name(Start, StartName),
    station_name(End, EndName),
    format("На автобусной остановке ~a сесть на автобус №~d доехать до остановки ~a. Растояние ~2f(км) Время ~2f(минут)~n", [StartName, Number, EndName, Dist, Time]).
