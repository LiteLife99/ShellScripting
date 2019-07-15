#!/bin/bash
echo "enter domain name"
read domain1
if [ -z $domain1 ]
then
	echo "domain name left blank. exitting program"
	exit 0
else
	echo "domain name is valid"
fi
echo "domain name is $domain1"
echo "enter tld for example .com,.in,etc. If left blank, default is .com"
read domain2
if [ -z $domain2 ]
then
        echo "tld left blank. setting tld to .com by default"
        domain2=.com
else
        echo "tld name is valid"
fi
echo "website url is www.$domain1$domain2"
touch /etc/httpd/conf.d/$domain1.conf
echo "enter html page name"
read doc
mkdir /var/www/html/$doc
echo "<html>
	<body>
	this page is named $doc
	</body>
      </html>" > /var/www/html/$doc/$doc.html
echo "<VirtualHost 192.168.1.155>
		ServerName www.$domain1$domain2
		DocumentRoot /var/www/html/$doc
      </VirtualHost>" > /etc/httpd/conf.d/$domain1.conf
echo "192.168.1.155 www.$domain1$domain2" >> /etc/hosts
systemctl restart httpd
ping -c 5 www.$domain1$domain2
exit 0
     
