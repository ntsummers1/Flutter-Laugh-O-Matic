import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myapp/routes/router.gr.dart' as Router;
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
        builder: ExtendedNavigator.builder<Router.Router>(
            router: Router.Router(), initialRoute: "/"));
  }
}
