# Load the public key
public_key = PGPKey.from_file('path/to/public/key.asc')

# Load the private key
private_key = PGPKey.from_file('path/to/private/key.asc')

# Encrypt a file using the public key
with open('path/to/file.txt', 'rb') as file:
    file_data = file.read()
encrypted_file_data = public_key.encrypt(file_data)

# Decrypt the file using the private key
with open('path/to/decrypted_file.txt', 'wb') as file:
    file.write(private_key.decrypt(encrypted_file_data))
