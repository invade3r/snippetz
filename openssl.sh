#### Convert cert and private key to pfx ####################################

# Convert p7b to pem (intermediates)

openssl pkcs7 -print_certs -in gd-g2_iis_intermediates.p7b -out intermediates.pem

# Combine all certs to one (use -legacy for Mac)

openssl pkcs12 -export -out combined.pfx -inkey e345d5c63557f561.key -in e345d5c63557f561.pem -certfile gd_bundle-g2-g1.crt

# Combine without intermediates (use -legacy for Mac)

openssl pkcs12 -export -out certificate.pfx -inkey name.key -in name.pem

# Convert pem to der

openssl x509 -outform der -in certificatename.pem -out certificatename.der


# Check if certificate matches private key - Compare checksums of these three commands

openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum 

# Strip private key password

openssl rsa -in original.key -out new.key

# Create csr and private key

openssl req -newkey rsa:2048 -keyout PRIVATEKEY.key -out MYCSR.csr

# Check health of private key

openssl rsa -in PRIVATEKEY.key -check -noout

# Extract crt from pfx

openssl pkcs12 -clcerts -nokeys -in SourceFile.PFX -out certificate.crt

# Extract private key from pfx

openssl pkcs12 -nocerts -in SourceFile.PFX -out private.key

# Show info about pfx file

openssl pkcs12 -in example.pfx -info

# Selfsigned key and csr - no password on key because of -nodes

openssl req -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr

# Selfsigned certficate from key and csr

openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt

# Selfsigned oneliner - Remove -nodes to password protect key

openssl req -nodes -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
