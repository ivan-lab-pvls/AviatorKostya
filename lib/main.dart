import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jorney_map/util/app_routes.dart';

import 'data/repository/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFirstTime = await OnboardingRepository().checkFirstTime();
  runApp(MyApp(isFirstLaunch: isFirstTime));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
    );
  }
}
