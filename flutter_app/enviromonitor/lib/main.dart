import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/dashboard/dashboard_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: EnviroMonitorApp(),
    ),
  );
}

class EnviroMonitorApp
    extends StatelessWidget {
  const EnviroMonitorApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,
      title: 'EnviroMonitor',
      home: const DashboardPage(),
    );
  }
}