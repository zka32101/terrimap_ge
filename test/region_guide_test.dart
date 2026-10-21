import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrimap_de/app_state.dart';
import 'package:terrimap_de/screens/region_guide_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('解説ページ: 州名・州都・紹介文・となりの州・名所が出る', (t) async {
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('en');
    await t.pumpWidget(MaterialApp(home: RegionGuideScreen(app: app, regionId: 'DE-BY')));
    await t.pump();
    expect(find.byKey(const ValueKey('guide-title')), findsOneWidget);
    expect(find.text(app.s.regionName('DE-BY')), findsWidgets);
    expect(find.textContaining(app.s.capitalName('DE-BY')), findsOneWidget);
    expect(find.byKey(const ValueKey('guide-blurb')), findsOneWidget);
    expect(find.byType(ActionChip), findsWidgets); // 名所のチップ
    expect(find.byKey(const ValueKey('guide-neighbors')), findsOneWidget);
  });

  testWidgets('解説ページ: 紹介文は表示言語になる(日本語)', (t) async {
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('ja');
    await t.pumpWidget(MaterialApp(home: RegionGuideScreen(app: app, regionId: 'DE-BE')));
    await t.pump();
    expect(find.textContaining('首都'), findsWidgets);
  });

  testWidgets('州の地図のシートと、クイズの答え合わせから、解説ページに入れる', (t) async {
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('en');
    await t.pumpWidget(MaterialApp(home: Builder(builder: (c) => TextButton(onPressed: () => openRegionGuide(c, app, 'DE-HH'), child: const Text('go')))));
    await t.tap(find.text('go'));
    await t.pumpAndSettle();
    expect(find.byKey(const ValueKey('guide-title')), findsOneWidget);
    expect(find.text(app.s.regionName('DE-HH')), findsWidgets);
  });
}
