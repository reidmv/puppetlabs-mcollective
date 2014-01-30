# private define
# $name will be an index into the $mcollective::middleware_hosts array + 1
define mcollective::server::config::connector::activemq::hosts_iteration {
  if $mcollective::middleware_ssl {
    mcollective::server::setting { "plugin.activemq.pool.${name}.ssl.cert":
      value => "${mcollective::configdir}/server_public.pem",
    }

    mcollective::server::setting { "plugin.activemq.pool.${name}.ssl.key":
      value => "${mcollective::configdir}/server_private.pem",
    }
  }
}
