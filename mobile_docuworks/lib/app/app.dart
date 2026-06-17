import 'package:flutter/material.dart';

import '../core/firebase/firebase_bootstrap.dart';
import '../features/home/home_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B6B5F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        useMaterial3: true,
      ),
      home: FutureBuilder<FirebaseBootstrapResult>(
        future: _firebaseState,
        builder: (context, snapshot) {
          return HomeScreen(firebaseState: snapshot.data);
        },
      ),
    );
  }
}
