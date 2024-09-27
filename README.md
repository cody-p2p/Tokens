# Import the necessary libraries
```
import hashlib
import time
import json
```
# Define the token class
```
class Token:
    def __init__(self, user_id, expires_in=3600):
        self.user_id = user_id
        self.expires_in = expires_in
        self.token = self.generate_token()

    def generate_token(self):
        # Generate a random token using a hash function
        token = hashlib.sha256((str(self.user_id) + str(int(time.time()))).encode()).hexdigest()
        return token

    def verify_token(self, token):
        # Verify the token by checking if it matches the generated token
        if token == self.token:
            return True
        return False

    def get_user_id(self):
        return self.user_id
```
# Create a token for a user
```
user_id = 123
token = Token(user_id)
```

# Print the token
```
print("Token:", token.token)
```
# Verify the token
```
print("Is token valid?", token.verify_token(token.token))
```
# Try to verify an invalid token
```
print("Is invalid token valid?", token.verify_token("invalid_token"))
```
# Get the user ID from the token
```
print("User ID:", token.get_user_id())
```
# Token expiration
```
print("Token expires in:", token.expires_in, "seconds")
```
# Simulate token expiration
```
time.sleep(token.expires_in)
print("Token still valid?", token.verify_token(token.token))  # Should be False
```
# Create a new token with a new expiration time
```
new_token = Token(user_id, expires_in=7200)
print("New token:", new_token.token)
print("New token expires in:", new_token.expires_in, "seconds")
```
