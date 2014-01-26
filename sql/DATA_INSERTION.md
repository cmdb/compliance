# Data insertion HOWTO

## How to add data... From scratch !

`@data=...` means a foreign key reference to another table named _data_

Data should be added in tables order below to avoid missing required data in a
previous table (foreign key values).

### city
	ex :
		name='Paris'

```SQL
mysql> INSERT INTO city (name) VALUES ('Paris');
```

### site
	ex :
	name='My server room 1'
	@city='Paris'

If city.id of 'Paris' is 5 :
```SQL
mysql> INSERT INTO site (city, name) VALUES (5,'My server room 1');
```
or via a subquery :
```SQL
mysql> INSERT INTO site (city, name) VALUES (
	(SELECT id FROM city WHERE name='Paris'),
	'My server room 1');
```

### vendor
	ex :
		name='IBM'

```SQL
mysql> INSERT INTO vendor (name) VALUES ('IBM');
```

### osarch
	ex :
		name='i386'
		name='i686'
		name='x86_64'
		name='arm'
		name='powerpc'

```SQL
mysql> INSERT INTO osarch (name) VALUES ('powerpc');
```

### os
	ex :
	@vendor='Microsoft'
	@vendor='Red Hat'
	@vendor='VMware'
	@vendor='Debian'

	name='Windows'
	name='GNU/Linux'
	name='ESXi'

	version='2008 R2'
	version='7.0'

	@arch='x86_64'
	@arch='64 Bits'

To insert "Debian GNU/Linux 7.0 x86_64" :
If vendor.id of 'Debian' is 3.
If osarch.id of 'x86_64' is 5.

```SQL
mysql> INSERT INTO os (vendor, name, version, arch)
VALUES (3, 'GNU/Linux', '7.0', 5);
```
or via a subquery :
```SQL
mysql> INSERT INTO os (vendor, name, version, arch)
VALUES (
(SELECT id from vendor where name='Debian'),
'GNU/Linux',
'7.0',
(SELECT id from osarch where name='x86_64'));
```

### cpu
	ex :
	@vendor='Intel'
	name='Xeon CPU E5-2660'
	arch='64'
	cores='8'
	htfactor='2'
	frequency='2.20'

### model
	ex :
	name='ProLiant BL460c Gen8'

```SQL
mysql> INSERT INTO model (name) VALUES ('ProLiant BL460c Gen8');
```

### environment
	ex :
	name='Test'
	name='Intégration'
	name='Recette'
	name='Production'

```SQL
mysql> INSERT INTO environment (name) VALUES ('Test');
```

### device
	ex :
	@vendor='HP'
	name='shortname'
	@model='ProLiant BL460c Gen8'
	serial='xxxxXXXXnnnn'
	cpucount='2'
	@cpu=...
	ram='192'
	@os=...
	@environment=...
	@site=...

	`insert into device
	(uuid,vendor,name,model,serial,cpucount,cpu,ram,os,environment,site)
	values (
	'3bb47106-3e84-11e3-bb1e-00224d87d9e1',
	(select id from vendor where name='HP' limit 1),
	'shortname',
	(select id from model where name like 'proliant%460c' limit	1),
	'xxxxXXXXnnnn',
	2,
	(select id from cpu where name='Xeon CPU' limit 1),
	'192',
	(select id from os where name='ESXi' limit 1),
	(select id from environment where name='Production' limit 1),
	(select id from site where name='My server room 1' limit 1)
	);`

## Add data from a Comma (,) Separated Values (CSV) file named devices.csv
like these lines
`uuid,vendor,name,model,serial,cpu,os,environment,site
f7aaffb2-2771-11e3-8fd5-ebc0a12e8020,23,mymachine1,4,1010F,8,10,1,6
f7ab0412-2787-11e1-8fd6-53da8578c6f5,23,mymachine2,4,1010P,8,10,1,6`

`mysql> LOAD DATA INFILE 'devices.csv'
INTO TABLE device 
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(uuid,vendor,name,model,serial,cpu,os,environment,site);`
