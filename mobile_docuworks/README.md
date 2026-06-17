# Mobile DocuWorks

Aplicacion Flutter para Android e iOS con base preparada para Firebase.

## Requisitos

- Flutter SDK disponible. En este repo puedes usar el SDK local desde `..\bin\flutter.bat`.
- Android Studio o VS Code con extensiones de Flutter/Dart.
- Para iOS necesitas macOS con Xcode.
- Un proyecto creado en Firebase Console.

## Comandos utiles

Desde esta carpeta:

```powershell
..\bin\flutter.bat pub get
..\bin\flutter.bat analyze
..\bin\flutter.bat test
..\bin\flutter.bat run
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
- `lib/app/app.dart`: configura `MaterialApp`, tema y arranque de Firebase.
- `lib/core/firebase/firebase_bootstrap.dart`: inicializacion segura de Firebase.
- `lib/features/home/home_screen.dart`: pantalla inicial.
