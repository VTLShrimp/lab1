// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1/app.dart';

void main() {
  testWidgets('GlowCart home screen with navigation', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GlowCartApp());

    // Verify that home screen loads with expected UI elements.
    expect(find.text('Sản phẩm nổi bật'), findsOneWidget);
    expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);

    // Verify product list displays.
    expect(find.text('Tai nghe Orion X'), findsOneWidget);
    expect(find.text('Đồng hồ Nova Fit'), findsOneWidget);
    expect(find.text('Loa Mini Beam'), findsOneWidget);

    // Verify bottom navigation bar exists.
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.text('Giỏ hàng'), findsWidgets);
    expect(find.text('Đơn hàng'), findsOneWidget);

    // Tap on cart tab and verify cart screen appears.
    await tester.tap(find.text('Giỏ hàng').last);
    await tester.pump();

    // Verify cart screen is empty initially.
    expect(find.text('Giỏ hàng trống'), findsOneWidget);
  });
}
