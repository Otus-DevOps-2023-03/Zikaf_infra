# Zikaf_infra
Zikaf Infra repository

### Самостоятельное задание ###
### Одна команда для подкл. сразу к 3му терминалу (без белого IP)
### "-t" для создания псевдо-терминала на удаленной машине
ssh -i ~/.ssh/appuser -A -t appuser@62.84.114.132 ssh 10.128.0.9

### Дополнительно задание ###
### Для подключения к машине someinternalhost (10.128.0.9)
### по алиасу из локальной консоли
### редактируем файл ~/.ssh/config
### "-W" используется для указания удаленного хоста и порта для перенаправления стандартных входных и выходных потоков.
### в данном случае она используется для указания адреса и порта удаленной машины 10.128.0.9
### ":%p" указывает на то, что порт, который будет сгенерирован динамически,
### должен быть передан в качестве аргумента при выполнении команды ssh

mcedit ~/.ssh/config
.....................................
Host someinternalhost
  ProxyCommand ssh -W 10.128.0.9:%p appuser@62.84.114.132
.....................................
ssh -A -t someinternalhost -l appuser

Доделка:
mcedit ~/.ssh/config
.....................................
### Доступ до YandexCloud - VM bastion и someinternalhost
Host bastion
    HostName 51.250.12.220
    User appuser
    IdentityFile ~/.ssh/appuser

Host bastion
    HostName 51.250.12.220
    User appuser
    IdentityFile ~/.ssh/appuser

Host someinternalhost
    HostName 10.128.0.30
    User appuser
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh -W %h:%p bastion
.....................................
ssh bastion                 ### работает
ssh someinternalhost        ### работает
