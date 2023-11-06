<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** Database username */
define( 'DB_USER', 'wordpress_user' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '=`7CMk#~(gR[Tyx| 6[ l.63r2n]A+2b.{.wEKbhY!1T/a|+<`w:hQ%TZ2,` o+3' );
define( 'SECURE_AUTH_KEY',  '&YO>0{QSc(wr J#:3IKf=t!(HD/vpaz?/GcGLcOG+|5@=ju/9y11^8`:^=repDFx' );
define( 'LOGGED_IN_KEY',    'XsuI{B{rGi.&y61eP$7.6dkU`tF]1R|KTd.q/1}8WxEKO`.`JF)&F1Rfdi4<g%Vt' );
define( 'NONCE_KEY',        '_2kf=$Hu-)4tq]p[.(=:j;f&Pz,S3YB{Zi>IFmww 2sFjP1ELir*@u1Mg`jKNX>N' );
define( 'AUTH_SALT',        'yL*mq%$Nl!4zEvyKBH+PkW=fqw`|%f2LG^kL[TsU}YbNzn03Ao&pG-/=u3>.h[OJ' );
define( 'SECURE_AUTH_SALT', 'g*a4Tp&C]8i6@$* m4X[;d.6ovnSv`%7;@/q?%~PkEu#JKP 1)5XyDZO/&d<S?q.' );
define( 'LOGGED_IN_SALT',   'Q8:;fv2D+61wUg3Yf:!#63hz_|Sf@gAw151=QWemjM63-7GM$f{@.>kt1b$E@k!=' );
define( 'NONCE_SALT',       'sA2?s|odu Ah*yO3B$3Mk(X6FR (|Mzl?!<kr=@Tb{YV{]FtLG+x&mY ]Kh:}#(-' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
