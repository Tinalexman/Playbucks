import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class NotificationPreferencePage extends ConsumerStatefulWidget {
  const NotificationPreferencePage({super.key});

  @override
  ConsumerState<NotificationPreferencePage> createState() =>
      _NotificationPreferencePageState();
}

class _NotificationPreferencePageState
    extends ConsumerState<NotificationPreferencePage> {
  @override
  Widget build(BuildContext context) {
    List<NotificationPreference> map = ref.watch(notificationPreferenceProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.1,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Notification Preference",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Choose what notifications you wish to receive",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 32.h),
              Column(
                children: List.generate(
                  map.length,
                  (index) => SizedBox(
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!map[index].chosen) return;
                            context.router
                                .pushNamed(Pages.notificationFrequency,
                                    extra: map[index])
                                .then((value) => setState(() {}));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                map[index].title,
                                style: context.textTheme.bodyLarge,
                              ),
                              Text(
                                map[index].content,
                                style: context.textTheme.bodyMedium!.copyWith(color: theme40),
                              )
                            ],
                          ),
                        ),
                        Switch(
                          value: map[index].chosen,
                          onChanged: (val) {
                            map[index].chosen = !map[index].chosen;
                            setState(() {});
                            if (map[index].chosen) {
                              map[index].content = "Instant";
                              context.router
                                  .pushNamed(Pages.notificationFrequency,
                                      extra: map[index])
                                  .then((value) => setState(() {}));
                            } else {
                              map[index].content = "Off";
                              setState(() {});
                            }
                          },
                          activeColor: mainGold,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationFrequency extends StatefulWidget {
  final NotificationPreference preference;

  const NotificationFrequency({super.key, required this.preference});

  @override
  State<NotificationFrequency> createState() => _NotificationFrequencyState();
}

class _NotificationFrequencyState extends State<NotificationFrequency> {

  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.preference.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.1,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Set Frequency",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "How often do you want to get updates on ${widget.preference.title}.",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
            ),
            SizedBox(height: 32.h),
            RadioListTile(
              value: widget.preference.content == "Instant",
              groupValue: "Instant",
              onChanged: (val) => setState(() {
                selected = "Instant";
                widget.preference.content = selected;
              }),
              title: Text(
                "Instant",
                style: context.textTheme.bodyMedium,
              ),
              activeColor: mainGold,
            ),
            RadioListTile(
              value: selected == "Daily",
              groupValue: "Daily",
              onChanged: (val) => setState(() {
                selected = "Daily";
                widget.preference.content = selected;
              }),
              title: Text(
                "Daily",
                style: context.textTheme.bodyMedium,
              ),
              activeColor: mainGold,
            ),
            RadioListTile(
              value: selected == "Weekly",
              groupValue: "Weekly",
              onChanged: (val) => setState(() {
                selected = "Weekly";
                widget.preference.content = selected;
              }),
              title: Text(
                "Weekly",
                style: context.textTheme.bodyMedium,
              ),
              activeColor: mainGold,
            ),
          ],
        ),
      ),
    );
  }
}
