# private class
class mcollective::server::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $mcollective::manage_packages {
    package { $mcollective::server_package:
      ensure => $mcollective::version,
    }
  }
}
