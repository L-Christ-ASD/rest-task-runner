# Challenge du jour :

* Déployer sur l'environnement Linux de votre choix un binaire exécutable tiré du projet [https://github.com/profy12/rest-task-runner] et compilé pour votre environnement
* Créer un fichier de service systemd pour exécuter le service nommé task-runner.service et placez le dans le répertoire /etc/systemd/system/
* Rechargez la configuration systemd avec systemctl daemon-reload
* Lancer votre service et tester
* Installer taskfile dans votre environnement serveur car sinon ça n'a pas du bien marcher.
* Créer des petites tâches administrative pour par exemple mettre à jour votre serveur.
* Activer le service au démarrage.
* Mettez à jour votre serveur de manière distance depuis le navigateur

## etapet 02

* On reprend le challenge du dessus, mais on le complique.
* On créé un utilisateur système Linux nommé task-runner.
* Notre exécutable task-runner doit être exécuté avec cet utilisateur.
* task runner doit exécuter la commande task en pré-fixant avec sudo, pour * que la task soit exécutée en root.
* Planifiez une tâche cron utilisateur pour exécuter régulièrement les 
* mises à jour sur votre système avec task runner.



# Résultat attendus:

task-runner@christ-VirtualBox:/home/christ/go/src/challenge_linux_s06/rest-task-runner$ ls
go.mod	go.sum	main.go  README.md  rest-task-runner  Taskfile.yml
task-runner@christ-VirtualBox:/home/christ/go/src/challenge_linux_s06/rest-task-runner$ task hello
2024/11/25 17:40:44.190098 cmd_run.go:1276: WARNING: cannot create user data directory: cannot create snap home dir: mkdir /home/task-runner: permission denied
cannot create user data directory: /home/task-runner/snap/task/221: Permission denied
task-runner@christ-VirtualBox:/home/christ/go/src/challenge_linux_s06/rest-task-runner$ sudo task hello
task: [hello] echo "Hello Devops ! My name is $(whoami)"
Hello Devops ! My name is root
task-runner@christ-VirtualBox:/home/christ/go/src/challenge_linux_s06/rest-task-runner$