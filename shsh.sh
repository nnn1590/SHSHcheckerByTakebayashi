#!/bin/sh
set -e

# Issue SHSH checker Ver.2.0 (fork)

COMMAND_NAME="${0:-shsh.sh}"
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  cat << EOF
Usage: ${COMMAND_NAME} [device MODEL] [ECID]

  if no or more than 2 arguments passed, show this usage and exit
  if one argument passed, check issued SHSHs (e.g.: ${COMMAND_NAME} iPhone10,3)
  if two arguments passed, get all issued SHSHs (e.g.: ${COMMAND_NAME} iPhone10,3 8237910564814894)
EOF
  exit 0
fi

RELEASE="$(curl -s "https://api.ipsw.me/v4/device/${1}?type=ipsw" | jq ".firmwares[] | select(.signed == true)")"
BETA="$(curl -s "https://api.m1sta.xyz/betas/${1}" | jq ".[] | select(.signed == true)")"
JSON="${BETA}${RELEASE}"

# One argument passed
if [ "${#}" = 1 ]; then
  echo "$(echo "${JSON}" | jq -sr '. | length') SHSH(s) available:"
  echo "${JSON}" | jq -r '. | .result = (.buildid|tostring) + " " + .version | .result' | sed "s/^/  /g"
  exit 0
fi

# Two arguments passed
if [ "${#}" = 2 ]; then
  if [ ! -d "$1" ]; then
    mkdir "$1"
  fi
  if [ ! -d "$1/$2" ]; then
    mkdir "$1/$2"
  fi
  cd "$1/$2"
  shshcount=0
  failed=0
  while [ "${shshcount}" -lt "$(echo "${JSON}" | jq -r 'select(.url)' | jq -sr length)" ]; do
    set +e
    pzb -g BuildManifest.plist "$(echo "${JSON}" | jq -r 'select(.url)' | jq -sr ".[${shshcount}].url")" &&
      tsschecker -d "$1" -e "$2" -m BuildManifest.plist --generator 0x1111111111111111 -s || failed=$(( failed + 1 ))
    mv BuildManifest.plist "$(echo "${JSON}" | jq -r 'select(.url)' | jq -sr ".[${shshcount}].buildid").plist"
    set -e
    shshcount=$(( shshcount + 1 ))
  done
  if [ "${failed}" -eq 0 ]; then
    echo "Saved $(echo "${JSON}" | jq -sr '. | length') SHSH(s):"
  else
    echo "Tried to save $(echo "${JSON}" | jq -sr '. | length') SHSH(s) (${failed} failed):"
  fi
  echo "${JSON}" | jq -r '. | .result = (.buildid|tostring) + " " + .version | .result' | sed "s/^/  /g"
  echo "to \"${PWD}\""
  if [ "${failed}" -ne 0 ]; then
    exit 1
  fi
  exit 0
fi

echo "Error: This line should not be executed"
exit 1
