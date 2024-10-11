<?php

function checkExtension($extension, $functionName) {
    if (!function_exists($functionName)) {
        echo "Module {$extension} not found" . PHP_EOL;

        exit(1);
    }
}

// Проверка расширения mysqli
checkExtension('Mysqli', 'mysqli_connect');

// Проверка расширения pgsql
checkExtension('Pgsql', 'pg_connect');

// Проверка расширения pdo_mysql
// checkExtension('PDO MySQL', 'PDO');
//
// // Проверка расширения pdo_pgsql
// checkExtension('PDO Pgsql', 'PDO');

// Проверка расширения gd
checkExtension('GD', 'gd_info');

// Проверка расширения openssl
checkExtension('OpenSSL', 'openssl_encrypt');

// Проверка расширения zip
checkExtension('Zip', 'zip_open');

// Проверка расширения bcmath
checkExtension('BCMath', 'bcadd');

// Проверка расширения mbstring
checkExtension('Mbstring', 'mb_strlen');

// Проверка расширения soap
checkExtension('SOAP', 'soap_version');

// Проверка расширения curl
checkExtension('cURL', 'curl_version');

// Проверка расширения exif
checkExtension('Exif', 'exif_read_data');

// Проверка расширения intl
checkExtension('Intl', 'intlcal_get_now');

// Проверка расширения xmlrpc
checkExtension('XML-RPC', 'xmlrpc_encode');

// Проверка расширения xsl
checkExtension('XSL', 'xsl_getversions');

// Проверка расширения sqlite3
checkExtension('SQLite3', 'SQLite3');

// Проверка расширения imap
checkExtension('IMAP', 'imap_open');

// Проверка расширения kerberos (если используется)
checkExtension('Kerberos', 'krb5_get_init_creds_password');

// Проверка расширения bz2
checkExtension('Bz2', 'bzopen');

// Проверка расширения ftp
checkExtension('FTP', 'ftp_connect');

// Проверка расширения iconv (если используется)
checkExtension('Iconv', 'iconv');



$extensions = array(
    'igbinary',
    'xdebug',
    'memcached',
    'memcache',
    'redis',
    'decimal',
    'mongodb',
);

foreach ($extensions as $extensionName) {
    if (!extension_loaded($extensionName)) {
         echo "{$extensionName} extension is not loaded." . PHP_EOL;

         exit(1);
    }
}

echo "All required modules are loaded.n" . PHP_EOL;
exit(0);

