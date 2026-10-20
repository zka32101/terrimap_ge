import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrimap_core/battle/difficulty.dart';
import 'package:terrimap_core/battle_ui/art_set.dart';
import 'package:terrimap_de/app_state.dart';
import 'package:terrimap_de/screens/collection_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('図鑑: 物語カードは、章を終えると集まり（未クリアは「？」と鍵）、ボスの画像があれば出て、タップで読み返せる', (t) async {
    await t.binding.setSurfaceSize(const Size(800, 2400));
    addTearDown(() => t.binding.setSurfaceSize(null));
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('en');
    final chapters = app.story!.chapters;
    final extra = chapters.firstWhere((c) => c.stageId == 'de_loreley');
    final img = (await t.runAsync(() async {
      final rec = ui.PictureRecorder();
      Canvas(rec).drawRect(const Rect.fromLTWH(0, 0, 8, 8), Paint()..color = Colors.red);
      return rec.endRecording().toImage(8, 8);
    }))!;
    final art = ArtSet(images: {'bosses/de_loreley': img});

    await t.pumpWidget(MaterialApp(home: CollectionScreen(app: app, art: art)));
    await t.pump();
    expect(find.byKey(const ValueKey('story-cards-title')), findsOneWidget);
    expect(find.text('Story  0 / ${chapters.length}'), findsOneWidget);
    expect(find.byKey(ValueKey('story-card-${extra.id}')), findsOneWidget);
    expect(find.text(extra.title.of('en')), findsNothing); // 未クリアは「？」
    expect(find.byIcon(Icons.lock_outline), findsWidgets);

    await t.runAsync(() => app.recordBattleClear(extra.kind, extra.stageId, Difficulty.easy));
    await t.pumpWidget(MaterialApp(home: CollectionScreen(app: app, art: art)));
    await t.pump();
    expect(find.text('Story  1 / ${chapters.length}'), findsOneWidget);
    expect(find.text(extra.title.of('en')), findsOneWidget);
    expect(find.byKey(ValueKey('story-card-image-${extra.id}')), findsOneWidget); // ボスの画像
    await t.tap(find.byKey(ValueKey('story-card-${extra.id}')));
    await t.pumpAndSettle();
    expect(find.byKey(const ValueKey('story-line')), findsOneWidget); // 読み返せる
    expect(t.takeException(), isNull);
  });
}
