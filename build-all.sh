#/bin/bash

# Удаляем все образы с именем <none>
docker rmi $(docker images -f "dangling=true" -q)

docker build -t openserver-php-8.3 8.3/.
# docker build -t openserver-php-8.3:php-8.3.11 8.3/.
