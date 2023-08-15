# docker-cassandra
Открытие портов:
/home/psyop/.bash_history:sudo ufw allow 9042/tcp
/home/psyop/.bash_history:sudo ufw allow 9043/tcp
/home/psyop/.bash_history:sudo ufw allow 9044/tcp

создание сети
docker network create --gateway 192.168.1.198 --subnet 192.168.1.197/28 CASnetwork

Запуск контейнеров с кассандрой по очереди
docker-compose -f docker-compose.yml up cassandra1 -d
docker-compose -f docker-compose.yml up cassandra2 -d
docker-compose -f docker-compose.yml up cassandra3 -d

![image](https://github.com/Naverx/docker-cassandra/assets/14109161/323dfa0e-9946-433c-a15e-567848f95fbf)


cqlsh с удалённого хоста до каждого из контейнера по адресу самой машины с докером + проброшенного порта 9042, 9043, 9044
![image](https://github.com/Naverx/docker-cassandra/assets/14109161/4cc2cfa0-3761-4b32-83a6-6301c5732b4e)

