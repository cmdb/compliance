# HOW TO HANDLE HISTORY

The _device_ table contains one unique line per device (the actual state).  The
_devicehistory_ table handle devices history.
		- The _device_ table contains only 'living' devices.
		- Devices end of life is visible : last state of device is kept in
		  _devicehistory_ table and the device is removed from _device_ table
		  (equals move device row from _device_ to _devicehistory_).

	- Device creation :
	  Data insertion both in the tables _device_ and _devicehistory_. Device
	  start of life is in the _devicehistory_ and device actual state in the
	  _device_ table. the two lines are the same because there was no
	  modifications at this time.
	- Device modification :
		- Modify _device_ table row.
		  Ex : suppose you have a server with these data...
```SQL
mysql> select id,name,cpucount,ram,timestamp from device where name = 'myserver';
```
```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
+----+----------+----------+------+---------------------+
```
			- First ensure that data is already in devicehistory with previous data...
```SQL
mysql> select id,name,cpucount,ram,timestamp from devicehistory where name = 'myserver';
```
```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
+----+----------+----------+------+---------------------+
```
		  Looks OK. Today at 12:00 you upgraded this server from 2 to 4 cpus and 64 to 196
		  GB RAM.
```SQL
mysql> update device set cpucount=4,ram=196,timestamp='2013-12-17 12:00:00' where name = 'myserver';
```
		- Copy the modified row from _device_ table to _devicehistory_. The
		  unique key is id+timestamp so there won't be duplicates
```SQL
mysql> insert into devicehistory select * from device where name = 'myserver';
```
		Verification :
```SQL
mysql> select id,name,cpucount,ram,timestamp from devicehistory where name = 'myserver';
```
```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
| 55 | myserver |        4 |  196 | 2013-12-17 12:00:00 |
+----+----------+----------+------+---------------------+
```

	- Device suppression (end of life) :
		- Update _device_ row timestamp with the end of life date.
		- Move this modified row from _device_ table to _devicehistory_ table.
		the device is no more in the _device_ table but its history is visible
		in the _devicehistory_ table.
