#
# Cookbook Name::	kafka
# Description:: Base configuration for Kafka
# Recipe:: default
#

# == Recipes
include_recipe "kafka::install"
include_recipe "kafka::configure"
include_recipe "kafka::service"
