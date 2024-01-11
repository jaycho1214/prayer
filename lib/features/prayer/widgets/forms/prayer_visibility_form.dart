import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class PrayerVisibilityForm extends StatelessWidget {
  const PrayerVisibilityForm({
    super.key,
    required this.anonymous,
  });

  final bool anonymous;

  static Future<bool?> show(
    BuildContext context, {
    required bool anonymous,
  }) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        builder: (context) {
          return PrayerVisibilityForm(
            anonymous: anonymous,
          );
        });
  }

  Widget buildRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool value,
  }) {
    return ShrinkingButton(
      onTap: () {
        context.pop(value);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: FaIcon(
                icon,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      if (value == anonymous)
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            t.prayer.form.postType.title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          buildRow(
            context,
            icon: FontAwesomeIcons.lightUser,
            title: t.prayer.form.postType.public.title,
            description: t.prayer.form.postType.public.description,
            value: false,
          ),
          Divider(),
          buildRow(
            context,
            icon: FontAwesomeIcons.lightUserSlash,
            title: t.prayer.form.postType.anonymous.title,
            description: t.prayer.form.postType.anonymous.description,
            value: true,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
