#
# Cookbook Name:: masala_zookeeper
# Recipe:: cron
#
# Copyright 2016, Paytm Labs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

zk_base = "#{node["zookeeper"]["install_dir"]}/zookeeper-#{node["zookeeper"]["version"]}"
zk_data = node["zookeeper"]["config"]["dataDir"]
numkeep = 10

ruby_block "find-zk-clean-classpath" do
  block do
    node.set['masala_zookeeper']['cleanup_classpath'] = Dir["#{zk_base}/{lib/slf4j,lib/log4j,zookeeper}*.jar"].push("#{zk_base}/conf").join(':')
  end
end

cron "logrotate_zookeeper_cleanup" do
  minute "0"
  hour "4"
  command lazy { "java -cp " + node['masala_zookeeper']['cleanup_classpath'] + " org.apache.zookeeper.server.PurgeTxnLog #{zk_data} #{zk_data} -n #{numkeep} 2>&1 >> #{node.zookeeper.log_dir}/cleanup.log" }
  user node.zookeeper.user
end

logrotate_app 'zookeeper_cleanup_cron' do
  path      "#{node.zookeeper.log_dir}/cleanup.log"
  frequency 'daily'
  options   ['missingok', 'delaycompress', 'notifempty']
  rotate    7
  create    "644 #{node.zookeeper.user} #{node.zookeeper.user}"
end
