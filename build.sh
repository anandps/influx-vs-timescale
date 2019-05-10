#! /bin/bash
DIRECTORY_TO_OBSERVE="docs"
BUILD_SCRIPT="asciidoctor -r asciidoctor-diagram docs/index.adoc"

function block_for_change {
  inotifywait -r \
    -e modify,move,create,delete \
    $DIRECTORY_TO_OBSERVE
}

function build {
  $BUILD_SCRIPT
}

build
while block_for_change; do
  build
done
