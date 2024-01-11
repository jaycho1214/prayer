import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/features/common/sheets/confirm_slim_menu_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

import 'package:prayer/i18n/strings.g.dart';

class NeighborDescriptionCard extends StatelessWidget {
  const NeighborDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box('settings').listenable(keys: ['neighbor.description.shown']),
      builder: (context, box, child) => Visibility(
        visible: box.get('neighbor.description.shown', defaultValue: true),
        child: ShrinkingButton(
          onTap: () async {
            final resp = await ConfirmSlimMenuForm.show(
              context,
              title: t.neighbor.alert.title,
              description: t.neighbor.alert.subtitle,
              icon: FontAwesomeIcons.xmark,
            );
            if (resp == true) {
              box.put('neighbor.description.shown', false);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Stack(
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.neighbor.card.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            t.neighbor.card.description,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
