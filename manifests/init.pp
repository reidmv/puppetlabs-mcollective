# Class - mcollective
class mcollective (
  # which subcomponents to install here
  $server = true,
  $client = false,

  # installing packages
  $manage_packages = true,
  $version = 'present',

  # core configuration
  $main_collective = 'mcollective',
  $collectives = 'mcollective',
  $connector = 'activemq',
  $securityprovider = 'psk',
  $psk = 'changemeplease',
  $factsource = 'yaml',
  $yaml_fact_path = '/etc/mcollective/facts.yaml',
  $classesfile = '/var/lib/puppet/state/classes.txt',
  $rpcauthprovider = 'action_policy',
  $rpcauditprovider = 'logfile',
  $registration = undef,
  $core_libdir = $mcollective::defaults::core_libdir,
  $site_libdir = $mcollective::defaults::site_libdir,

  # networking
  $middleware_hosts = [],
  $middleware_user = 'mcollective',
  $middleware_password = 'marionette',
  $middleware_port = '61613',
  $middleware_ssl_port = '61614',
  $middleware_ssl = false,
  $middleware_ssl_fallback = false,
  $middleware_admin_user = 'admin',
  $middleware_admin_password = 'secret',

  # server-specific
  $server_config_file = '/etc/mcollective/server.cfg',
  $server_logfile   = '/var/log/mcollective.log',
  $server_loglevel  = 'info',
  $server_daemonize = 1,

  # client-specific
  $client_config_file = '/etc/mcollective/client.cfg',
  $client_logger_type = 'console',
  $client_loglevel = 'warn',
  $client_package_name = 'mcollective-client',

  # ssl certs
  $ssl_ca_cert = undef,
  $ssl_server_public = undef,
  $ssl_server_private = undef,
  $ssl_client_certs = 'puppet:///modules/mcollective/empty',
) inherits mcollective::defaults {

  if $client or $server {
    contain mcollective::common
  }
  if $client {
    contain mcollective::client
  }
  if $server {
    contain mcollective::server
  }
}
