#!/bin/bash

# Function to display a message
display_message() {
  echo "-----> $1"
}

# Function to install packages
install_packages() {
  display_message "Updating package lists..."
  sudo apt-get update

  display_message "Installing packages..."
  sudo apt-get -y install apache2 mysql-server php libapache2-mod-php php-mysql git
}

# Function to clone a GitHub repository
clone_repository() {
  local repo_url="https://github.com/laravel/laravel"
  local app_dir="/var/www/html/php-application"

  display_message "Cloning the PHP application from GitHub..."
  git clone "$repo_url" "$app_dir"
}

# Function to configure MySQL
configure_mysql() {
   Function to configure MySQL
configure_mysql() {
    echo "Configuring MySQL..."
    sudo mysql_secure_installation
}

# Function to configure Apache
configure_apache() {
  echo "Configuring Apache to serve the PHP application..."
  sudo sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot /var/www/html/php-application/' /etc/apache2/sites-available/000-default.conf
  sudo systemctl restart apache2
}

# Function to set file permissions
set_file_permissions() {
  local app_dir="/var/www/html/php-application"

  display_message "Setting file permissions for the application directory..."
  sudo chown -R www-data:www-data "$app_dir"
  sudo chmod -R 755 "$app_dir"
}

# Main script
display_message "Starting provisioning script..."

install_packages
clone_repository
configure_mysql
configure_apache
set_file_permissions

display_message "Provisioning script completed!"

# Configure MySQL
configure_mysql

echo "PHP application cloned and configured successfully."