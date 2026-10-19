import 'dart:ui' show Locale;
import 'package:app_common_kit/app_common_kit.dart' show KitStrings;
import 'package:terrimap_core/pack/region_pack.dart';

/// 画面の文言(英語・ドイツ語)と、packからの地域名・州都名の引き当て。
class Strings {
  final String lang;
  final RegionPack pack;
  Strings(this.lang, this.pack);

  static const supported = ['en', 'de', 'ja'];

  static const _ui = <String, Map<String, String>>{
    'en': {
      'appTitle': 'State Master – Germany',
      'quiz': 'Quiz',
      'daily': 'Daily challenge',
      'review': 'Review mistakes',
      'landmarkQuiz': 'Landmark quiz',
      'stats': 'Statistics',
      'settings': 'Settings',
      'progress': 'Progress',
      'language': 'Language',
      'attribution': 'Data credits',
      'locate': 'Tap this state on the map:',
      'nameFromMap': 'Which state is highlighted?',
      'capitalFromName': 'What is the capital of this state?',
      'nameFromCapital': 'Which state has this capital?',
      'silhouette': 'Which state has this shape?',
      'neighborOf': 'Which state borders this one?',
      'landmarkOf': 'In which state is this landmark?',
      'correct': 'Correct!',
      'wrong': 'Not quite.',
      'next': 'Next',
      'finish': 'Finish',
      'result': 'Result',
      'again': 'Play again',
      'home': 'Home',
      'share': 'Copy result',
      'copied': 'Copied to clipboard',
      'answerWas': 'Answer:',
      'beginner': 'Beginner',
      'explorer': 'Explorer',
      'expert': 'Expert',
      'master': 'Master',
      'locked': 'Locked',
      'unlockTitle': 'Unlock all 16 states',
      'unlockBody': 'Play every state and remove ads with a one-time purchase. No subscription.',
      'unlockButton': 'Unlock',
      'restore': 'Restore purchases',
      'notNow': 'Not now',
      'freeStates': 'Free states',
      'battle': 'Battle',
      'battleSubtitle': 'Defend the state capital',
    },
    'de': {
      'appTitle': 'Bundesländer-Meister',
      'quiz': 'Quiz',
      'daily': 'Tagesaufgabe',
      'review': 'Fehler wiederholen',
      'landmarkQuiz': 'Sehenswürdigkeiten-Quiz',
      'stats': 'Statistik',
      'settings': 'Einstellungen',
      'progress': 'Fortschritt',
      'language': 'Sprache',
      'attribution': 'Datenquellen',
      'locate': 'Tippe dieses Bundesland auf der Karte an:',
      'nameFromMap': 'Welches Bundesland ist markiert?',
      'capitalFromName': 'Was ist die Hauptstadt dieses Bundeslandes?',
      'nameFromCapital': 'Welches Bundesland hat diese Hauptstadt?',
      'silhouette': 'Welches Bundesland hat diese Form?',
      'neighborOf': 'Welches Bundesland grenzt an dieses?',
      'landmarkOf': 'In welchem Bundesland liegt diese Sehenswürdigkeit?',
      'correct': 'Richtig!',
      'wrong': 'Leider falsch.',
      'next': 'Weiter',
      'finish': 'Fertig',
      'result': 'Ergebnis',
      'again': 'Nochmal',
      'home': 'Start',
      'share': 'Ergebnis kopieren',
      'copied': 'In die Zwischenablage kopiert',
      'answerWas': 'Antwort:',
      'beginner': 'Anfänger',
      'explorer': 'Entdecker',
      'expert': 'Experte',
      'master': 'Meister',
      'locked': 'Gesperrt',
      'unlockTitle': 'Alle 16 Bundesländer freischalten',
      'unlockBody': 'Alle Bundesländer spielen und Werbung entfernen – einmaliger Kauf, kein Abo.',
      'unlockButton': 'Freischalten',
      'restore': 'Käufe wiederherstellen',
      'notNow': 'Nicht jetzt',
      'freeStates': 'Kostenlose Bundesländer',
      'battle': 'Schlacht',
      'battleSubtitle': 'Verteidige die Hauptstadt',
    },
    'ja': {
      'quiz': 'クイズ',
      'daily': '今日のチャレンジ',
      'review': 'まちがいを復習',
      'landmarkQuiz': '名所クイズ',
      'stats': '統計',
      'settings': '設定',
      'progress': '進み具合',
      'language': '言語',
      'attribution': 'データの出典',
      'correct': '正解！',
      'wrong': 'おしい！',
      'next': '次へ',
      'finish': '終了',
      'result': '結果',
      'again': 'もう一度',
      'home': 'ホーム',
      'share': '結果をコピー',
      'copied': 'コピーしました',
      'answerWas': '答え:',
      'beginner': 'ビギナー',
      'explorer': '探検家',
      'expert': 'エキスパート',
      'master': 'マスター',
      'locked': 'ロック中',
      'unlockBody': '買い切りで、すべての州が遊べて、広告も消えます。サブスクではありません。',
      'unlockButton': '解放する',
      'restore': '購入を復元',
      'notNow': '今はしない',
      'freeStates': '無料の州',
      'battle': 'バトル',
      'battleSubtitle': '州都を守ろう',
      'locate': 'この州を地図でタップ:',
      'nameFromMap': 'ハイライトされているのはどの州？',
      'capitalFromName': 'この州の州都は？',
      'nameFromCapital': 'この州都がある州は？',
      'silhouette': 'このシルエットはどの州？',
      'neighborOf': 'この州と接しているのはどの州？',
      'landmarkOf': 'この名所はどの州にある？',
      'appTitle': 'ステートマスター – ドイツ',
      'unlockTitle': '16州をすべて解放',
    },
  };

