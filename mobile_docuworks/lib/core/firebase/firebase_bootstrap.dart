import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class FirebaseBootstrapResult {
  const FirebaseBootstrapResult.configured() : error = null;

  const FirebaseBootstrapResult.notConfigured(this.error);

  final Object? error;

  bool get isConfigured => error == null;
}

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  static Future<FirebaseBootstrapResult> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      return const FirebaseBootstrapResult.configured();
    } on UnsupportedError catch (error) {
      return FirebaseBootstrapResult.notConfigured(error);
    } on FirebaseException catch (error) {
      return FirebaseBootstrapResult.notConfigured(error);
    } catch (error) {
      return FirebaseBootstrapResult.notConfigured(error);
    }
  }
}
