# Урок 2. Задание со *.
В репозитории находится файл [Vagrantfile](Vagrantfile) и [script](script.sh)
## Описание Vagrantfile.
1. В файле содержатся параметры вирт. машины.
2. Указано, что после установки всех параметров, будет исполнен скрипт - config.vm.provision "shell", path: "script.sh"
## Описание scrpit.sh
В данном файле прописаны команды по сборке Raid, создание ФС, после выполнения можно пользоваться raid.

