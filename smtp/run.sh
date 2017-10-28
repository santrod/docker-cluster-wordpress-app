#!/bin/bash

[ -z "${SMTP_SERVER}" ] && echo "SMTP_SERVER is not set" && exit 1
[ -z "${SMTP_USERNAME}" ] && echo "SMTP_USERNAME is not set" && exit 1
[ -z "${SMTP_PASSWORD}" ] && echo "SMTP_PASSWORD is not set" && exit 1

#Get the domain from the server host name
DOMAIN=`echo $SERVER_HOSTNAME |awk -F. '{$1="";OFS="." ; print $0}' | sed 's/^.//'`

#Comment default mydestination, we will set it bellow
#echo "relayhost = $SMTP_SERVER" >> /etc/postfix/main.cf
sed -i -e 's/inet_interfaces = localhost/inet_interfaces = all/g' /etc/postfix/main.cf
sed -i -e "s/relayhost =/relayhost = $SMTP_SERVER/g" /etc/postfix/main.cf
echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf
echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> /etc/postfix/main.cf

rm /etc/postfix/sasl_passwd
touch /etc/postfix/sasl_passwd
echo "[$SMTP_SERVER]:587 $SMTP_USERNAME:$SMTP_PASSWORD" >> /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

chown root:root /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd

service postfix start
