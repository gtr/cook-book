#!/usr/bin/env bash

set -e

export WORK_DIR=$(cd $(dirname $0) && pwd)
export RECIPE_DIR=$(cd $WORK_DIR/recipes && pwd)
export STYLES_DIR=$(cd $WORK_DIR/styles && pwd)

cd $WORK_DIR

cli_help() {
  cli_name=${0##*/}
  echo "$cli_name

Version: $(cat $WORK_DIR/VERSION)
Usage: $cli_name [command]
Commands:
  new       Create a new recipe
  *         Help
"
  exit 1
}

case "$1" in
  new|n)
    echo "new"
    ;;
  build|b)
    RECIPES=""
    for ENTRY in "$RECIPE_DIR"/*
    do
      RECIPES="$RECIPES$ENTRY "
    done
    pandoc -f markdown -t html -o index.html $RECIPES -c "$STYLES_DIR/styles.css"
    ;;
  *)
    cli_help
    ;;
esac
