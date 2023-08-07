#!/bin/sh
# original authors & credit: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html#UsingWithRDS.SSL-certificate-rotation-sample-script

mydir=/var/jdk-keystores
if [ ! -e "${mydir}" ]
then
mkdir -p "${mydir}"
fi

truststore="${JAVA_HOME}/lib/security/cacerts"
storepassword=changeit # only use plaintext password for cicd/build containers not production worker containers

curl -sS "https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem" > ${mydir}/global-bundle.pem
awk 'split_after == 1 {n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1}{print > "rds-ca-" n ".pem"}' < ${mydir}/global-bundle.pem

for CERT in rds-ca-*; do
  alias=$(openssl x509 -noout -text -in $CERT | perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print')
  echo "Importing $alias"
  keytool -import -file ${CERT} -cacerts -storepass ${storepassword} -alias "${alias}" -noprompt
  rm $CERT
done

rm ${mydir}/global-bundle.pem        