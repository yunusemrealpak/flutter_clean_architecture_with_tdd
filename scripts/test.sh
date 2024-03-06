flutter test --coverage
lcov --remove coverage/lcov.info \
'lib/main.dart' \
'lib/**/*.g.dart' \
'lib/injectable/*' \
'lib/core/*' \
'lib/config/*' \
-o coverage/lcov.info
genhtml coverage/lcov.info --output=coverage

if [ "$1" = "windows" ]; then
    start coverage/index.html
else
    open coverage/index.html
fi