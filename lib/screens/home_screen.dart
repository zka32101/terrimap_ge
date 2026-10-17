import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terrimap_core/daily/daily_challenge.dart';
import 'package:terrimap_core/map/region_map_view.dart';
import 'package:terrimap_core/progress/region_progress.dart';
import 'package:terrimap_core/quiz/quiz_engine.dart';

import '../app_state.dart';
import 'quiz_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState app;
  const HomeScreen({super.key, required this.app});

  Future<void> _startQuiz(BuildContext context) async {
    final qs = QuizEngine(app.pack, seed: DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF)
        .generate(count: 10, types: QuestionType.values);
    final results = await Navigator.of(context)
        .push<List<bool>>(MaterialPageRoute(builder: (_) => QuizScreen(app: app, questions: qs)));
    if (results != null && context.mounted) _showResult(context, results, null);
  }

  Future<void> _startDaily(BuildContext context) async {
    final date = _utcDate();
    final qs = DailyChallenge.forDate(app.pack, date);
    final results = await Navigator.of(context)
        .push<List<bool>>(MaterialPageRoute(builder: (_) => QuizScreen(app: app, questions: qs)));
    if (results != null && context.mounted) {
      _showResult(context, results, DailyChallenge.shareText(app.s.t('appTitle'), date, results));
    }
  }

  static String _utcDate() {
    final d = DateTime.now().toUtc();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }

  void _showResult(BuildContext context, List<bool> results, String? share) {
    final s = app.s;
    final score = results.where((e) => e).length;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.t('result')),
        content: Text('$score / ${results.length}\n${results.map((e) => e ? '🟩' : '🟥').join()}'),
        actions: [
          if (share != null)
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: share));
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(s.t('copied'))));
                }
              },
              child: Text(s.t('share')),
            ),
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(s.t('home'))),
        ],
      ),
    );
  }

  String _titleLabel(RegionTitle t) => app.s.t(t.name);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final s = app.s;
        final p = app.progress;
        return Scaffold(
          appBar: AppBar(
            title: Text(s.t('appTitle')),
            actions: [
              IconButton(
                tooltip: s.t('settings'),
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SettingsScreen(app: app))),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(children: [
                  Chip(label: Text(_titleLabel(p.title))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LinearProgressIndicator(value: p.ratio, minHeight: 8),
                  ),
                  const SizedBox(width: 12),
                  Text('${p.masteredCount} / ${p.total}'),
                ]),
              ),
              Expanded(
                child: RegionMapView(
                  pack: app.pack,
                  colorOf: (id) => defaultRegionColor(p.stateOf(id)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  Expanded(
                    child: FilledButton(onPressed: () => _startQuiz(context), child: Text(s.t('quiz'))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonal(
                        onPressed: () => _startDaily(context), child: Text(s.t('daily'))),
                  ),
                ]),
              ),
            ]),
          ),
        );
      },
    );
  }
}
