#!/usr/bin/env bash
#取得可能なSHSHを検索し一覧にします

set -eu

declare TMPFILE DEVICE
TMPFILE="$(mktemp)"
DEVICE="${1:-iPhone9,4}"
readonly TMPFILE DEVICE

trap 'rm "${TMPFILE}"' EXIT

echo "# SHSH checker Ver.1.0.1 (fork)"
echo "対象の端末: ${DEVICE}"
curl -s https://shsh.host | grep 'var signed_array =' | sed -Ee 's/(var signed_array =|;\r?$)//g' > "${TMPFILE}"
jq -rS ".\"${DEVICE}\""' | to_entries[] | "\t\(.key) - \(.value)"' "${TMPFILE}" || {
	echo "エラー: 一覧の取得に失敗しました。端末「${DEVICE}」が存在しないなどの原因が考えられます。" >&2
	exit 1
}
echo "以上$(jq -rS ".\"${DEVICE}\""' | length' "${TMPFILE}")個のSHSH取得が可能です。"
