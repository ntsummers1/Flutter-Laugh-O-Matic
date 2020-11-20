// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/helloworld/presentation/pages/helloworld_page.dart';
import '../features/joke/presentation/pages/joke_page.dart';

class Routes {
  static const String jokePage = '/';
  static const String helloWorldPage = '/hello-world-page';
  static const all = <String>{
    jokePage,
    helloWorldPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.jokePage, page: JokePage),
    RouteDef(Routes.helloWorldPage, page: HelloWorldPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    JokePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => JokePage(),
        settings: data,
      );
    },
    HelloWorldPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HelloWorldPage(),
        settings: data,
        fullscreenDialog: true,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushJokePage() => push<dynamic>(Routes.jokePage);

  Future<dynamic> pushHelloWorldPage() => push<dynamic>(Routes.helloWorldPage);
}
