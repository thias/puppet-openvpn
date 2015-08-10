* Add support for proto in conftemplate.

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

