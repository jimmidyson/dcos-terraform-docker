#!/bin/sh

set -xeuo pipefail
IFS=$'\n\t'

if [ -n "${SSH_PRIVATE_KEY_FILE:-}" ]; then
	eval $(ssh-agent | head -2)
	ssh-add "${SSH_PRIVATE_KEY_FILE}"
fi

terraform init >&2

exec terraform "$@"
