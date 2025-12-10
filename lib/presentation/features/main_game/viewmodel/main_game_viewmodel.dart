import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rook_clicker/data/models/upgrade.dart';

class MainGameViewmodel extends ChangeNotifier {
  final String title = 'Rook Clicker!';

  int _cheatCounter = 0;

  int _lilyCounter = 0;
  int get lilyCounter => _lilyCounter;

  int _queenOfTheNightCounter = 0;
  int get queenOfTheNightCounter => _queenOfTheNightCounter;

  bool _isRookHeartVisible = false;
  bool get isRookHeartVisible => _isRookHeartVisible;

  bool _isShellBugHeartVisible = false;
  bool get isShellBugHeartVisible => _isShellBugHeartVisible;

  bool _isRookJumping = false;
  bool get isRookJumping => _isRookJumping;

  bool _isLilyBouncing = false;
  bool get isLilyBouncing => _isLilyBouncing;

  // Upgrades
  // Lily
  bool shellBugPurchased = false;
  int _queenOfTheNightMultiplier = 1;

  // Queen of The Night
  bool witcherPurchased = false;
  bool witcherEquiped = false;
  bool dragonBornPurchased = false;
  bool dragonBornEquiped = false;
  bool urPurchased = false;

  List<Upgrade> get lilyUpgrades {
    final upgrades = <Upgrade>[];

    // Only add the 'Frend Joins' upgrade if it has not been purchased yet.
    if (!shellBugPurchased) {
      upgrades.add(
        Upgrade(text: 'Frend Joins: 10 lilies', onPressed: purchaseShellBug),
      );
    }

    upgrades.add(
      Upgrade(
        text: shellBugPurchased
            ? 'QOTN Multiplier ${_queenOfTheNightMultiplier + 1}: ${_queenOfTheNightMultiplier * 10} lillies'
            : 'LOCKED',
        onPressed: purchaseQueenOfTheNightMultiplier,
      ),
    );

    return upgrades;
  }

  List<Upgrade> get queenOfTheNightUpgrades {
    final upgrades = <Upgrade>[];

    if (!witcherPurchased) {
      upgrades.add(
        Upgrade(
          text: 'Henry?: 50 QOTN',
          onPressed: purchaseWitcher,
        ),
      );
    }

    if (witcherPurchased && !dragonBornPurchased) {
      upgrades.add(
        Upgrade(
          text: 'Mora power: 100 QOTN',
          onPressed: purchaseDragonBorn,
        ),
      );
    }

    if (witcherPurchased && dragonBornPurchased && !urPurchased) {
      upgrades.add(
        Upgrade(
          text: "URm what there's more?: 500 QOTN",
          onPressed: purchaseUr,
        ),
      );
    }

    return upgrades;
  }

  List<Upgrade> get unlockedCustomizations {
    final upgrades = <Upgrade>[];

    if (witcherPurchased) {
      upgrades.add(
        Upgrade(
          text: 'Witcher Equipped? $witcherEquiped',
          onPressed: equipWitcher,
        ),
      );
    }

    if (dragonBornPurchased) {
      upgrades.add(
        Upgrade(
          text: 'Dragon Born Equipped? $dragonBornEquiped',
          onPressed: equipDragonBorn,
        ),
      );
    }

    return upgrades;
  }

  List<Upgrade> get cheatUpgrade => [
    Upgrade(
      text: 'Cheat',
      onPressed: cheatMode,
    ),
  ];

  late Timer _textTimer;
  int _currentTextIndex = 0;
  final List<String> _urSayings = [
    "Welcome, Moon-and-Star...",
    "Come to me through fire and war...",
    "Come, Nerevar...",
    "Come and look upon the heart, upon the heart.",
  ];

  String get currentUrSaying => _urSayings[_currentTextIndex];

  void _startTextTimer() {
    _textTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentTextIndex + 1 == _urSayings.length) {
        return;
      }
      _currentTextIndex = (_currentTextIndex + 1) % _urSayings.length;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _textTimer.cancel();
    super.dispose();
  }

  void _bounceLily() {
    _isLilyBouncing = true;
    notifyListeners();
    // Reset the jumping state after the animation duration
    Future.delayed(const Duration(milliseconds: 50), () {
      _isLilyBouncing = false;
      notifyListeners();
    });
  }

  void _jumpRook() {
    _isRookJumping = true;
    notifyListeners();
    // Reset the jumping state after the animation duration
    Future.delayed(const Duration(milliseconds: 200), () {
      _isRookJumping = false;
      notifyListeners();
    });
  }

  void _showRookHeart() {
    _isRookHeartVisible = true;
    notifyListeners();
    // Hide the heart after a short delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      _isRookHeartVisible = false;
      notifyListeners();
    });
  }

  void _showShellBugHeart() {
    _isShellBugHeartVisible = true;
    notifyListeners();
    // Hide the heart after a short delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      _isShellBugHeartVisible = false;
      notifyListeners();
    });
  }

  void incrementCounter() {
    _cheatCounter = 0;
    _lilyCounter++;
    _bounceLily();
    _jumpRook();

    if (shellBugPurchased) {
      _queenOfTheNightCounter += _queenOfTheNightMultiplier;
      // TODO(Dakotah): Bounce ShellBug
      // TODO(Dakotah): Bounce Queen Of The Night
    }

    notifyListeners();
  }

  void cheatMode() {
    _cheatCounter++;
    if (_cheatCounter == 3) {
      _lilyCounter = 9999999;
      _queenOfTheNightCounter = 9999999;
      notifyListeners();
    }
  }

  void petTheRook() {
    _showRookHeart();
  }

  void petTheShellBug() {
    _showShellBugHeart();
  }

  void purchaseShellBug() {
    if (_lilyCounter >= 10) {
      _lilyCounter -= 10;
      shellBugPurchased = true;
      notifyListeners();
    }
  }

  void purchaseQueenOfTheNightMultiplier() {
    if (_lilyCounter >= 10 * _queenOfTheNightMultiplier) {
      _lilyCounter -= 10 * _queenOfTheNightMultiplier;
      _queenOfTheNightMultiplier += 1;
      notifyListeners();
    }
  }

  void purchaseUr() {
    if (_queenOfTheNightCounter >= 500) {
      _queenOfTheNightCounter -= 500;
      urPurchased = true;
      _startTextTimer();
      notifyListeners();
    }
  }

  // Purchase Customizations

  void purchaseWitcher() {
    if (_queenOfTheNightCounter >= 50) {
      _queenOfTheNightCounter -= 50;
      witcherPurchased = true;
      equipWitcher();
    }
  }

  void purchaseDragonBorn() {
    if (_queenOfTheNightCounter >= 100) {
      _queenOfTheNightCounter -= 100;
      dragonBornPurchased = true;
      equipDragonBorn();
    }
  }

  // Equip Customization

  void equipWitcher() {
    witcherEquiped = !witcherEquiped;
    notifyListeners();
  }

  void equipDragonBorn() {
    dragonBornEquiped = !dragonBornEquiped;
    notifyListeners();
  }
}
