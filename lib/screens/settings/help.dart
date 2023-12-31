import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';

class HelpPage extends ConsumerStatefulWidget {
  const HelpPage({super.key});

  @override
  ConsumerState createState() => _HelpPageState();
}

class _HelpPageState extends ConsumerState<HelpPage> {
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
          "Help and Support",
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
                "Get assistance and find answers to your questions",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 375.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: neutral2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/headphones.svg",
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            "Contact Us",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 26.r,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => context.router.pushNamed(Pages.faq),
                child: Container(
                  width: 375.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: neutral2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/help-circle.svg",
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            "FAQs",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 26.r,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => const _FeedBack(),
                  barrierDismissible: true,
                ),
                child: Container(
                  width: 375.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: neutral2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/alert-triangle.svg",
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            "Report Issues or Feedbacks",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 26.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedBack extends StatefulWidget {
  const _FeedBack({super.key});

  @override
  State<_FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<_FeedBack> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController message = TextEditingController();

  @override
  void dispose() {
    message.dispose();
    email.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 390.w,
        height: 500.h,
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
                  "Send Feedback",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  icon: const Icon(Boxicons.bx_x),
                  iconSize: 26.r,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              "Full Name",
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            SpecialForm(
              controller: name,
              width: 375.w,
              height: 40.h,
              hint: "Enter your full name",
            ),
            SizedBox(height: 16.h),
            Text(
              "Email Address",
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            SpecialForm(
              controller: email,
              width: 375.w,
              height: 40.h,
              hint: "Enter your email address",
            ),
            SizedBox(height: 16.h),
            Text(
              "Feedback",
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            SpecialForm(
              controller: message,
              width: 375.w,
              height: 150.h,
              maxLines: 6,
              hint: "What do you wish to tell us?",
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainGold,
                minimumSize: Size(390.w, 50.h),
                maximumSize: Size(390.w, 50.h),
              ),
              child: Text(
                "Submit",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500, color: primary),
              ),
            ),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }
}

class _FAQ {
  final String question;
  final String answer;

  const _FAQ({
    required this.question,
    required this.answer,
  });
}

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;
  late List<_FAQ> faqs;

  int total = 4;

  @override
  void initState() {
    super.initState();

    faqs = [];
    controllers = [];
    animations = [];

    for (int i = 0; i < total; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
      animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: controllers[i], curve: Curves.easeInOut),
        ),
      );
      faqs.add(
        _FAQ(
          question: "Will I be able to ${i + 1}?",
          answer:
              "This is the answer to question ${i + 1}. It will definitely answer your question.",
        ),
      );
    }
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
          "FAQs",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Get assistance and find answers to your questions",
                    style:
                        context.textTheme.bodyMedium!.copyWith(color: theme60),
                  ),
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Frequently Asked Questions",
                    style: context.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 24.h),
                Column(
                  children: List.generate(
                    total,
                    (index) => Column(
                      children: [
                        _FAQContainer(
                          faq: faqs[index],
                          controller: controllers[index],
                          animation: animations[index],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  "Still have questions?",
                  style: context.textTheme.bodyLarge!
                      .copyWith(color: theme, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Text(
                    "If you can't find the answers to your questions in our FAQs, "
                    "please contact us. We will respond as soon as possible.",
                    style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(320.w, 45.h),
                    maximumSize: Size(320.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Contact Us",
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, color: primary),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FAQContainer extends StatefulWidget {
  final _FAQ faq;
  final AnimationController controller;
  final Animation<double> animation;

  const _FAQContainer({
    super.key,
    required this.faq,
    required this.controller,
    required this.animation,
  });

  @override
  State<_FAQContainer> createState() => _FAQContainerState();
}

class _FAQContainerState extends State<_FAQContainer> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      decoration: BoxDecoration(
        border: Border.all(color: theme),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.only(
          left: 10.w, right: 10.w, top: 5.h, bottom: expanded ? 10.h : 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.faq.question,
                style: context.textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {
                  setState(() => expanded = !expanded);
                  if (expanded) {
                    widget.controller.forward();
                  } else {
                    widget.controller.reverse();
                  }
                },
                icon: Icon(expanded ? Icons.remove_rounded : Icons.add_rounded,
                    color: theme),
                iconSize: 26.r,
              )
            ],
          ),
          SizeTransition(
            sizeFactor: widget.animation,
            child: Text(
              widget.faq.answer,
              style: context.textTheme.bodyMedium!.copyWith(color: theme60),
            ),
          )
        ],
      ),
    );
  }
}
