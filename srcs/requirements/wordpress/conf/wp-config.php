<?php

echo 'WP_DB_NAME: ' . getenv('WP_DB_NAME') . "\n";
define('DB_NAME', getenv('WP_DB_NAME'));

echo 'WP_DB_USER: ' . getenv('WP_DB_USER') . "\n";
define('DB_USER', getenv('WP_DB_USER'));

echo 'WP_DB_PASSWORD: ' . getenv('WP_DB_PASSWORD') . "\n";
define('DB_PASSWORD', getenv('WP_DB_PASSWORD'));

echo 'WP_DB_HOST: ' . getenv('WP_DB_HOST') . "\n";
define('DB_HOST', getenv('WP_DB_HOST') . ':3306');

define('WP_DEBUG', true);

$table_prefix  = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once(ABSPATH . 'wp-settings.php');
