# Zikaf_infra
Zikaf Infra repository

### Самостоятельное задание ###
### Одна команда для подкл. сразу к 3му терминалу (без белого IP)
### "-t" для создания псевдо-терминала на удаленной машине
ssh -i ~/.ssh/appuser -A -t appuser@51.250.9.71 ssh 10.128.0.30

### Дополнительно задание ###
### Для подключения к машине someinternalhost (10.128.0.30)
### по алиасу из локальной консоли
### редактируем файл ~/.ssh/config
### "-W" используется для указания удаленного хоста и порта для перенаправления стандартных входных и выходных потоков.
### в данном случае она используется для указания адреса и порта удаленной машины 10.128.0.30
### ":%p" указывает на то, что порт, который будет сгенерирован динамически,
### должен быть передан в качестве аргумента при выполнении команды ssh

### Еще один пример
mcedit ~/.ssh/config
.....................................
  Host someinternalhost
  ProxyCommand ssh -W 10.128.0.30:%p appuser@51.250.9.71
.....................................
ssh -A -t someinternalhost -l appuser

Доделка:
mcedit ~/.ssh/config
.....................................
### Доступ до YandexCloud - VM bastion и someinternalhost
Host bastion
    HostName 51.250.9.71
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

###
bastion_IP = 51.250.9.71
someinternalhost_IP = 10.128.0.30
