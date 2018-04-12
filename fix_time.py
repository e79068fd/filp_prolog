input_file = open('bd_raw.pl', 'r')
output_file = open('bd.pl', 'w')

speed = 40 / 60  # 40km/hour
add_time = 2

for line in input_file:
    if line.find('station(') != -1:
        section = line[line.find('[') + 1:line.find(']')]
        dist = float(section[0:section.find(',')])
        time = dist / speed + add_time
        line = line.replace(section, '{:.2f}, {:.2f}'.format(dist, time))
    output_file.write(line)

input_file.close()
output_file.close()
