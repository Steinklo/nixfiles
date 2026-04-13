# Linux Cheatsheet

## Files & Directories
ls -la          # List files detailed
mkdir dir       # Create directory
rm file         # Delete file
rm -r dir       # Delete directory
mv old new      # Move/rename
cp file copy    # Copy file
cp -r dir copy  # Copy directory

## Search
grep "text" file    # Search in file
grep -r "text" dir  # Search recursively
find . -name file   # Find file
which program       # Find where program is installed

## Processes
ps aux          # List all processes
kill PID        # Kill process by PID
pkill name      # Kill process by name

## System
df -h           # Show disk space
free -h         # Show RAM usage
ss -tulpn       # Show open ports
chmod +x file   # Make file executable

## NixOS
nix search nixpkgs program      # Search for package
nix-shell -p program            # Test package without installing
