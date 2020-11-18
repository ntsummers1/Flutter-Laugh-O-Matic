import 'package:flutter/material.dart';
import 'package:myapp/features/joke/presentation/pages/joke_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke Generator',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purple,
      ),
      home: JokePage(),
    );
  }
}
