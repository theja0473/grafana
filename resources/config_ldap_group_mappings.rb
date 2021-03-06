#
# Cookbook:: grafana
# Resource:: config_alerting
#
# Copyright:: 2019, Sous Chefs
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
#
# Configures the installed grafana instance's ldap group mappings
# See https://raw.githubusercontent.com/grafana/grafana/master/conf/ldap.toml
# Expects config_ldap to have been called before this

property  :instance_name,                 String,                   name_property: true
property  :group_dn,                      String,                   required: true
property  :org_role,                      String,                   default: 'Viewer'
property  :grafana_admin,                 [TrueClass, FalseClass],  default: false
property  :org_id,                        Integer,                  default: 1

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['org_role'] ||= '' unless new_resource.org_role.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['org_role'] = new_resource.org_role.to_s unless new_resource.org_role.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['grafana_admin'] ||= '' unless new_resource.grafana_admin.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['grafana_admin'] = new_resource.grafana_admin.to_s unless new_resource.grafana_admin.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['org_id'] ||= '' unless new_resource.org_id.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['ldap']['group_mappings'][new_resource.group_dn]['org_id'] = new_resource.org_id.to_s unless new_resource.org_id.nil?
end
