# Create Cronjob for LetsEncrypt
* clone repository with git clone https://github.com/AM2H-Development/LetsEncrypt.git
* cd LetsEncrypt
* chmod a+x ./ssl.sh
* sudo cp ./ssl.sh /usr/local/bin/

Edit crontab with sudo crontab -e

23 4 * * * ssl.sh test.domain.tld

create directories:
* mkdir /etc/letsencrypt
* mkdir /var/lib/letsencrypt
