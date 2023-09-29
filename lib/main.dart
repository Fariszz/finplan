import 'package:finplan/constant/route_constants.dart';
import 'package:finplan/screens/outcome_screen.dart';
import 'package:finplan/screens/income_screen.dart';
import 'package:finplan/screens/income_outcome_tracker_screen.dart';
import 'package:finplan/screens/home_screen.dart';
import 'package:finplan/screens/login_page.dart';
import 'package:finplan/screens/settings_screen.dart';
import 'package:finplan/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => const LoginScreen(),
  homeRoute: (BuildContext context) => const HomeScreen(),
  settingsRoute: (BuildContext context) => SettingsScreen(),
  addExpenseRoute: (BuildContext context) => OutcomeScreen(),
  addIncomeRoute: (BuildContext context) => IncomeScreen(),
  detailCashFlowRoute: (BuildContext context) => IncomeOutcomeTrackerScreen(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FinPlan App",
      routes: routes,
    );
  }
}
