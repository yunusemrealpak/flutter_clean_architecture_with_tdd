import 'package:flutter_clean_architecture/src/feature/post/data/model/post_model.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  group('[PostModel] Test', () {
    const postModel = PostModel(
      id: 1,
      userId: 1,
      title: '_test_title',
      body: '_test_body',
    );

    test('should be a subclass of PostEntity', () {
      // assert
      expect(postModel, isA<PostEntity>());
    });

    group('[fromJson]', () {
      test('should return a valid model when the JSON is valid', () {
        // arrange
        final Map<String, dynamic> jsonMap =
            JsonReader.readJson('feature/post/dummy_data/post.json');
        // act
        final result = PostModel.fromJson(jsonMap);
        // assert
        expect(result, postModel);
      });
    });

    group('[toJson]', () {
      test('should return a JSON map containing the proper data', () {
        // act
        final result = postModel.toJson();
        // assert
        final expectedMap = {
          "id": 1,
          "userId": 1,
          "title": "_test_title",
          "body": "_test_body",
        };
        expect(result, expectedMap);
      });
    });

    group('[copyWith]', () {
      test('should return a copy of the model', () {
        // act
        final result = postModel.copyWith(title: '_test_new_title');
        // assert
        expect(result == postModel, false);
      });
    });
  });
}
