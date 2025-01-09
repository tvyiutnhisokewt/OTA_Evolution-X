#!/bin/bash

# Author: nhansp
# 10/01/2025

# Since I don't want to tamper with vendor/lineage/build/tools/createjson.sh,
# I'm making this script to upload my own builds and generate jsons.

# Check if the argument exists
if [ $# -eq 0 ]; then
  echo "
Usage: 
./upload_lineage.sh <device> [build_date] ["is_minimal"]
  
  device: the device about to be uploaded

  build_date: if specified, get the builds on a specific date
  "is_minimal": if specified, get the minimal type build

___________________________________________________________________________

tvyiunhisokewt 2025
https://github.com/tvyiutnhisokewt
made by nhansp ft. yuuki with bash, R2 Cloudflare, GitHub Releases and hope"
  exit 2
fi

# Define target out folder
product_out="$(eval echo ~$USER)/android/out/target/product/$1"

# LineageOS version
lineage="22.1"

# Check if we have specified the desired build date, otherwise get today's date
if [[ $2 -eq 0 ]]; then
	build_date=`date +'%Y%m%d'`
else
  echo "build_date has been set to $2"
	build_date=$2
fi

# Check if we are getting the minimal build
if [[ $3 == "is_minimal" ]]; then
  filename="lineage-$lineage-$build_date-UNOFFICIAL-$1_minimal.zip"
elif [[ $3 -eq 0 ]]; then
  filename="lineage-$lineage-$build_date-UNOFFICIAL-$1.zip"
else
  echo "
$3 is an invalid build type.
supported types are: is_minimal"
  exit 2
fi

# Before we do anything, check if the build exists
if [ ! -e "$product_out/$filename" ]; then
    echo "$product_out/$filename not found, did you build today?"
    exit 2
fi

# Device specifics
if [ $1 == "bluejay" ]; then
    download="https://pub-4a686e4731f74758ab53df526a4fe7da.r2.dev/$filename"
elif [ $1 == "cheetah" ]; then
    download="https://pub-0679a3a7a63a4485aedebca702f8f1e3.r2.dev/$filename"
fi

# Get and calculate product properties
buildprop=$product_out/system/build.prop
linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
md5=`md5sum "$product_out/$filename" | cut -d' ' -f1`
size=`stat -c "%s" "$product_out/$filename"`

# Output json
json="builds/$1.json"
if [ -e "$json" ]; then
  rm "$json"
fi
echo "Exporting $json"
echo '{
  "response": [
    {
      "datetime": '$timestamp',
      "filename": "'$filename'",
      "id": "'$md5'",
      "romtype": "'UNOFFICIAL'",
      "size": '$size',
      "url": "'$download'",
      "version": "'$lineage'"
    }
  ]
}' >> "$json"
cat $json
echo
echo

# Commit to git repository
echo "Commiting to OTA repo"
git add builds/$1.json
git commit -m "$1: $(date +'%d/%m/%Y')

Co-authored-by: Yuuki2k6 <phuocduy252@gmail.com>"
git push
echo
echo

# Upload OTA package
echo "Emptying $1 bucket"
rclone --min-size 0 delete r2:$1

echo "Uploading $1"

# For Pixel 6a: Upload boot, dtbo, vendor_boot and OTA package
if [ $1 == "bluejay" ]; then
  rclone copy "$product_out/boot.img" r2:$1
  rclone copy "$product_out/dtbo.img" r2:$1
  rclone copy "$product_out/vendor_boot.img" r2:$1
  rclone copy "$product_out/$filename" r2:$1
fi

# For Pixel 7 Pro: Upload boot, dtbo, vendor_boot, vendor_kernel_boot and OTA package
if [ $1 == "cheetah" ]; then
  rclone copy "$product_out/boot.img" r2:$1
  rclone copy "$product_out/dtbo.img" r2:$1
  rclone copy "$product_out/vendor_boot.img" r2:$1
  rclone copy "$product_out/vendor_kernel_boot.img" r2:$1
  rclone copy "$product_out/$filename" r2:$1
fi

echo
echo

echo "Done"
