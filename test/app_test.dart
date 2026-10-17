import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrimap_core/pack/pack_validator.dart';
import 'package:terrimap_core/quiz/quiz_engine.dart';
import 'package:terrimap_ge/app_state.dart';
import 'package:terrimap_ge/main.dart';
import 'package:terrimap_ge/screens/quiz_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('同梱のドイツpackは検証を通る', () {
    String r(String f) => File('packs/de/$f').readAsStringSync();
    expect(
      PackValidator.validate(
        packJson: r('pack.json'),
        regionsJson: r('regions.json'),
        geoJson: r('geo.geojson'),
        stringsJsonByLang: {'en': r('strings/en.json'), 'de': r('strings/de.json')},
      ),
      isEmpty,
    );
  });

  test('AppState: 16州を読み込み、進捗は保存されて再起動後も残る', () async {
    final a = await AppState.load();
    expect(a.pack.regions, hasLength(16));
    expect(a.progress.masteredCount, 0);
    await a.record('DE-BY', correct: true);
    await a.record('DE-BE', correct: false);

    final b = await AppState.load(); // 再起動を模す
    expect(b.progress.masteredCount, 1);
    expect(b.progress.stateOf('DE-BE').name, 'missed');
  });

  test('言語を切り替えると地域名・州都名が変わる', () async {
    final a = await AppState.load();
    await a.setLang('en');
    expect(a.s.regionName('DE-BY'), 'Bavaria');
    expect(a.s.capitalName('DE-BY'), 'Munich');
    await a.setLang('de');
    expect(a.s.regionName('DE-BY'), 'Bayern');
    expect(a.s.capitalName('DE-BY'), 'München');
  });

  testWidgets('ホーム→クイズ: ホームが表示され、クイズ画面に進める', (t) async {
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('en');
    await t.pumpWidget(TerrimapApp(app: app));
    await t.pump();
    expect(find.text('State Master – Germany'), findsOneWidget);
    expect(find.text('0 / 16'), findsOneWidget);

    await t.tap(find.text('Quiz'));
    await t.pumpAndSettle();
    expect(find.text('1 / 10'), findsOneWidget);
  });

  testWidgets('QuizScreen: 4択を押すと結果が出て、次へ進める', (t) async {
    final app = await t.runAsync(AppState.load) as AppState;
    await app.setLang('en');
    final qs = QuizEngine(app.pack, seed: 5).generate(count: 2, types: [QuestionType.nameFromMap]);
    List<bool>? result;
    await t.pumpWidget(MaterialApp(
      home: Builder(
        builder: (ctx) => TextButton(
          onPressed: () async => result = await Navigator.of(ctx)
              .push<List<bool>>(MaterialPageRoute(builder: (_) => QuizScreen(app: app, questions: qs))),
          child: const Text('go'),
        ),
      ),
    ));
    await t.tap(find.text('go'));
    await t.pumpAndSettle();

    final correct = app.s.regionName(qs[0].correctId);
    await t.tap(find.text(correct));
    await t.pumpAndSettle();
    expect(find.text('Correct!'), findsOneWidget);
    await t.tap(find.text('Next'));
    await t.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);
    await t.tap(find.text(app.s.regionName(qs[1].correctId)));
    await t.pumpAndSettle();
    await t.tap(find.text('Finish'));
    await t.pumpAndSettle();
    expect(result, [true, true]);
    expect(app.progress.masteredCount, 2);
  });
}
