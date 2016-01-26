#
# Cookbook Name:: masala_zookeeper
# Recipe:: default
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

include_recipe 'masala_base::default'
include_recipe 'zookeeper::default'

# For some reason parent recipe does not support setting the ID.... add it in here.
if node['zookeeper']['config'].has_key?('server') && !node['zookeeper']['config']['server'].empty?
  myhost = node['system']['short_hostname'] + '.' + node['system']['domain_name']
  myid = nil
  node['zookeeper']['config']['server'].each do |id,host|
    if host.split(':')[0] == myhost
      myid = id
    end
  end
  if myid.nil?
    raise "host not in zookeeper server list!"
  end

  file 'zookeeper id' do
    path ::File.join(node['zookeeper']['config']['dataDir'], 'myid')
    group node['zookeeper']['user']
    owner 'root'
    content  myid
    mode 00644
    backup false
  end
end

include_recipe 'zookeeper::service'
include_recipe 'masala_zookeeper::datadog'
include_recipe 'masala_zookeeper::cron'
