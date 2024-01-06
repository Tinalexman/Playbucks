import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/search.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';

class RewardsPage extends ConsumerStatefulWidget {
  final double reward;

  const RewardsPage({
    super.key,
    required this.reward,
  });

  @override
  ConsumerState<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends ConsumerState<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

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
          "Rewards",
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Image.asset(
                user.cover,
                fit: BoxFit.cover,
                width: 110.r,
                height: 110.r,
              ),
            ),
            Text(
              "You claimed ${widget.reward.toStringAsFixed(2)}PBC",
              style: context.textTheme.bodyLarge,
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${(user.balance + widget.reward).toStringAsFixed(2)} PBC",
                  style: context.textTheme.headlineSmall,
                ),
                SizedBox(width: 80.w),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: mainGold,
                        ),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: primary,
                          size: 26.r,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Send",
                      style: context.textTheme.bodyMedium,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
