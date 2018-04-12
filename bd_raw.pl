%bus (bus_number, [first, secon4, ..., end]). first, secon4, ..., end - остановки
bus(2, [16, 14, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 14, 17]).
bus(3, [16, 14, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 14, 17]).

bus(5, [15, 1, 2, 3, 4, 11, 12, 19]).
bus(5, [18, 13, 17, 11, 4, 3, 1, 16]).

bus(19, [15, 1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 1, 16]).
bus(22, [16, 14, 1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 1, 14, 17]).

bus(10, []).
bus(11, []).
bus(24, []).
bus(119, []).
bus(26, []).
bus(29, []).

bus(25, []).
bus(52, []).


%station (from, to, [distance, time]) % distance - километры, time - минуты
station(1, 15, [0.44, ?]).
station(1, 14, [0.4, ?]).
station(1, 2, [0.3, ?]).

station(2, 3, [0.5, ?]).

station(3, 1, [1, ?]).
station(3, 4, [0.5, ?]).

station(4, 11, [0.24, ?]).
station(4, 3, [0.27, ?]).
station(4, 5, [0.36, ?]).

station(5, 4, [0.6, ?]).
station(5, 11, [0.3, ?]).
station(5, 6, [0.45, ?]).

station(6, 5, [0.53, ?]).
station(6, 7, [0.36, ?]).

station(7, 8, [0.43, ?]).
station(7, 9, [0.42, ?]).

station(8, 6, [0.8, ?]).
station(8, 27, [0.5, ?]).

station(9, 6, [0.56, ?]).
station(9, 10, [0.48, ?]).

station(10, 9, [0.57, ?]).
station(10, 13, [1.1, ?]).
station(10, 19, [1.4, ?]).
station(10, 22, [1.1, ?]).

station(11, 4, [0.44, ?]).
station(11, 12, [0.5, ?]).
station(11, 5, [0.1, ?]).

station(13, 10, [1.1, ?]).
station(13, 17, [0.4, ?]).
station(13, 23, [0.9, ?]).
station(13, 25, [0.7, ?]).

station(14, 1, [0.5, ?]).
station(14, 15, [0.7, ?]).
station(14, 16, [0.6, ?]).

station(15, 1, [0.4, ?]).
station(15, 14, [0.16, ?]).

station(16, 14, [0.8, ?]).
station(16, 26, [0.6, ?]).

station(17, 11, [0.5, ?]).

station(12, 18, [0.5, ?]).
station(18, 13, [0.8, ?]).

station(19, 10, [1.4, ?]).
station(19, 20, [1.5, ?]).
station(19, 21, [1.2, ?]).
station(19, 27, [1.7, ?]).

station(20, 19, [1.5, ?]).
station(20, 27, [0.4, ?]).

station(21, 19, [1.2, ?]).
station(21, 22, [0.8, ?]).

station(22, 21, [0.8, ?]).
station(22, 10, [1.1, ?]).
station(22, 23, [1.0, ?]).

station(23, 22, [1.0, ?]).
station(23, 13, [0.9, ?]).
station(23, 24, [0.7, ?]).

station(24, 23, [0.7, ?]).
station(24, 25, [0.9, ?]).

station(25, 24, [0.9, ?]).
station(25, 13, [1.3, ?]).
station(25, 26, [1.8, ?]).

station(26, 25, [1.8, ?]).
station(26, 16, [0.6, ?]).

station(27, 20, [0.4, ?]).
station(27, 19, [1.7, ?]).
station(27, 8, [0.5, ?]).

station_name(1, cum).
station_name(2, pl_lenina).
station_name(3, tuz).
station_name(4, glavpochtampt).
station_name(5, pl_novosovornaya).
station_name(6, tgu).
station_name(7, biblioteka_tgu).
station_name(8, temz).
station_name(9, tpu).
station_name(10, zc_octyabr).
station_name(11, kraevedcheski_musei).
station_name(12, gogol).
station_name(13, krasnoarmeiskaya).
station_name(14, ost_1905_goda).
station_name(15, rechnoi_voksal).
station_name(16, tgasu).
station_name(17, belinskogo).
station_name(18, tverskaya).
station_name(19, transpotnoe_kolco).
station_name(20, lagernij_sad).
station_name(21, tomsk1).
station_name(22, pl_kirova).
station_name(23, pr_komsomolsij).
station_name(24, sibirskya_komsomolsij).
station_name(25, sibirskya_krasnoarmeiskaya).
station_name(26, dom_radio).
station_name(27, uchebaya).
