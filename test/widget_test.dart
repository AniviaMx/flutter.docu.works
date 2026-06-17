import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_docuworks/app/app.dart';

void main() {
  testWidgets('shows the DocuWorks start screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DocuWorksApp());
    await tester.pump();

    expect(find.text('DocuWorks'), findsOneWidget);
    expect(find.text('Firebase pendiente'), findsOneWidget);
    expect(find.text('Modulos preparados'), findsOneWidget);
  });
}
