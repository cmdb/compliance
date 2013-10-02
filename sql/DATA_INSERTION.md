# Data insertion HOWTO

## How to add data... From scratch !

`@data=...` means a foreign key reference to another table named _data_

Data should be added in tables order below to avoid missing required data in a
previous table (foreign key values).

### city
ex :

	name='Paris'

```SQL
INSERT INTO city (name) VALUES ('Paris');
```

### site
	ex :
		name='My server room 1'
		@city='Paris'
	If the id of 'Paris' is 5 :
	`INSERT INTO site (city, name) VALUES (5,'My server room 1');`
	or via a subquery :
	`INSERT INTO site (city, name) VALUES (
	(select id from city where name='Paris'),
	'My server room 1');`

### vendor
	ex :
		name='IBM'

### osarch
	ex :
		name='i386'
		name='i686'
		name='x86_64'
		name='arm'
		name='powerpc'

### os
	ex :
		@vendor='Microsoft'
		@vendor='Red Hat'
		@vendor='VMware'
		name='Windows'
		name='Linux Enterprise Server'
		name='ESXi'
		@arch='x86_64'
		version='2008 R2'
		version='5.3'

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

### environment
	ex :
		name='Test'
		name='Intégration'
		name='Recette'
		name='Production'

### machine
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

## Add data manually
TODO: Add an example in each table description above... 

## Add data from a Comma (,) Separated Values (CSV) file named devices.csv
like this two lines
`uuid,vendor,name,model,serial,cpu,os,environment,site
f7aaffb2-2771-11e3-8fd5-ebc0a12e8020,23,mymachine1,4,1010F,8,10,1,6
f7ab0412-2787-11e1-8fd6-53da8578c6f5,23,mymachine2,4,1010P,8,10,1,6`

`mysql> LOAD DATA INFILE 'devices.csv'
INTO TABLE machine 
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(uuid,vendor,name,model,serial,cpu,os,environment,site);`
