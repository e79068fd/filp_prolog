%bus(bus_number, [first, secon4, ..., end]). first, secon4, ..., end - остановки
bus(1, [1, 2, 3, 2, 1]).
bus(2, [4, 2, 3, 2, 4]).
bus(3, [1, 3, 2, 3, 1]).
bus(4, [4, 3, 2, 3, 4]).

%station(from, to, [distance, time]) % distance - километры, time - минуты
station(1, 2, [10, 35]).
station(2, 1, [10, 35]).
station(2, 3, [10, 25]).
station(3, 2, [10, 25]).
station(1, 3, [10, 45]).
station(3, 1, [10, 45]).
station(4, 3, [10, 15]).
station(3, 4, [10, 15]).
station(4, 2, [10, 15]).
station(2, 4, [10, 15]).

station_name(1, a).
station_name(2, b).
station_name(3, c).
station_name(4, d).