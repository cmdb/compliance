# HOW TO HANDLE HISTORY

The _device_ table contains one unique line per device (the actual state). The
_devicehistory_ table handle devices history.

- The _device_ table contains only 'living' devices.
- Devices end of life is visible : last state of device is kept in
  _devicehistory_ table and the device is removed from _device_ table.
  Equivalent to move device row from _device_ to _devicehistory_.

## Device creation
- Insert data in both tables _device_ and _devicehistory_. Device start of life
  is in the _devicehistory_ and device actual state in the _device_ table. the
  two lines are the same because there was no modifications at this time. After
  each creation, devicehistory table MUST be updated with the new created
  device(s) by issuing a insert...select query (this query can be run anytime
  safely !).

```SQL
> INSERT IGNORE INTO devicehistory SELECT * FROM device;
```

This previous query can be run anytime safely !

## Device modification
- Modify _device_ table row.
  Ex : suppose you have a server with these data...

```SQL
> select id,name,cpucount,ram,timestamp from device where name = 'myserver';
```

```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
+----+----------+----------+------+---------------------+
```

First ensure that there is already a line in devicehistory with previous data...

```SQL
> select id,name,cpucount,ram,timestamp from devicehistory where name = 'myserver';
```

```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
+----+----------+----------+------+---------------------+
```

Looks OK. If not :

```SQL
> INSERT IGNORE INTO devicehistory SELECT * FROM device;
```

Now suppose that Today at 12:00 you upgraded this server from 2 to 4 cpus and 64 to 196 GB RAM.

```SQL
> update device set cpucount=4,ram=196,timestamp='2013-12-17 12:00:00' where name = 'myserver';
```

- Copy the modified row from _device_ table to _devicehistory_. The
unique key is id+timestamp so there won't be duplicates.

```SQL
> insert into devicehistory select * from device where name = 'myserver';
```
or
```SQL
> INSERT IGNORE INTO devicehistory SELECT * FROM device;
```

Verify

```SQL
> select id,name,cpucount,ram,timestamp from devicehistory where name = 'myserver';
```

```
+----+----------+----------+------+---------------------+
| id | name     | cpucount | ram  | timestamp           |
+----+----------+----------+------+---------------------+
| 55 | myserver |        2 |   64 | 2010-06-21 14:40:00 |
| 55 | myserver |        4 |  196 | 2013-12-17 12:00:00 |
+----+----------+----------+------+---------------------+
```

## Device suppression (end of life)
- Update _device_ row timestamp with the end of life date.

```SQL
> update device set timestamp='YYYY-MM-DD hh:mm:ss' where name = 'myserver';
```

- Move this modified row from _device_ table to _devicehistory_ table. The
  device is no more in the _device_ table but its history is visible in the
  _devicehistory_ table. the end-of-life date is the last timestamp in the
  _devicehistory_ table.

## Temporary device deactivation
For example, you shutdown a device and keep it for a later use, so you remove
the name, the os and the environment values.

```SQL
> update device set name=null, os=null, environment=null, timestamp = 'YYYY-MM-DD hh:mm:ss' where device.name = 'myserver';
```
