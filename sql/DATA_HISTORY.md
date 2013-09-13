# HOW TO HANDLE HISTORY

Plusieurs méthodes envisageables :

1. la table machine contient plusieurs lignes pour une même machine (même uuid)
Dans ce cas, l'historique des changements d'une machine est visible en
listant toutes les lignes ayant le même uuid et en triant par timestamp
croissant.
	- Création d'une machine :
		TODO
	- Modification d'une machine :
		TODO
	- Suppression d'une machine :
		TODO

2. la table machine contient une ligne unique par machine (état actuel de
référence)
Dans ce cas, une table machinehistory sera créée.
	- Création d'une machine :
		insertion des données à la fois dans la table machine et aussi dans la
		table machinehistory. On a la naissance de la machine dans la table
		machinehistory et son état actuel dans la table machine.
	- Modification d'une machine :
		- Modifier la ligne de la table machine
		- Copier la ligne modifiée depuis la table machine vers la table
		  machinehistory
	- Suppression d'une machine :
		- Mettre à jour l'enregistrement de la table machine avec la date de
		  suppression de la machine.
		- Déplacer la ligne de la table machine vers machinehistory. Le dernier
		enregistrement correspond alors à la date de suppression de la machine.
