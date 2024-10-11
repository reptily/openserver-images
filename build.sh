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

function php74
{
    cp php-7.4.dockerfile Dockerfile && \
    docker build -t openserver-php-7.4 . && \
    docker build -t openserver-php-7.4:php-7.4.33 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 7.4 Build success\e[0m"
    TEST_VERSIONS+=('7.4')
}

function php73
{
    cp php-7.3.dockerfile Dockerfile && \
    docker build -t openserver-php-7.3 . && \
    docker build -t openserver-php-7.3:php-7.3.33 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 7.3 Build success\e[0m"
    TEST_VERSIONS+=('7.3')
}

function php72
{
    cp php-7.2.dockerfile Dockerfile && \
    docker build -t openserver-php-7.2 . && \
    docker build -t openserver-php-7.2:php-7.2.34 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 7.2 Build success\e[0m"
    TEST_VERSIONS+=('7.2')
}

function php71
{
    cp php-7.1.dockerfile Dockerfile && \
    docker build -t openserver-php-7.1 . && \
    docker build -t openserver-php-7.1:php-7.1.33 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 7.1 Build success\e[0m"
    TEST_VERSIONS+=('7.1')
}

function php70
{
    cp php-7.0.dockerfile Dockerfile && \
    docker build -t openserver-php-7.0 . && \
    docker build -t openserver-php-7.0:php-7.1.33 . && \
    rm Dockerfile && \
    echo -e "\e[32mPHP 7.0 Build success\e[0m"
    TEST_VERSIONS+=('7.0')
}

case $1 in
    all )
        docker rmi $(docker images -f "dangling=true" -q)
        php83
        php82
        php81
        php80
        php74
        php73
        php72
        php71
        php70
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
    php-7.4 )
        php74
    ;;
    php-7.3 )
        php73
    ;;
    php-7.2 )
        php72
    ;;
    php-7.1 )
        php71
    ;;
    php-7.0 )
        php70
    ;;
esac

test
