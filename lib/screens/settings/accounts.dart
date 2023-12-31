import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class AccountsPage extends ConsumerStatefulWidget {
  const AccountsPage({super.key});

  @override
  ConsumerState createState() => _AccountsPageState();
}

class _AccountsPageState extends ConsumerState<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    List<String> connectedAccounts = ref.watch(connectedAccountsProvider);

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
          "Connected Accounts",
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
                "Streaming platforms that has access to your account",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 32.h),
              Text(
                "Connected Streaming Platforms",
                style: context.textTheme.bodyLarge!.copyWith(color: theme60),
              ),
              SizedBox(height: 10.h),
              connectedAccounts.isNotEmpty
                  ? Column(
                      children: List.generate(
                        connectedAccounts.length,
                        (index) => SizedBox(
                          height: 40.h,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  connectedAccounts[index],
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(color: theme),
                                ),
                                GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (_) => _RemoveDSPContainer(
                                      onRemove: () {
                                        connectedAccounts.removeAt(index);
                                        setState(() {});
                                      },
                                      title: connectedAccounts[index],
                                    ),
                                    barrierDismissible: true,
                                  ),
                                  child: Text(
                                    "Disconnect",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      color: redError,
                                      decoration: TextDecoration.underline,
                                      decorationColor: redError,
                                      decorationThickness: 2.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          "Yoy have not linked any platform yet!",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge!
                              .copyWith(color: theme60),
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

class _RemoveDSPContainer extends ConsumerWidget {
  final String title;
  final VoidCallback onRemove;

  const _RemoveDSPContainer({
    super.key,
    required this.onRemove,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 390.w,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: neutral2,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Disconnect $title",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Boxicons.bx_x),
                    iconSize: 26.r,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                "You are about to remove $title from the list of your connected streaming platforms",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: context.textTheme.bodyLarge!
                          .copyWith(color: mainGold),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  ElevatedButton(
                    onPressed: () {
                      onRemove();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(150.w, 50.h),
                      maximumSize: Size(150.w, 50.h),
                    ),
                    child: Text(
                      "Disconnect",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500, color: primary),
                    ),
                  ),
                  SizedBox(height: 10.h)
                ],
              )
            ],
          ),
        ));
  }
}
