%bus (bus_number, [first, secon4, ..., end]). first, secon4, ..., end - остановки
bus(2, [17, 15, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 15, 17]).
bus(3, [17, 15, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 15, 17]).
bus(4, [16, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 16]).
%bus(5, [16, 1, 2, 3, 4, 12, 13, 19]).
bus(5, [19, 14, 18, 12, 4, 3, 1, 16]).
bus(12, [16, 1, 2, 3, 4, 5, 6, 7, 9, 10, 9, 6, 5, 4, 3, 1, 16]).
bus(16, [16, 1, 2, 3, 4, 12, 13, 19]).
%bus(16, [14, 18, 12, 4, 3, 1, 16]).
%bus(19, [16, 1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 1, 16]).
bus(22, [17, 15, 1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 1, 15, 17]).

bus(10, []).
bus(11, []).
bus(24, []).

%bus(23, []).
%bus(25, []).
%bus(26, []).
%bus(29, []).
%bus(30, []).
%bus(31, []).
%bus(32, []).
%bus(52, []).
%bus(60, []).
%bus(101, []).
%bus(112, []).
%bus(118, []).
%bus(131, []).
%bus(150, []).
%bus(400, []).
%bus(442, []).
%bus(444, []).

%station (from, to, [distance, time]) % distance - километры, time - минуты
station(1, 16, [0.44, ?]).
station(1, 15, [0.4, ?]).
station(1, 2, [0.3, ?]).

station(2, 3, [0.5, ?]).

station(3, 1, [1, ?]).
station(3, 4, [0.5, ?]).

station(4, 12, [0.25, ?]).
station(4, 3, [0.28, ?]).
station(4, 5, [0.36, ?]).

station(5, 4, [0.6, ?]).
station(5, 12, [0.3, ?]).
station(5, 6, [0.45, ?]).

station(6, 5, [0.53, ?]).
station(6, 7, [0.36, ?]).

station(7, 8, [0.43, ?]).
station(7, 9, [0.42, ?]).

station(8, 6, [0.8, ?]).

station(9, 6, [0.56, ?]).
station(9, 10, [0.48, ?]).
station(10, 9, [0.57, ?]).

station(12, 4, [0.44, ?]).
station(12, 13, [0.5, ?]).
station(12, 5, [0.1, ?]).

station(14, 18, [0.4, ?]). ????

station(15, 1, [0.5, ?]).
station(15, 16, [0.7, ?]).
station(15, 17, [0.6, ?]).

station(16, 1, [0.4, ?]).
station(16, 15, [0.17, ?]).

station(17, 15, [0.8, ?]).

station(18, 12, [0.5, ?]).

station(13, 19, [0.5, ?]).
station(19, 14, [0.8, ?]).

station(20, 10, [1.2, ?]).
station(20, 21, [1.2, ?]).
station(20, 22, [1.2, ?]).
station(20, 28, [1.2, ?]).

station(21, 20, [1.2, ?]).
station(21, 28, [1, ?]).

station(22, 20, [1.2, ?]).
station(22, 23, [0.8, ?]).

station(23, 22, [0.8, ?]).
station(23, 10, [1.1, ?]).
station(23, 24, [1.4, ?]).

station(24, 23, [1.4, ?]).
station(24, 14, [1.2, ?]).
station(24, 25, [1, ?]).

station(25, 24, [1, ?]).
station(25, 26, [0.9, ?]).

station(26, 25, [0.9, ?]).
station(26, 14, [1.3, ?]).
station(26, 27, [1.4, ?]).

station(27, 26, [1.4, ?]).
station(27, 17, [1.5, ?]).

station(28, 21, [1, ?]).
station(28, 20, [1.2, ?]).
station(28, 8, [0.5, ?]).

station_name(1, cum).
station_name(2, pl_lenina).
station_name(3, tuz).
station_name(4, glavpochtampt).
station_name(5, pl_novosovornaya).
station_name(6, tgu).
station_name(7, biblioteka_tgu).
station_name(8, temz). ??
station_name(9, tpu).
station_name(10, zc_octyabr). ??
station_name(12, kraevedcheski_musei).
station_name(13, gogol).
station_name(14, krasnoarmeiskaya). ??
station_name(15, ost_1905_goda).
station_name(16, rechnoi_voksal).
station_name(17, tgasu). ??
station_name(18, belinskogo).
station_name(19, tverskaya).

station_name(20, transpotnoe_kolco).
station_name(21, lagernij_sad).
station_name(22, tomsk1).
station_name(23, pl_kirova).
station_name(24, pr_komsomolsij).
station_name(25, sibirskya_komsomolsij).
station_name(26, sibirskya_krasnoarmeiskaya).
station_name(27, dom_radio).
station_name(28, uchebaya).