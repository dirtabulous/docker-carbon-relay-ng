FROM raintank/carbon-relay-ng:0.8.8

ADD storage-schemas.conf /conf/storage-schemas.conf

ADD goenvtemplator-amd64 /bin/goenvtemplator
ADD carbon-relay-ng.ini.tmpl /conf/carbon-relay-ng.ini.tmpl

ENTRYPOINT ["/bin/goenvtemplator", "-template", "/conf/carbon-relay-ng.ini.tmpl:/conf/carbon-relay-ng.ini", "-exec"]
CMD [ "/bin/carbon-relay-ng", "/conf/carbon-relay-ng.ini"]
