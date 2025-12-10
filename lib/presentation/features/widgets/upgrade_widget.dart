import 'package:flutter/material.dart';
import 'package:rook_clicker/data/models/upgrade.dart';

class UpgradeWidget extends StatelessWidget {
  final List<Upgrade> upgrades;

  const UpgradeWidget({
    required this.upgrades,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // Dynamically create a button for each upgrade in the list
      children: upgrades
          .map(
            (upgrade) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: UpgradeButtonWidget(
                onPressed: upgrade.onPressed,
                text: upgrade.text,
              ),
            ),
          )
          .toList(),
    );
  }
}

class UpgradeButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const UpgradeButtonWidget({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        shadowColor: colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: colorScheme.onSurface.withAlpha(100),
          width: 2,
        ),
      ),
      child: Text(text),
    );
  }
}
