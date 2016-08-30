# updateOS.sh

It check checks /etc/issue for the OS version.If it's Ubuntu it rund apt-get, if anything else it runs dnf install.
It created a log file /tmp/updateOS.sh.
Once completed it sends a text message.
