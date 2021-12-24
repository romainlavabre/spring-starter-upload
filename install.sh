#!/bin/bash

BASE_DIR="$1"
PACKAGE_PARSER=${BASE_DIR/"$2/src/main/java/com/"/""}
PACKAGES=""

IFS='/' read -ra ARRAY <<<"$PACKAGE_PARSER"
I=0

for PART in "${ARRAY[@]}"; do
    if [ "$I" == "0" ]; then
        PACKAGES="$PART"
    fi

    if [ "$I" == "1" ]; then
        PACKAGES="${PACKAGES}.${PART}"
    fi

    I=$((I + 1))
done

CLASSES=(
    "$1/UploadHandler.java"
    "$1/UploadHandlerImpl.java"
    "$1/Configuration.java"
    "$1/ContentTypeResolver.java"
    "$1/move/MoveRule.java"
    "$1/exception/DuplicationException.java"
    "$1/exception/UploadException.java"
    "$1/duplication/DuplicationRule.java"
    "$1/annotation/AcceptType.java"
    "$1/annotation/Duplication.java"
    "$1/annotation/Move.java"
    "$1/annotation/Size.java"
    "$1/annotation/TransactionSynchronized.java"
)

for CLASS in "${CLASSES[@]}"; do
    sed -i "s|replace.replace|$PACKAGES|" "$CLASS"
done
