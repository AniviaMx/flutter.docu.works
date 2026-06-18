import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_docuworks/app/app.dart';

void main() {
  testWidgets('shows the DocuWorks login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DocuWorksApp());
    await tester.pumpAndSettle();

    expect(find.text('DocuWorks'), findsOneWidget);
    expect(find.text('Inicia sesion'), findsOneWidget);
    expect(find.text('Correo electronico'), findsOneWidget);
    expect(find.text('Contrasena'), findsOneWidget);
    expect(find.text('Firebase aun no esta configurado.'), findsOneWidget);
  });

  testWidgets('validates empty login form', (WidgetTester tester) async {
    await tester.pumpWidget(const DocuWorksApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();

    expect(find.text('Ingresa tu correo.'), findsOneWidget);
    expect(find.text('Ingresa tu contrasena.'), findsOneWidget);
  });

  testWidgets('shows pending authentication message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DocuWorksApp());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(EditableText).at(0),
      'usuario@docuworks.com',
    );
    await tester.enterText(find.byType(EditableText).at(1), 'secret123');
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();

    expect(
      find.text('Autenticacion pendiente de conectar con Firebase.'),
      findsOneWidget,
    );
  });
}
