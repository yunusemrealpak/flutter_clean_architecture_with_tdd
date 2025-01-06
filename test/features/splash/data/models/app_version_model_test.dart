import 'package:flutter_clean_architecture/src/features/splash/data/models/app_version_model.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/entities/app_version.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testAppVersionModel = AppVersionModel(
    currentVersion: '1.0.0',
    minimumVersion: '1.0.0',
    forceUpdate: false,
  );

  test(
    'should be a subclass of AppVersion entity',
    () async {
      // assert
      expect(testAppVersionModel, isA<AppVersion>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when JSON is valid',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'currentVersion': '1.0.0',
          'minimumVersion': '1.0.0',
          'forceUpdate': false,
        };

        // act
        final result = AppVersionModel.fromJson(jsonMap);

        // assert
        expect(result, testAppVersionModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing proper data',
      () async {
        // act
        final result = testAppVersionModel.toJson();

        // assert
        final expectedMap = {
          'currentVersion': '1.0.0',
          'minimumVersion': '1.0.0',
          'forceUpdate': false,
        };
        expect(result, expectedMap);
      },
    );
  });
}
