<?php
define('DB_NAME', getenv('WP_DB_NAME'));
define('DB_USER', getenv('WP_DB_USER'));
define('DB_PASSWORD', getenv('WP_DB_PASSWORD'));
define('DB_HOST', getenv('WP_DB_HOST'));

echo 'DB_HOST: ' . DB_HOST . '<br>';
echo 'DB_NAME: ' . DB_NAME . '<br>';
echo 'DB_USER: ' . DB_USER . '<br>';
echo 'DB_PASSWORD: ' . DB_PASSWORD . '<br>';
die();

// define('DB_CHARSET', 'utf8');
// define('DB_COLLATE', '');

// define('AUTH_KEY',         getenv('AUTH_KEY'));
// define('SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY'));
// define('LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY'));
// define('NONCE_KEY',        getenv('NONCE_KEY'));
// define('AUTH_SALT',        getenv('AUTH_SALT'));
// define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
// define('LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT'));
// define('NONCE_SALT',       getenv('NONCE_SALT'));

define('WP_DEBUG', true);

$table_prefix  = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once(ABSPATH . 'wp-settings.php');
