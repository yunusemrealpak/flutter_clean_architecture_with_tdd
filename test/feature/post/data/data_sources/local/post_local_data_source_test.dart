// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// abstract class PostLocalDataSource {
//   Future<int> insertOrUpdate(PostDO post);
//   Future<PostDO?> getById(int id);
//   Future<List<PostDO>> getAll();
//   Future<bool> delete(int id);
// }
//
// class PostLocalDataSourceImpl implements PostLocalDataSource {
//   final PostLocalClient _client;
//
//   PostLocalDataSourceImpl(this._client);
//
//   @override
//   Future<int> insertOrUpdate(PostDO post) => _client.insertOrUpdate(post);
//
//   @override
//   Future<PostDO?> getById(int id) => _client.getById(id);
//
//   @override
//   Future<List<PostDO>> getAll() => _client.getAll();
//
//   @override
//   Future<bool> delete(int id) => _client.delete(id);
// }
//
// abstract class PostLocalClient {
//   Future<int> insertOrUpdate(PostDO post);
//   Future<PostDO?> getById(int id);
//   Future<List<PostDO>> getAll();
//   Future<bool> delete(int id);
// }
//
// class PostDO {
//   final int id;
//   final String title;
//   final String body;
//
//   PostDO({required this.id, required this.title, required this.body});
// }
//
// class MockPostLocalClient extends Mock implements PostLocalClient {}
//
// void main() {
//   late PostLocalDataSource dataSource;
//   late PostLocalClient client;
//
//   setUp(() {
//     client = MockPostLocalClient();
//     dataSource = PostLocalDataSourceImpl(client);
//   });
//
//   group('[PostLocalDataSource]', () {
//     final tPostDO = PostDO(id: 1, title: 'title', body: 'body');
//
//     test('should insert or update post successfully', () async {
//       // arrange
//       when(() => client.insertOrUpdate(tPostDO)).thenAnswer((_) async => 1);
//
//       // act
//       final result = await dataSource.insertOrUpdate(tPostDO);
//
//       // assert
//       expect(result, equals(1));
//       verify(() => client.insertOrUpdate(tPostDO)).called(1);
//     });
//
//     test('should get post by id successfully', () async {
//       // arrange
//       when(() => client.getById(1)).thenAnswer((_) async => tPostDO);
//
//       // act
//       final result = await dataSource.getById(1);
//
//       // assert
//       expect(result, equals(tPostDO));
//       verify(() => client.getById(1)).called(1);
//     });
//
//     test('should get all posts successfully', () async {
//       // arrange
//       final tPosts = [tPostDO];
//       when(() => client.getAll()).thenAnswer((_) async => tPosts);
//
//       // act
//       final result = await dataSource.getAll();
//
//       // assert
//       expect(result, equals(tPosts));
//       verify(() => client.getAll()).called(1);
//     });
//
//     test('should delete post successfully', () async {
//       // arrange
//       when(() => client.delete(1)).thenAnswer((_) async => true);
//
//       // act
//       final result = await dataSource.delete(1);
//
//       // assert
//       expect(result, equals(true));
//       verify(() => client.delete(1)).called(1);
//     });
//   });
// }
