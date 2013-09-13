# Data insertion HOWTO

How to add data... From scratch !

`@data=...` means a foreign key reference to another table named _data_

##### city

	ex :
		name='Paris'

##### site
	ex :
		name='Mon site principal'
		@city='Paris'

##### vendor
	ex :
		name='IBM'

##### osarch
	ex :
		name='i386'
		name='i686'
		name='x86_64'

##### os
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

##### cpu
	ex :
		@vendor='Intel'
		name='Xeon CPU E5-2660'
		arch='64'
		cores='8'
		htfactor='2'
		frequency='2.20'

##### model
	ex :
		name='ProLiant BL460c Gen8'

##### environment
	ex :
		name='Test'
		name='Intégration'
		name='Recette'
		name='Production'

##### machine
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
