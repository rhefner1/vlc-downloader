#!/usr/bin/env sh

# Start up VM with attributes:
#   - Location: europe-west-3 (Frankfurt)
#   - Size: n1-standard-2
#   - Access: Allow full access to all Cloud APIs

# Then:
#   1. Click SSH button next to VM
#   2. Run `sudo su`
#   3. Set these variables:

export URL=""
export NAME="elevation-"

# Then:
#   4. Paste in commands below

apt update
apt install -y curl git make
curl https://get.docker.com | bash
mkdir /app
cd /app
git clone https://github.com/rhefner1/vlc-downloader
cd vlc-downloader
make convert-video DEST_DIR=/app url=${URL} name=${NAME}
gsutil cp /app/${NAME}.mkv gs://rhefner-archive/elevation/full
gsutil cp /app/${NAME}.mkv gs://rhefner-projects-eu/

# Then:
#  5. Delete the VM
#  6. Download and then delete the file from rhefner-projects-eu