import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/common/local_database/local_db_manager.dart';
import 'package:flutter_clean_architecture/src/feature/post/presentation/pages/post_list_view.dart';
import 'package:flutter_clean_architecture/src/injectable/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InjectionContainer.configureDependencies();

  await di<LocalDBManager>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostListView(),
    );
  }
}
