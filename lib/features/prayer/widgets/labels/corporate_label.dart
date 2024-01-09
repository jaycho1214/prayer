import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';

class CorporateLabel extends StatelessWidget {
  const CorporateLabel({
    super.key,
    required this.prayer,
  });

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () {
        context.push('/prayers/corporate/${prayer.corporateId}');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FaIcon(
              FontAwesomeIcons.solidChevronRight,
              size: 10,
              color: Theme.of(context).textTheme.labelMedium?.color,
            ),
          ),
          Text(
            prayer.corporate?.title ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
