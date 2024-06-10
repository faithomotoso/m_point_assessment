import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/pages/dashboard.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M Estate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: Dashboard.routeName,
      routes: {
        Dashboard.routeName : (ctx) => const Dashboard()
      },
    );
  }
}
