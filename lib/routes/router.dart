import 'package:auto_route/auto_route_annotations.dart';
import 'package:myapp/features/helloworld/presentation/pages/helloworld_page.dart';
import 'package:myapp/features/joke/presentation/pages/joke_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: JokePage, initial: true),
    MaterialRoute(page: HelloWorldPage)
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
