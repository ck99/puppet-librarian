#! /bin/bash
rm -rf ./temp-modules
rm -rf ./installed-modules
librarian-puppet install --verbose --path=./installed-modules/
rsync -a ./installed-modules/ ./temp-modules --exclude='.git*'
rm -rf installed-modules
rsync -a ./temp-modules/ ./installed-modules
rm -rf ./temp-modules
