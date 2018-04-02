%bus(bus_number, [first, second, ..., end]). first, second, ..., end - остановки
bus(1, [a, b, c, b, a]).
bus(2, [d, b, c, b, d]).

%station(from, to, [distance, time]) % distance - километры, time - минуты
station(a, b, [10, 35]).
station(b, a, [10, 35]).
station(b, c, [10, 25]).
station(c, b, [10, 25]).
station(a, c, [10, 45]).
station(c, a, [10, 45]).
station(d, c, [10, 15]).
station(c, d, [10, 15]).
station(d, b, [10, 15]).
station(b, d, [10, 15]).