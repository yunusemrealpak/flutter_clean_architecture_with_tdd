import 'package:flutter_test/flutter_test.dart';

class UserEntity {
  final int id;
  final String email;
  final String name;
  final String photoUrl;
  final String? token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
    this.token,
  });
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.photoUrl,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      if (token != null) 'token': token,
    };
  }

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? photoUrl,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  const UserModel.test()
      : super(
          id: 1,
          email: '_test_email',
          name: '_test_name',
          photoUrl: '_test_photoUrl',
          token: '_test_token',
        );
}

class JsonReader {
  static Map<String, dynamic> readJson(String path) {
    return {
      'id': 1,
      'email': 'john@gmail.com',
      'name': 'John Doe',
      'photoUrl':
          'https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png',
    };
  }
}

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

    test('should return a different model when copyWith with different values', () {
      // arrange
      const tUserModel = UserModel(
        id: 1,
        email: 'test@test.com',
        name: 'Test User',
        photoUrl: 'test_url',
      );

      // act
      final result = tUserModel.copyWith(
        email: 'new@test.com',
        name: 'New User',
      );

      // assert
      expect(result != tUserModel, true);
      expect(result.email, 'new@test.com');
      expect(result.name, 'New User');
      expect(result.id, tUserModel.id);
      expect(result.photoUrl, tUserModel.photoUrl);
    });
  });
}
