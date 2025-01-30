* Remove legacy facts usage.

#### 2023-03-16 - 1.0.7
* Add support for RHEL9.

#### 2021-06-12 - 1.0.6
* Allow disabling compression and adding extra lines in conftemplate.

#### 2019-01-21 - 1.0.5
* Make sure openvpn-startup doesn't fail if tap already exists in bridge.

#### 2017-12-04 - 1.0.4
* Add local source address conftemplate parameter (#7, @forgodssake).

#### 2016-02-02 - 1.0.3
* Refresh (multi)service when config file changes (#6, @jlambert121).

#### 2015-10-15 - 1.0.2
* Add support for proto in conftemplate.
* Fix startup_script with multiservice.
* Do not output secret files changes with show_diff (#4, @TJM).

#### 2015-04-28 - 1.0.1
* Fix OS version comparison for Puppet 4.

#### 2015-03-12 - 1.0.0
* Work around for service enable broken on RHEL 7.1.

#### 2014-12-16 - 0.2.6
* Minor clean ups and changes to make puppet-lint happy.

#### 2014-12-16 - 0.2.5
* Rename startup script class for future parser compatibility.
* Update README.
* Add user/group and verb options for conftemplate (#3, @kernel23).

#### 2014-05-05 - 0.2.4
* Add support for RHEL7 (systemctl with '@' multiservice).

#### 2014-04-28 - 0.2.3
* Fix service requirement for multiservice conf.
* Add fragment and mssfix to the default.conf template.
* Support absent for secret files.

#### 2013-10-02 - 0.2.2
* Add suport for Ubuntu/Debian, it works fine out of the box (rjpearce).

#### 2013-05-29 - 0.2.1
* Add a params class for package and service names.
* Support "multiservice", where each conf has its own init.d symlink (Gentoo).

#### 2013-05-24 - 0.2.0
* Update README and use markdown.
* Change to 2-space indent.
* Add missing @ variable prefix in config template.
* Change conftemplate to be a wrapper of conf, to avoid duplicating code.

#### 2012-09-25 - 0.1.1
* Start cleaning up the module.

