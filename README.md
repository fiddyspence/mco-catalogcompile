catalog compile/apply/fact distribution via mcollective

requires some mcollective client.cfg and server.cfg magic so we know where to compile and how to authenticate:

    plugin.putfacts.key = /var/lib/peadmin/pe31.spence.org.uk.local_key.pem
    plugin.putfacts.cert = /var/lib/peadmin/pe31.spence.org.uk.local.pem
    plugin.putfacts.cacert = /var/lib/peadmin/ca_crt.pem
    plugin.putfacts.server = pe31.spence.org.uk.local
