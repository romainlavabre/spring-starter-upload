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
    "$1/DocumentStoreHandler.java"
    "$1/S3.java"
)

for CLASS in "${CLASSES[@]}"; do
    sed -i "s|replace.replace|$PACKAGES|" "$CLASS"
done

info "You need import this dependency
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>bom</artifactId>
            <version>2.15.15</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
AND
<dependencies>
    <dependency>
        <groupId>software.amazon.awssdk</groupId>
        <artifactId>s3</artifactId>
    </dependency>
</dependencies>
"

info "You need add this variables
public interface Variable {
    String DOCUMENT_PUBLIC_KEY  = \"document.aws.public-key\";
    String DOCUMENT_PRIVATE_KEY = \"document.aws.private-key\";
    String DOCUMENT_AWS_BUCKET  = \"document.aws.bucket\";
}"
