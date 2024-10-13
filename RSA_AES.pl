use strict;
use warnings;
use Crypt::RSA;

# Load the RSA key pair
my $rsa = Crypt::RSA->new('path/to/private/key.pem', 'path/to/public/key.pem');

# Encrypt some data
my $data = 'Hello, World!';
my $encrypted = $rsa->encrypt($data);
print "Encrypted: $encrypted\n";

# Decrypt the data
my $decrypted = $rsa->decrypt($encrypted);
print "Decrypted: $decrypted\n";
