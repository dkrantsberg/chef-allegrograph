#
# Cookbook Name:: AllegroGraph
# Recipe:: default
#
# Copyright 2015, Gannett, Inc.
#
# All rights reserved - Do Not Redistribute
#

remote_file '/tmp/' + node['allegrograph']['agraph_package_name'] + '.rpm' do 
	source node['allegrograph']['rpm_url']
	checksum node['allegrograph']['agraph_rpm_checksum']
end

rpm_package node['allegrograph']['agraph_package_name'] do 
	action :install
	source '/tmp/' + node['allegrograph']['agraph_package_name'] + '.rpm'
end

directory '/etc/agraph' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

template 'cfgfile' do
	path '/etc/agraph/agraph.cfg'
	source 'agraph.cfg.erb'
	owner  'root'
	mode 0755
	action :create
end

service 'agraph' do
	action :start
end

