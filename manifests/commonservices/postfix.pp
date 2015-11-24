class postfix (
$myhostname,
$mydomain,
$mydestination,
$relayhost,
) {

package {'postfix':
  ensure => 'installed',
  }

file {'/tmp/bhavin':
  content => "
smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
biff = no
append_dot_mydomain = no
readme_directory = no
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = $myhostname
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
mydomain = $mydomain
myorigin = /etc/mailname
mydestination = $mydestination
relayhost = $relayhost
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = loopback-only
inet_protocols = all
",
  require => Package['postfix']
  }

}
