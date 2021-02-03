# Dell-test
Программа получает на вход в качестве аргументов список названий файлов, содержащих данные,через пробел.<br />
Команда может выглядеть следующим образом: <br />
     perl test.pm example_part1 example_part2<br />
Файлы должны иметь данные вида:<br />
	DD.MM.YYYY HH:MM:SS NAME: STATUS <br />
	DD.MM.YYYY HH:MM:SS SYSTEM START <br />
где:<br />
	DD.MM.YYYY – дата в формате день.месяц.год <br />
	HH:MM:SS – время в формате часы:минуты:секунды <br />
	NAME – имя ресурса <br />
	STATUS – статус ресурса, может принимать значения: START STARTED (начало запуска), START COMPLETE (запуск завершен), STOP STARTED (начало завершения работы), STOP COMPLETE (окончание завершения работы). Ресурс может аварийно завершить свою работу в любой момент времени.    
SYSTEM START – отмечает начало работы системы после перезагрузки.<br />
Содержимое файлов выглядит следующим образом:<br />
	12.04.2015 12:34:46 SYSTEM START<br />
	12.04.2015 12:34:46 A: START STARTED<br />
	12.04.2015 12:34:47 B: START STARTED<br />
	12.04.2015 12:34:48 B: START COMPLETE<br />
	12.04.2015 12:34:49 A: START COMPLETE<br />
	12.04.2015 12:34:50 C: START STARTED<br />
	12.04.2015 12:34:51 A: STOP STARTED<br />
	12.04.2015 12:34:52 A: STOP COMPLETE<br />
	12.04.2015 12:34:55 SYSTEM START<br />
Программа анализирует файлы и выдает анализ вида:<br />
	Start 1: <br />
	A started 3 seconds <br />
	A stopped 1 second<br />
	B started 1 second<br />
	C start didn’t end<br />
	Start 2: <br />
то есть информацию о том, как долго длился запуск и остановка ресурса, и какие ресурсы не смогли завершить свои процессы запуска или остановки до перезагрузки системы.
Данные файлов аналиизируются последовательно как распределенные между ресурсами, указанными в аргументах программы.
