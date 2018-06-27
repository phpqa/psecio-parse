#!/usr/bin/env sh
set -e

isCommand() {
  for cmd in \
    "help" \
    "list" \
    "rules" \
    "scan"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/psecio-parse "$@"
elif [ "$1" = "/composer/vendor/bin/psecio-parse" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "psecio-parse" ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /composer/vendor/bin/psecio-parse "$@"
fi

exec "$@"
