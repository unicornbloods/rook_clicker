import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rook_clicker/presentation/features/main_game/viewmodel/main_game_viewmodel.dart';
import 'package:rook_clicker/presentation/features/widgets/upgrade_widget.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainGameViewmodel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(viewmodel.title),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: Row(
                    spacing: 5,
                    children: [
                      Text(
                        'Spider Lilies: ${viewmodel.lilyCounter}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        // The curve makes the jump feel more natural
                        curve: Curves.easeInOut,
                        // Move the lily up by 5 pixels when isLilyBouncing is true
                        transform: Matrix4.translationValues(
                          0,
                          viewmodel.isLilyBouncing ? -5.0 : 0.0,
                          0,
                        ),
                        child: const Image(
                          image: AssetImage(
                            'assets/images/red_spider_lily_texture.png',
                          ),
                          height: 36,
                          width: 20,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                      Visibility(
                        visible: viewmodel.queenOfTheNightCounter > 0,
                        child: Row(
                          spacing: 5,
                          children: [
                            Text(
                              'Queen of The Nights: ${viewmodel.queenOfTheNightCounter}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 50),
                              // The curve makes the jump feel more natural
                              curve: Curves.easeInOut,
                              // Move the lily up by 5 pixels when isLilyBouncing is true
                              transform: Matrix4.translationValues(
                                0,
                                viewmodel.isLilyBouncing ? -5.0 : 0.0,
                                0,
                              ),
                              child: const Image(
                                image: AssetImage(
                                  'assets/images/queen_of_the_night_texture.png',
                                ),
                                height: 36,
                                width: 20,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: viewmodel.incrementCounter,
                child: Center(
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Visibility(
                            visible: viewmodel.urPurchased,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(
                                pi,
                              ), // This flips the image
                              child: const Image(
                                image: AssetImage(
                                  'assets/images/ur_texture.png',
                                ),
                                height: 160,
                                width: 160,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: viewmodel.petTheRook,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 50,
                                      ),
                                      // The curve makes the jump feel more natural
                                      curve: Curves.easeInOut,
                                      // Move the rook up by 10 pixels when isRookJumping is true
                                      transform: Matrix4.translationValues(
                                        0,
                                        viewmodel.isRookJumping ? -10.0 : 0.0,
                                        0,
                                      ),
                                      child: Stack(
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                              'assets/images/rook_texture.png',
                                            ),
                                            height: 96,
                                            width: 112,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          Visibility(
                                            visible: viewmodel.witcherEquiped,
                                            child: const Image(
                                              image: AssetImage(
                                                'assets/images/witcher_overlay.png',
                                              ),
                                              height: 96,
                                              width: 112,
                                              fit: BoxFit.fill,
                                              filterQuality: FilterQuality.none,
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                viewmodel.dragonBornEquiped,
                                            child: const Image(
                                              image: AssetImage(
                                                'assets/images/dragon_born_overlay.png',
                                              ),
                                              height: 96,
                                              width: 112,
                                              fit: BoxFit.fill,
                                              filterQuality: FilterQuality.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (viewmodel.isRookHeartVisible)
                                  const Positioned(
                                    top:
                                        40, // Adjust position as needed to touch the rook
                                    right:
                                        60, // Adjust position as needed to touch the rook
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                const IgnorePointer(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/red_spider_lillies_texture.png',
                                      ),
                                      height: 96,
                                      width: 192,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: viewmodel.shellBugPurchased,
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: viewmodel.petTheShellBug,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 50,
                                        ),
                                        // The curve makes the jump feel more natural
                                        curve: Curves.easeInOut,
                                        // Move the rook up by 10 pixels when isRookJumping is true
                                        transform: Matrix4.translationValues(
                                          0,
                                          viewmodel.isRookJumping ? -10.0 : 0.0,
                                          0,
                                        ),
                                        child: const Image(
                                          image: AssetImage(
                                            'assets/images/shell_bug_texture.png',
                                          ),
                                          height: 96,
                                          width: 112,
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (viewmodel.isShellBugHeartVisible)
                                    const Positioned(
                                      top:
                                          80, // Adjust position as needed to touch the rook
                                      right:
                                          90, // Adjust position as needed to touch the rook
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                                  const IgnorePointer(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/queen_of_the_nights_texture.png',
                                        ),
                                        height: 96,
                                        width: 192,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: viewmodel.urPurchased,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(100),
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(viewmodel.currentUrSaying),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  spacing: 10,
                  children: [
                    UpgradeWidget(
                      upgrades: viewmodel.lilyUpgrades,
                    ),
                    Visibility(
                      visible: viewmodel.queenOfTheNightCounter > 0,
                      child: UpgradeWidget(
                        upgrades: viewmodel.queenOfTheNightUpgrades,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  spacing: 10,
                  children: [
                    Visibility(
                      visible: viewmodel.witcherPurchased,
                      child: UpgradeWidget(
                        upgrades: viewmodel.unlockedCustomizations,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  spacing: 10,
                  children: [
                    UpgradeWidget(
                      upgrades: viewmodel.cheatUpgrade,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
