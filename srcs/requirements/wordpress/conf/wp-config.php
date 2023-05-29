<?php

define( 'DB_NAME', 'wp_mariadb' );

/** Database username */
define( 'DB_USER', 'elix' );

/** Database password */
define( 'DB_PASSWORD', 'mariaelix' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

echo 'WP_DB_NAME: ' . getenv('WP_DB_NAME') . "\n";
define('DB_NAME', getenv('WP_DB_NAME'));

echo 'WP_DB_USER: ' . getenv('WP_DB_USER') . "\n";
define('DB_USER', getenv('WP_DB_USER'));

echo 'WP_DB_PASSWORD: ' . getenv('WP_DB_PASSWORD') . "\n";
define('DB_PASSWORD', getenv('WP_DB_PASSWORD'));

echo 'WP_DB_HOST: ' . getenv('WP_DB_HOST') . "\n";
define('DB_HOST', getenv('WP_DB_HOST') . ':3306');

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('WP_DEBUG', true);

$table_prefix  = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once(ABSPATH . 'wp-settings.php');
