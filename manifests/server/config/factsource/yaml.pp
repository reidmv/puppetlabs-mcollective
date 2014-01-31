# private class
class mcollective::server::config::factsource::yaml {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $mco_etc = $mcollective::configdir

  # Template uses:
  #   - $mco_etc
  file { "${mcollective::core_libdir}/refresh-mcollective-metadata":
    owner   => '0',
    group   => '0',
    mode    => '0755',
    content => template('mcollective/refresh-mcollective-metadata.erb'),
    before  => Cron['refresh-mcollective-metadata'],
  }
  cron { 'refresh-mcollective-metadata':
    environment => "PATH=/opt/puppet/bin:${::path}",
    command     => "${mcollective::core_libdir}/refresh-mcollective-metadata",
    user        => 'root',
    minute      => [ '0', '15', '30', '45' ],
  }
  exec { 'create-mcollective-metadata':
    path    => "/opt/puppet/bin:${::path}",
    command => "${mcollective::core_libdir}/refresh-mcollective-metadata",
    creates => "${mco_etc}/facts.yaml",
    require => File["${mcollective::core_libdir}/refresh-mcollective-metadata"],
  }

  mcollective::server::setting { 'factsource':
    value => 'yaml',
  }

  mcollective::server::setting { 'plugin.yaml':
    value => $mcollective::yaml_fact_path,
  }
}