  /// キット(購入欄)の文言。内蔵にないドイツ語は、英語を土台に購入まわりだけ訳す。
  static final KitStrings kitDe = KitStrings.en.copyWith(
    languageCode: 'de',
    purchaseTitle: 'Kauf',
    purchasedPremium: 'Alle Bundesländer freigeschaltet – ohne Werbung',
    purchasedNoAds: 'Werbefrei',
    purchaseRestore: 'Käufe wiederherstellen',
    purchaseSuccess: 'Vielen Dank! Alles ist freigeschaltet.',
    purchaseCancelled: 'Kauf abgebrochen.',
    purchaseBlocked: 'Kauf nicht möglich.',
    purchaseFailed: 'Der Kauf ist fehlgeschlagen. Bitte versuche es später erneut.',
    restoreDone: 'Käufe wiederhergestellt.',
    restoreNone: 'Keine Käufe gefunden.',
    reviewEnjoyTitle: 'Gefällt dir die App?',
    reviewYes: 'Ja',
    reviewNo: 'Nicht so',
    reviewLater: 'Später',
  );

  /// キットの部品の文言。キットが内蔵する言語（日本語・韓国語・中国語・英語）はそれを、ドイツ語はアプリの訳を、ほかは英語を使う。
  KitStrings get kit => switch (lang) {
        'de' => kitDe,
        'ja' || 'ko' || 'zh' || 'en' => KitStrings.forLocale(Locale(lang)),
        _ => KitStrings.en,
      };

  String t(String key) => _ui[lang]?[key] ?? _ui['en']![key] ?? key;

  String regionName(String id) =>
      pack.strings[lang]?['regions']?[id] ?? pack.strings['en']?['regions']?[id] ?? id;

  String capitalName(String regionId) {
    final capId = pack.regions.firstWhere((r) => r.id == regionId).capitalId;
    if (capId == null) return regionName(regionId);
    return pack.strings[lang]?['capitals']?[capId] ?? pack.strings['en']?['capitals']?[capId] ?? capId;
  }
}
