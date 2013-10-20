# Class: wordpress
#
# This module manages wordpress
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
import '*.pp'

class wordpress
  (
    $def_db_name='wp',
    $def_db_user='wp',
    $def_db_password='password',
    $def_db_root_password='',
    $def_install_dir='/var/www/wp'
  )
{

  $db_name = $def_db_name
  $db_user = $def_db_user
  $db_password = $def_db_password
  $db_root_password = $def_db_root_password
  $wp_install_dir = $def_install_dir

  include wordpress::app
}
