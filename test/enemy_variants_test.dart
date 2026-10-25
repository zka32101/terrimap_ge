import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrimap_core/battle/difficulty.dart';
import 'package:terrimap_core/battle/grid.dart';
import 'package:terrimap_core/battle/stage_generator.dart';
import 'package:terrimap_de/app_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('敵の見た目違い: ステージの州・地方に合うものだけが、ArtSet に入る', () async {
    final app = await AppState.load();
    final gen = StageGenerator(app.pack);
    final south = await app.art(stage: gen.generate('DE-BY', Difficulty.normal)); // 南
    final north = await app.art(stage: gen.generate('DE-SH', Difficulty.normal)); // 北
    expect(south.enemyVariants['armored'], ['stone_giant']);
    expect(north.enemyVariants['armored'], ['ice_golem']);
    // どこでも出るものは、どの州にも入る
    expect(south.enemyVariants['normal'], containsAll(['kobold_miner', 'wichtel']));
    expect(north.enemyVariants['normal'], ['wichtel']);
    // 基本の見た目は、見た目違いの候補に入らない
    for (final a in [south, north]) {
      for (final e in a.enemyVariants.entries) {
        expect(e.value, isNot(contains(a.enemySkins[e.key])));
      }
    }
    // ステージを渡さないとき(図鑑・クイズなど)は、見た目違いなし
    expect((await app.art()).enemyVariants, isEmpty);
  });

  test('敵の見た目違い: 地方決戦でも、その地方の見た目違いが入る', () async {
    final app = await AppState.load();
    final st = StageGenerator(app.pack).generate('north', Difficulty.normal, kind: StageKind.regional);
    final art = await app.art(stage: st);
    expect(art.enemyVariants['speedy'], containsAll(['field_hare', 'rat_pack']));
    expect(art.enemyVariants['armored'], ['ice_golem']);
  });
}
