import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_text_field/post_screen.dart';
import 'package:twitter_text_field/view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPostViewModel(),
      builder: (context, _) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Post Text Field',
          home: AddPostScreen(),
        );
      },
    );
  }
}
