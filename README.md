## Zikaf_infra
Заметки по всем ДЗ
## ДЗ №5 "Знакомство с облачной инфраструктурой и облачными сервисами"
```
bastion_IP = 51.250.9.71
someinternalhost_IP = 10.128.0.30
```

Подключение через алиас и одной командой
```
Host bastion
    HostName 51.250.9.71
    User appuser
    IdentityFile ~/.ssh/appuser

Host someinternalhost
    HostName 10.128.0.30
    User appuser
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh -W %h:%p bastion
```

Теперь доступны
```
ssh bastion
ssh someinternalhost
```

## ДЗ №6 "Основные сервисы Yandex Cloud"
```
testapp_IP = 158.160.99.11
testapp_port = 9292
```
Команды которые пригодились для управления cli yandex
```
yc config list
yc config profile list
yc compute instance list
yc compute instance get ИмяИнстанса
yc compute instance delete ИмяИнстанса
```

Сервис "Monolith Reddit"
```
адресс http://158.160.99.11:9292/
```

Для автоматизации из скрипта использовался .yaml и команда
```
--metadata-from-file user-data=metadata.yaml
```
Проверка автоматизации, кстати требуется время после установки инстанса для отработки скрипта
```
адрес http://158.160.50.136:9292/
```
 