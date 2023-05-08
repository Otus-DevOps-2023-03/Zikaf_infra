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
testapp_IP = 51.250.69.223
testapp_port = 9292
```
