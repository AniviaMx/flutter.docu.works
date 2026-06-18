# Mobile DocuWorks

Aplicacion Flutter para Android e iOS con base preparada para Firebase.

## Requisitos

- Flutter SDK en `C:\Users\alans\OneDrive\Documents\GitHub\flutter`.
- Android Studio o VS Code con extensiones de Flutter/Dart.
- Para iOS necesitas macOS con Xcode.
- Un proyecto creado en Firebase Console.

## Comandos utiles

Desde esta carpeta:

```powershell
C:\Users\alans\OneDrive\Documents\GitHub\flutter\bin\flutter.bat pub get
C:\Users\alans\OneDrive\Documents\GitHub\flutter\bin\flutter.bat analyze
C:\Users\alans\OneDrive\Documents\GitHub\flutter\bin\flutter.bat test
C:\Users\alans\OneDrive\Documents\GitHub\flutter\bin\flutter.bat run
```

## Firebase

Las dependencias iniciales ya estan agregadas:

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_storage`

El archivo `lib/firebase_options.dart` es un placeholder para que la app compile antes de conectar Firebase. Cuando tengas tu proyecto real, ejecuta:

```powershell
dart pub global activate flutterfire_cli
flutterfire configure
```

Selecciona Android e iOS, usa el package id `com.docuworks.mobile_docuworks`, y permite que FlutterFire reemplace `lib/firebase_options.dart`.

## Estructura inicial

- `lib/main.dart`: punto de entrada.
- `lib/app/app.dart`: configura `MaterialApp`, rutas y arranque de Firebase.
- `lib/app/app_theme.dart`: tema visual centralizado.
- `lib/core/firebase/firebase_bootstrap.dart`: inicializacion segura de Firebase.
- `lib/features/auth/presentation/login_screen.dart`: pantalla de login con validaciones locales. La autenticacion real aun no esta conectada.
