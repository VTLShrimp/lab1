import 'package:flutter/material.dart';

import 'models/checkout_args.dart';
import 'models/category_content_args.dart';
import 'screens/app_shell.dart';
import 'screens/category_content_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/profile_screen.dart';

class GlowCartApp extends StatelessWidget {
  const GlowCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlowCart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B7A75),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppShell.routeName,
      routes: {
        AppShell.routeName: (context) => const AppShell(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CheckoutScreen.routeName) {
          final args = settings.arguments;
          if (args is CheckoutArgs) {
            return MaterialPageRoute(
              builder: (context) => CheckoutScreen(args: args),
            );
          }
        }

        if (settings.name == CategoryContentScreen.routeName) {
          final args = settings.arguments;
          if (args is CategoryContentArgs) {
            return MaterialPageRoute(
              builder: (context) => CategoryContentScreen(args: args),
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Route không tồn tại.'))),
        );
      },
    );
  }
}
