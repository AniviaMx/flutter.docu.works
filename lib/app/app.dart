import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/firebase/firebase_bootstrap.dart';
import '../features/auth/presentation/login_screen.dart';

class DocuWorksApp extends StatefulWidget {
  const DocuWorksApp({super.key});

  @override
  State<DocuWorksApp> createState() => _DocuWorksAppState();
}

class _DocuWorksAppState extends State<DocuWorksApp> {
  late final Future<FirebaseBootstrapResult> _firebaseState =
      FirebaseBootstrap.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuWorks',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => FutureBuilder<FirebaseBootstrapResult>(
          future: _firebaseState,
          builder: (context, snapshot) {
            return LoginScreen(firebaseState: snapshot.data);
          },
        ),
      },
    );
  }
}
