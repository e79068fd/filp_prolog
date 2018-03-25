%bus(bus_number, from, to, [distance, time, price]). % distance- км, time - минуты, from,to - station_number, price - рубли
bus(1, a, b, [10, 25, 18]).
bus(1, b, c, [10, 25, 18]).
bus(1, a, c, [10, 25, 18]).
bus(1, b, a, [10, 25, 18]).
bus(1, c, b, [10, 25, 18]).
bus(1, c, a, [10, 25, 18]).

bus(2, d, b, [10, 15, 20]).
bus(2, b, c, [10, 15, 20]).
bus(2, d, c, [10, 15, 20]).
bus(2, c, d, [10, 15, 20]).
bus(2, c, b, [10, 15, 20]).
bus(2, b, d, [10, 15, 20]).