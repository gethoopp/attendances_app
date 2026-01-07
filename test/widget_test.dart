import 'package:attendance_app/view/auth/register.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test Button Register", (WidgetTester tester) async {
    await tester.pumpWidget(RegisterScreenPage());
    final buttonFirstName = find.text("First Name");
    final buttonRegister = find.text("Daftar");

    expect(buttonFirstName, findsOneWidget);
    await tester.tap(buttonFirstName);

    await tester.pump();
    expect(find.text("Masukkan email dengan benar"), findsOneWidget);
  });
}
