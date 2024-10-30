import os
import stat

def analyze_file(file_path):
    # Get file metadata
    file_size = os.path.getsize(file_path)
    file_mode = os.stat(file_path).st_mode
    file_mtime = os.path.getmtime(file_path)
    file_ctime = os.path.getctime(file_path)
    file_atime = os.path.getatime(file_path)

    # Determine file type
    file_type = None
    if file_size == 0:
        file_type = "empty file"
    elif file_size < 1024:
        file_type = "small file"
    elif file_size < 1048576:
        file_type = "medium file"
    else:
        file_type = "large file"

    # Determine file permissions
    permissions = []
    if stat.S_ISREG(file_mode):
        permissions.append("regular file")
    elif stat.S_ISDIR(file_mode):
        permissions.append("directory")
    elif stat.S_ISLNK(file_mode):
        permissions.append("symbolic link")
    elif stat.S_ISFIFO(file_mode):
        permissions.append("fifo")
    elif stat.S_ISSOCK(file_mode):
        permissions.append("socket")
    else:
        permissions.append("unknown file type")

    # Print analysis results
    print(f"File: {file_path}")
    print(f"Size: {file_size} bytes")
    print(f"Type: {file_type}")
    print(f"Permissions: {permissions}")
    print(f"Last modified: {file_mtime}")
    print(f"Last accessed: {file_atime}")
    print(f"Last changed: {file_ctime}")

# Example usage
file_path = "path/to/example/file.txt"
analyze_file(file_path)
