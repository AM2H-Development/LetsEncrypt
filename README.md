# Create Cronjob for LetsEncrypt
* clone repository with git clone https://github.com/AM2H-Development/LetsEncrypt.git
* cd LetsEncrypt
* cp ./ssl.sh /usr/local/bin/

Edit crontab with sudo crontab -e

23 4 * * * ssl.sh {DOMAIN}
