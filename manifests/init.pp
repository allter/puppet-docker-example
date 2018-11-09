Service {
  provider => dummy
}

class { 'nginx': }

file { [ '/var/www', '/var/www/html' ]:
  ensure => 'directory',
}

nginx::resource::vhost { 'default':
  www_root => '/var/www/html',
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello Puppet and Docker',
}

exec { 'Disable Nginx daemon mode':
  path    => '/bin',
  command => 'echo "daemon off;" >> /etc/nginx/nginx.conf',
  unless  => 'grep "daemon off" /etc/nginx/nginx.conf',
}
