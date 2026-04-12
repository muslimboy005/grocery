import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/screens/login_screen.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(LoginUI), findsOneWidget);
    expect(find.text('Xush kelibsiz'), findsOneWidget);
  });
}
