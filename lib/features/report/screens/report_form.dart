import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    super.key,
    this.userId,
    this.groupId,
    this.prayId,
    this.prayerId,
  });

  final String? userId;
  final String? groupId;
  final String? prayerId;
  final String? prayId;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _loading = false;
  int _selected = -1;

  Widget _buildRow({
    required int id,
    required String text,
  }) {
    return ShrinkingButton(
      onTap: () {
        setState(() {
          _selected = id == _selected ? -1 : id;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
            if (id == _selected)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FaIcon(
                  FontAwesomeIcons.circleCheck,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> sendReport(String reason) async {
    try {
      setState(() {
        _loading = true;
      });
      await dio.post('/v1/users/report', data: {
        'reportId':
            'userId:${widget.userId}\ngroupId:${widget.groupId}\nprayerId:${widget.prayerId}\nprayId:${widget.prayId}\n',
        'value': reason,
      });
      context.pop();
      NotificationSnackBar.show(context, message: "Report has been sent");
    } catch (e, st) {
      talker.handle(e, st, '[Report] Failed to send a report');
      GlobalSnackBar.show(context, message: t.error.unknown);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  final List<Map<String, dynamic>> reportTypes = [
    {'id': 1, 'type': 'Promoting or encouraging spam'},
    {'id': 2, 'type': 'Abuse or harassment'},
    {'id': 3, 'type': 'Explicit, sensitive, or unwanted graphic'},
    {'id': 4, 'type': 'Harmful misinformation'},
    {'id': 5, 'type': 'Something else'},
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        title: Text(t.general.report),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Help us build a better community',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "Which one describes a problem the best",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ...reportTypes.map(
              (value) => _buildRow(id: value['id'], text: value['type']),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ShrinkingButton(
                onTap: () async {
                  if (_selected == -1) {
                    return;
                  }
                  return sendReport(reportTypes[_selected - 1]['type']);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Theme.of(context).colorScheme.error),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _loading
                      ? CircularProgressIndicator.adaptive()
                      : Text(
                          "Submit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
