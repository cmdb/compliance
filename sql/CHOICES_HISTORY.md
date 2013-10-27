# HOW TO NOT HANDLE HISTORY

Reasons why this database sheme wasn't retained.

1. the _device_ table contains many lines for a same device (same uuid).  In
this case, changes history is visible by listing all lines with the same uuid
sorted by ascending timestamp.
	- Pros :
		- Just one table
	- Cons :
		- Device end of life is not visible without a special flag in the device
		  table.

	- device creation :
		- Insert data in the device table. Device start of life is the first
		  line.
	- device modification :
		- Insert modified device data in a new row with the same uuid.
	- device suppression :
		- Unhandled. Device end of life is not visible without a special flag in
		  the device table.
