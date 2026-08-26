export FLUTTER_VERSION="$(tr -d '\r\n ' < flutter-version)"
pushd ~/.local/bin/flutter/
git checkout $FLUTTER_VERSION
popd