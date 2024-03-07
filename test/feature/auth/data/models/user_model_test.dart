import 'package:flutter_clean_architecture/src/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  group('UserModel', () {
    const tUserModel = UserModel(
      id: 1,
      email: 'john@gmail.com',
      name: 'John Doe',
      photoUrl:
          'https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png',
    );

    test('should be a subclass of User entity', () async {
      // assert
      expect(tUserModel, isA<UserEntity>());
    });

    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = JsonReader.readJson('feature/auth/dummy_data/user.json');

      // act
      final result = UserModel.fromJson(jsonMap);

      // assert
      expect(result, tUserModel);
    });

    test('should be equal to model that return from copyWith with different email', () {
      // arrange
      const tUserModel = UserModel(
        id: 1,
        email: '',
        name: '',
        photoUrl: '',
      );

      // act
      final x = tUserModel.copyWith(email: '');

      // assert
      expect(tUserModel == x, true);
    });
  });
}
