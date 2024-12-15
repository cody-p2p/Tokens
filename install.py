# Import the required modules
import os
import time

# Define the software package details
package_name = "MySoftware"
version = "1.0.0"
size = "622MB"

# Define the installation steps
steps = [
    "Downloading the package...",
    "Extracting the package...",
    "Installing the package...",
    "Configuring the package...",
    "Verifying the package installation..."
]

# Define the installation progress bar
progress_bar = ["-", "-", "-", "-", "-"]

# Start the installation process
print(f"Installing {package_name} version {version}...")

# Simulate the download process
print(steps[0])
time.sleep(2)
print("Download complete!")

# Simulate the extraction process
print(steps[1])
time.sleep(1)
print("Extraction complete!")

# Simulate the installation process
print(steps[2])
time.sleep(3)
print("Installation complete!")

# Simulate the configuration process
print(steps[3])
time.sleep(2)
print("Configuration complete!")

# Simulate the verification process
print(steps[4])
time.sleep(1)
print("Verification complete!")

# Display the installation progress bar
for i in range(5):
    print(f"Progress: {progress_bar[i]}")
    time.sleep(0.5)

# Display the final installation message
print(f"Installation of {package_name} version {version} complete!")
print(f"Size: {size}")
print("Your software is now ready to use!")
