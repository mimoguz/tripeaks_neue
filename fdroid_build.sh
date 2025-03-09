sed -i -e '/signingConfigs {/,/^    }/d' -e '/signingConfig =/d' ./android/app/build.gradle.kts
flutter build apk --split-per-abi --release