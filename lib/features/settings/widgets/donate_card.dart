import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/i18n/strings.g.dart';

class DonateCard extends StatelessWidget {
  const DonateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () => context.push('/settings/donate'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).disabledColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.donate.card.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      t.donate.card.description,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/images/jesus.png',
                  width: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
