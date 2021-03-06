# DB Schema Updates

When DB Schema (tables structure) is updated, how to export / update / reimport
your datas or update tables structures directly in case of minor changes.

## 1. Export / Modify / Reimport

- Export the schema without data

`$ mysqldump --skip-comments --no-data _DBName_|sed "s/AUTO_INCREMENT=[0-9]*\s//g" > schema.sql`

`sed` is used to remove `AUTO_INCREMENT=NN` from the schema creation. Otherwise
table data will begin with a number depending of how many rows were in the
previous schema export.

`--skip-opt` removes the `ON UPDATE CURRENT_TIMESTAMP` so don't use it in our case.

- Export your datas without create statements

`$ mysqldump --no-create-info _DBName_ > datas.sql`

- modify schema

By modifying file schema.sql

- modify datas if applicable

By modifying file datas.sql

- Drop database

`mysql> drop database _DBName_`  
or  
`$ mysqladmin drop _DBName_`

- Create database with the new schema

`mysql> create database _DBName_`  
or  
`$ mysqladmin create _DBName_`

`$ mysql _DBName_ < schema.sql`

- re-Import your datas

`$ mysql _DBName_ < datas.sql`

## 2. Hot Schema Update

...TODO...
