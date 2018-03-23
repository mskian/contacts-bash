#!/bin/bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Santhosh veer
#   file:      contacts.sh
#   created:   23.03.2018
#   revision:  23.03.2018
#   version:   0.1
# -----------------------------------------------------------------------------
# Requirements:
#   curl, jq
# Description:
#   Contact Storage using Firebase Reatime Database - https://github.com/mskian/contacts-bash
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

# Version Info
VERSION=0.1

# Firebase Realtime Database URL
# Replace it with your Database URL - Don't Remove /contacts.json
DBURL="https://contactscli.firebaseio.com/contacts.json"

## File name
SCRIPTNAME=$(basename "$0")

# -----------------------------------------------------------------------------

# Get Full Contact List
get_contacts(){

#echo "Usage :  $SCRIPTNAME -c"

echo -e "\\n"
echo -e "\\033[1;32m My Personal Contact Details \\033[0m"
echo -e "\\n"

# cURL Request - GET Method
 curl -s --request GET \
    --url "$DBURL" \ | jq -r '["MY CONTACTS"], ["-----------"], (.[] | [.name, .number]) | @tsv'

echo -e "\\n"

}

# Add Contacts
add_contacts(){

echo -e "\\n"
echo -e "\\033[1;32m == Contact Storage == \\033[0m"
echo -e "\\n"

echo -n "Enter a Person Name: "
read -r usrname

echo -n "Enter a Mobile/Phone Number: "
read -r usrnumber

echo -e "\\n"

 # If no Inputs you will see this Alert message
  if [[ ! $usrname ]]; then
    echo -e "\\033[1;31m Error: person Name is Missing \\033[0m \\n"
    exit 1
fi

  if [[ ! $usrnumber ]]; then
    echo -e "\\033[1;31m Error: Mobile/Phone Number is Missing \\033[0m \\n"
    exit 1
  fi

 # Quoting the Input
body=$(printf '{"name":"%s","number":"%s"}' "$usrname" "$usrnumber")

# Curl request
  curl -s --request POST \
  "$DBURL" \
  -H "Accept: application/json" \
  --data "$body" | jq 

}

# Help Message
help(){
  echo -e "\\n"
  echo -e  "$SCRIPTNAME [options]
        
           Example:
           contacts.sh -a

          Options:
          -a   Add Contacts
          -c   Get the Contact List
          -h   Display Help Message
          -v   Check CLI Version
          \\n"
}

# No input params triggers this error
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "\\n"
      echo -e "\\033[1;31m Error:  No input \\033[0m \\n"
      help
      exit 1
    fi
}

# Check for required packages
check_requirements(){
  local requirements=("$@")
  for app in "${requirements[@]}"; do
    type "$app" >/dev/null 2>&1 || \
      { echo >&2 "$app is required but it's not installed. Aborting."; exit 1; }
  done
}

# Main Functions
main(){
  check_for_empty_input "$@"
  check_requirements jq curl

  while getopts ':acvh' flag; do
  case "$flag" in 
a)
  add_contacts
  ;;
c)
  get_contacts
  exit 0
  ;;
v)
  echo -e "\\033[1;32m Version $VERSION \\033[0m"
  exit 0
  ;;
h) 
help
exit 0
;;
  ?)
  echo "script usage: $SCRIPTNAME [-a] [-c] [-v] [-h]" >&2
  exit 1
  ;;
*)

 esac
done
  shift $((OPTIND-1))
}

main "$@"

exit 0
