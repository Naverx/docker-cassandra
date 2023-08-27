У меня две виртуальные машины с ubuntu 22.04 lts в Oracle VirtualBox. Соеденены типом сети "сетевой мост"
Открытие портов:
>sudo ufw allow 9042/tcp

>sudo ufw allow 9043/tcp

>sudo ufw allow 9044/tcp

Ставлю айпи адреса и шлюзы на обеих машинах:

![1](https://github.com/Naverx/docker-cassandra/assets/14109161/e9bf2851-70cb-4ec5-8914-71fc1aa387c8)
![2](https://github.com/Naverx/docker-cassandra/assets/14109161/2561af93-47c6-45f1-a2c4-80070ca8cc04)

создание сети:
> docker network create -d macvlan --subnet 192.168.1.197/28 --gateway 192.168.1.199 --ip-range 192.168.1.200/30 -o parent=enp0s8 CASnet

Где gateway это шлюз сети в которой находится vm, а enp0s8 это название её интерфейса(macvlan присоединяется к сети хоста, а ip range это диапазон адресов для докер контейнеров):
![image](https://github.com/Naverx/docker-cassandra/assets/14109161/d1422084-af7f-46e6-bbb6-da8abe4692e1)

Запуск контейнеров с кассандрой по очереди. Между запусками должна быть пауза около минуты, это можно было бы автоматизировать с помощью entrypoint

>docker-compose -f docker-compose.yml up cassandra1 -d

>docker-compose -f docker-compose.yml up cassandra2 -d

>docker-compose -f docker-compose.yml up cassandra3 -d


Подключаюсь с cqlsh с удалённого хоста до каждого из контейнеров по адресам 192.168.1.200-202
![2](https://github.com/Naverx/docker-cassandra/assets/14109161/a77e41fc-afb0-4435-9495-51bb10712fb7)

Так же меня сильно озадачило что при подключении контейнеров к сети типа macvlan отсутствует доступ к контейнерам с материнского для них хоста. Как выяснилось это такая антифича macvlan'a. Воркэраунд состоит в том чтобы создать на самом хосте ещё одну сеть macvlan и подключить её к общему интерфейсу(в моём случае enp0s8, сетевой мост который настраивается в настройках Oracle VirtualBox)
Этот пункт не совсем обязательный но вот подробная но простая инструкция, после которой всё заработало
https://blog.oddbit.com/post/2018-03-12-using-docker-macvlan-networks/

