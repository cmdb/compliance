# HOW TO HANDLE HISTORY

Plusieurs méthodes envisageables ; la méthode _2 tables_ est pour l'instant
préssentie.

1. la table machine contient plusieurs lignes pour une même machine (même uuid)
Dans ce cas, l'historique des changements d'une machine est visible en
listant toutes les lignes ayant le même uuid et en triant par timestamp
croissant.
	- Avantages :
		- une seule table ?
	- Inconvénients :
		- la fin de vie d'une machine n'est pas visible

	- Création d'une machine :
		- Insertion des données dans la table machine. Les infos de naissance
		  d'une machine sont celles de la première ligne.
	- Modification d'une machine :
		- Insertion des données modifiées dans une nouvelle ligne avec l'uuid de
		  la machine correspondante.
	- Suppression d'une machine :
		- C'est là que c'est compliqué, on ne peut pas savoir la mort d'une
		  machine sans avoir un flag spécifique active / inactive...

2. la table machine contient une ligne unique par machine (état actuel de
référence)
Dans ce cas, une table machinehistory sera créée.
	- Avantages :
		- la table machine ne contien QUE les machines "vivantes".
	- Inconvénients :
		- suppression d'une machine non visible

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
