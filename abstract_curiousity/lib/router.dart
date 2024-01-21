import 'package:abstract_curiousity/Features/UserRegisteration/screens/personaliseTopics.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  return MaterialPageRoute(
    settings: routeSettings,
    builder: (_) {
      switch (routeSettings.name) {
        case (ChooseTopics.routeName):
          return const ChooseTopics();
        default:
          return const Text('No route defined for this');
      }
    },
  );
}
