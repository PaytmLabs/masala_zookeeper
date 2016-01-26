

default["zookeeper"]["use_java_cookbook"] = false       # done in base
# One of: 'upstart', 'runit', 'exhibitor', 'sysv'
default[:zookeeper][:service_style] = 'sysv'

default[:zookeeper][:version]     = '3.4.7'
default[:zookeeper][:checksum]    = '2e043e04c4da82fbdb38a68e585f3317535b3842c726e0993312948afcc83870'
default[:zookeeper][:mirror]      = 'http://archive.apache.org/dist/zookeeper'
default[:zookeeper][:config_dir]  = "#{node[:zookeeper][:install_dir]}/" \
                                    "zookeeper-#{node[:zookeeper][:version]}/conf"
