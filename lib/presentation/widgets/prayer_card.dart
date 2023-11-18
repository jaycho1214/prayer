import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/chip/pray_chip.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerCard extends HookWidget {
  const PrayerCard({
    super.key,
    required this.prayerId,
    this.onTap,
  });

  final void Function()? onTap;
  final String prayerId;

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(useMemoized(
        () => context.read<PrayerRepository>().fetchPrayer(prayerId)));

    return Skeletonizer(
      enabled: snapshot.connectionState == ConnectionState.waiting,
      child: ShrinkingButton(
        onTap: () {
          context.push('/prayers/$prayerId');
          onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (snapshot.data?.groupId != null) ...[
                Row(
                  children: [
                    ShrinkingButton(
                      onTap: () {
                        if (snapshot.data?.groupId != null) {
                          context.push('/groups/${snapshot.data!.groupId!}');
                        }
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.lightUsers,
                            size: 13,
                            color: MyTheme.onPrimary,
                          ),
                          const SizedBox(width: 5),
                          Text(snapshot.data?.group?.name ?? ''),
                        ],
                      ),
                    ),
                    if (snapshot.data?.corporateId != null)
                      ShrinkingButton(
                        onTap: () {
                          context.push(
                              '/prayers/corporate/${snapshot.data!.corporateId!}');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            FaIcon(
                              FontAwesomeIcons.chevronRight,
                              size: 10,
                              color: MyTheme.onPrimary,
                            ),
                            const SizedBox(width: 5),
                            Text(snapshot.data?.corporate?.title ?? ''),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
              UserChip(
                anon: snapshot.data?.anon == true,
                uid: snapshot.data?.userId,
                profile: snapshot.data?.user?.profile,
                name: snapshot.data?.user?.name,
              ),
              const SizedBox(height: 20),
              Text(
                snapshot.data?.value ?? '',
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 1,
              ),
              if (snapshot.data?.media != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 80, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!.media!,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: snapshot.data?.pray == null
                        ? const SizedBox()
                        : Row(
                            children: [
                              UserProfileImage(
                                profile: snapshot.data?.pray?.profile,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${snapshot.data?.pray?.username} has prayed for you',
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (snapshot.data?.pray?.createdAt != null)
                                Text(
                                  Formatter.fromNow(
                                      snapshot.data!.pray!.createdAt!),
                                  style: TextStyle(
                                    color: MyTheme.outline,
                                  ),
                                ),
                              const SizedBox(width: 10),
                            ],
                          ),
                  ),
                  PrayChip(
                    prayerId: prayerId,
                    hasPrayed: snapshot.data?.hasPrayed != null,
                    value: snapshot.data?.praysCount ?? 0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
