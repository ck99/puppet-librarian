class { 'elasticsearch': }

class { 'logstash':
   logstash_user  => 'logstash',
   logstash_group => 'logstash',
   java_install => true,
}

logstash::input::file { 'logstash-logs':
   path => ['/var/log/*.log'],
   type => 'misc',
}


logstash::output::elasticsearch { 'logstash-elasticsearch': }
