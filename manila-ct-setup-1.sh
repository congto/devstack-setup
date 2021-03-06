#!/bin/bash
clear

controller=192.168.43.11

echo "Adding manila user (set in service project)..."
openstack user create --domain default --project service --password myservicepassword manila

echo "Adding manila user in admin role..."
openstack role add --project service --user manila admin

echo "Adding service entry for manila..."
openstack service create --name manila --description "OpenStack Shared Filesystem" share
openstack service create --name manilav2 --description "OpenStack Shared Filesystem V2" sharev2

echo "Adding endpoint for manila (public)..."
openstack endpoint create --region RegionOne share public http://$controller:8786/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne sharev2 public http://$controller:8786/v2/%\(tenant_id\)s 

echo "Adding endpoint for manila (internal)..."
openstack endpoint create --region RegionOne share internal http://$controller:8786/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne sharev2 internal http://$controller:8786/v2/%\(tenant_id\)s

echo "Adding endpoint for manila (admin)..."
openstack endpoint create --region RegionOne share admin http://$controller:8786/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne sharev2 admin http://$controller:8786/v2/%\(tenant_id\)s
