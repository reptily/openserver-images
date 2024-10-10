#/bin/bash

TEST_VERSIONS=()
function test
{
    for V in ${TEST_VERSIONS[*]}
    do
        docker run -it --rm --name openserver-php-${V} openserver-php-${V} php -v > /dev/null && echo -e "\e[32mTest PHP ${V} success\e[0m" || echo -e "\e[31mTest PHP ${V} ERROR\e[0m"
    done
}

function php83
{
    cp php-8.3.dockerfile Dockerfile && \
    docker build -t openserver-php-8.3 . && \
    docker build -t openserver-php-8.3:php-8.3.11 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 8.3 Build success\e[0m"
    TEST_VERSIONS+=('8.3')
}

function php82
{
    cp php-8.2.dockerfile Dockerfile && \
    docker build -t openserver-php-8.2 . && \
    docker build -t openserver-php-8.2:php-8.2.23 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 8.2 Build success\e[0m"
    TEST_VERSIONS+=('8.2')
}

function php81
{
    cp php-8.1.dockerfile Dockerfile && \
    docker build -t openserver-php-8.1 . && \
    docker build -t openserver-php-8.1:php-8.1.30 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 8.1 Build success\e[0m"
    TEST_VERSIONS+=('8.1')
}

function php80
{
    cp php-8.0.dockerfile Dockerfile && \
    docker build -t openserver-php-8.0 . && \
    docker build -t openserver-php-8.0:php-8.0.30 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 8.0 Build success\e[0m"
    TEST_VERSIONS+=('8.0')
}

case $1 in
    all )
        docker rmi $(docker images -f "dangling=true" -q)
        php83
        php82
        php81
        php80
    ;;
    php-8.3 )
        php83
    ;;
    php-8.2 )
        php82
    ;;
    php-8.1 )
        php81
    ;;
    php-8.0 )
        php80
    ;;
esac

test
