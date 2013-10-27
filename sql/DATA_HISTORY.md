# HOW TO HANDLE HISTORY

The _device_ table contains one unique line per device (the actual state).  The
_devicehistory_ table handle devices histor.
	- Pros :
		- The _device_ table contains only 'living' devices.
		- Devices end of life is visible : last state of device is keeped in
		  _devicehistory_ table and the device is removed from _device_ table
		  (equals move device row from _device_ to _devicehistory_).
	- Cons :
		- ?

	- Device creation :
	  Data insertion both in the tables _device_ and _devicehistory_. Device
	  start of life is in the _devicehistory_ and device actual state in the
	  _device_ table. the two lines are the same because there was no
	  modifications at this time.
	- Device modification :
		- Modify _device_ table row.
		- Copy the modified row from _device_ table ti _devicehistory_.
	- Device suppression (end of life) :
		- Update _device_ row timestamp with the end of life date.
		- Move this modified row from _device_ table to _devicehistory_ table.
		the device is no more in the _device_ table but its history is visible
		in the _devicehistory_ table.
