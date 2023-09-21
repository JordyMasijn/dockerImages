#!/bin/bash
mydir=tmp/certs
if [ ! -e "${mydir}" ]
then
mkdir -p "${mydir}"
fi

truststore=${JAVA_HOME}/lib/security/cacerts
storepassword=changeit

curl -sS "https://truststore.pki.rds.amazonaws.com/eu-west-1/eu-west-1-bundle.pem" > "${mydir}/eu-west-1-bundle.pem"
awk 'split_after == 1 {n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1}{print > "rds-ca-" n ".pem"}' < "${mydir}/eu-west-1-bundle.pem"

for CERT in rds-ca-*; do
  alias=$(openssl x509 -noout -text -in "${CERT}" | perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print')
  echo "Importing ${alias}"
  keytool -import -file "${CERT}" -alias "${alias}" -storepass "${storepassword}" -keystore "${truststore}" -noprompt
  rm "${CERT}"
done

rm "${mydir}/eu-west-1-bundle.pem"

echo "Trust store content is: "

keytool -list -v -keystore "${truststore}" -storepass "${storepassword}" | grep Alias | cut -d " " -f3- | while read -r alias
do
   expiry=$(keytool -list -v -keystore "${truststore}" -storepass "${storepassword}" -alias "${alias}" | grep Valid | perl -ne 'if(/until: (.*?)\n/) { print "$1\n"; }')
   echo " Certificate ${alias} expires in '$expiry'" 
done
                