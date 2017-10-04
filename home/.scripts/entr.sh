#!/bin/bash
#
# Breaks down the steps needed to run entr for a set of file extensions into
# something a little bit easier to grok

CMD=eval

if [ $# -lt 1 ]; then
    echo "Usage $0 WHERE 'EXT [EXT...]' BUILD RUN" >&2
    exit 1
fi

WHERE="${1}"
EXTS="${2}"
BUILD="${3}"
RUN="${4}"
ACTION="${BUILD} && ${RUN}"

REGEX=""
for EXT in ${EXTS}; do
    [ -z "${REGEX}" ] && REGEX=".*\\.\\(${EXT}" && continue
    REGEX="${REGEX}\\|${EXT}"
done
REGEX="${REGEX}\\)"

$CMD "find \"${WHERE}\" -regex \"${REGEX}\" -not -regex \".*/build/.*\" | entr -c bash -c \"${ACTION}\""
