import 'package:flutter/material.dart';
import '../pages/list.dart';
import '../pages/search.dart';

final routes = {
  '/list': (context, {arguments}) => MusicListPage(arguments: arguments),
  '/search': (context) => SearchPage()
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
