package {'php5':        ensure => installed}
package {'php5-cli':    ensure => installed}
package {'php5-xdebug':	ensure => installed}
package {'curl':	ensure => installed}

# Set development values to our php.ini and xdebug.ini
    augeas { 'set-php-ini-values':
        context => '/files/etc/php5/cli/php.ini',
        changes => [
            'set PHP/error_reporting "E_ALL | E_STRICT"',
            'set PHP/display_errors On',
            'set PHP/display_startup_errors On',
            'set PHP/html_errors On',
            'set PHP/memory_limit 1024M',
            'set Date/date.timezone Europe/London',
        ],
        require => Package['php5'],
    }

    augeas { 'set-xdebug-ini-values':
        context => '/files/etc/php5/mods-available/xdebug.ini',
        changes => [
            'set Xdebug/xdebug.remote_connect_back 0',
            'set Xdebug/xdebug.remote_host 10.37.37.37',
            'set Xdebug/xdebug.remote_port 9000',
            'set Xdebug/xdebug.remote_handler dbgp',
            'set Xdebug/xdebug.remote_mode req',
            'set Xdebug/xdebug.profiler_enable 0',
            'set Xdebug/xdebug.profiler_output_dir /root/php_profiler',
            'set Xdebug/xdebug.profiler_enable_trigger 1',
        ],
        require => Package['php5'],
    }


$xdebug='export XDEBUG_CONFIG="idekey=phpstorm1"'
$phpstorm='export PHP_IDE_CONFIG="serverName=cloud.bitrithm.co.uk"'
file {'xdebug-environment-variables':
	path => '/etc/profile.d/phpstorm-xdebug.sh',
	content => "${xdebug}\n${phpstorm}"
}

file {'xdebug-profiler-alias':
	path => '/etc/profile.d/xdebug-profiler-alias.sh',
	content => 'alias phpp="php -d xdebug.profiler_enable=1"'
}

file {'/root/php_profiler' :
	ensure => directory,
	mode => 'a+rwx'
}
