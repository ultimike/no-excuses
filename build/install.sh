#!/bin/bash

# Script from http://craychee.io/blog/2015/07/29/no-excuses-part2-drupal-config
# To manually run from the commandline:
#  vagrant ssh
#  cd /vagrant/build
#  sh ./install.sh

set -e

path=$(dirname "$0")
base=$(cd $path/.. && pwd)
drush="drush $drush_flags -y -r $base/www"

chmod -R +w $base/www/sites/default
chmod -R +w $base/cnf

echo "Symlink settings.php into our Drupal."
ln -sf $base/cnf/settings.php $base/www/sites/default/
echo "Installing Drupal like a boss."
$drush si --site-name=no-excuses --account-pass=admin
echo "Installing and enabling commonly used modules.
$drush dl admin_menu module_filter
$drush dis toolbar
$drush en admin_menu admin_menu_toolbar module_filter
