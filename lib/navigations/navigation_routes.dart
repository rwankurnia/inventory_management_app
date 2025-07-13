import 'package:flutter/material.dart';
import '../screens/signin_screen/signin_screen.dart';
import '../screens/register_screen/register_screen.dart';
import '../screens/inventory_list_screen/inventory_list_screen.dart';

class NavigationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/inventory':
        return MaterialPageRoute(builder: (_) => InventoryListScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
    }
  }
}
