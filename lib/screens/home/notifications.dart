import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    List<NotificationData> notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Notifications",
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == notifications.length) {
                      return SizedBox(height: 50.h);
                    }

                    return _NotificationContainer(data: notifications[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: notifications.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationContainer extends StatefulWidget {
  final NotificationData data;

  const _NotificationContainer({
    super.key,
    required this.data,
  });

  @override
  State<_NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<_NotificationContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() => expanded = !expanded);
    if (expanded) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Container(
        width: 390.w,
        decoration: BoxDecoration(
          border: Border.all(color: mainGold),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: expanded ? 10.h : 5.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250.w,
                  child: Text(
                    widget.data.content,
                    style: context.textTheme.bodyLarge,
                    overflow:
                        !expanded ? TextOverflow.ellipsis : TextOverflow.visible,
                  ),
                ),
                IconButton(
                  onPressed: toggle,
                  icon: Icon(
                    !expanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    color: mainGold,
                  ),
                  iconSize: 26.r,
                )
              ],
            ),
            SizeTransition(
              sizeFactor: animation,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.data.data.length,
                      (index) => SizedBox(
                        height: 35.h,
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      "${widget.data.data[index].artisteName} - ",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: widget.data.data[index].song,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ]),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {}, // GO TO THE LINK
                              child: Icon(
                                Icons.arrow_forward,
                                color: mainGold,
                                size: 26.r,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
