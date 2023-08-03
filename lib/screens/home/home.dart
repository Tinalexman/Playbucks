import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:file_picker/file_picker.dart';

Future<String?> chooseFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['mp3'],
    type: FileType.custom,
    allowMultiple: false,
  );
  if (result != null) {
    return result.files.single.path;
  }
  return null;
}

Future<List<String>> directoryFiles() async {
  return [];
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      context.router.pushNamed(Pages.mediaPlayer, extra: path);
    }

    return GlassmorphicContainer(
      blur: 0.2,
      border: 0.0,
      borderRadius: 0.0,
      linearGradient: const LinearGradient(
        colors: [
          homeDominant,
          homeMutedDark,
        ],
        end: AlignmentDirectional.centerEnd,
        begin: AlignmentDirectional.centerStart,
      ),
      borderGradient: LinearGradient(
        colors: [
          appRed.withOpacity(0.6),
          niceBlue.withOpacity(0.6),
          goodYellow.withOpacity(0.6)
        ],
        end: Alignment.bottomRight,
        begin: Alignment.topLeft,
      ),
      width: 390.w,
      height: 844.h,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: neutral2,
                            child: Icon(
                              Icons.person_rounded,
                              size: 26.r,
                              color: appRed,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, username",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "Welcome back",
                                style: context.textTheme.headlineSmall!
                                    .copyWith(
                                        fontSize: 18.sp, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_rounded,
                            color: Colors.white),
                        splashRadius: 0.01,
                        iconSize: 22.r,
                      )
                    ],
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 130.w,
                        height: 200.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appRed,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.2),
                              spreadRadius: 2.0,
                              blurRadius: 0.8,
                            )
                          ],
                        ),
                        child: Text(
                          "Content",
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Trending right now!",
                            style: context.textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            width: 230.w,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Container(
                                  width: 130.w,
                                  height: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: appRed,
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.redAccent.withOpacity(0.2),
                                        spreadRadius: 2.0,
                                        blurRadius: 0.8,
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    "Content ${index + 1}",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 10.w),
                              itemCount: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Categories",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 390.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Chip(
                          label: Text(
                            "Category ${index + 1}",
                            style: context.textTheme.bodySmall!
                                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: appRed,
                          elevation: 2.0,

                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(width: 5.w),
                      itemCount: 10,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Recently Played",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 100.h,
                    width: 390.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          width: 130.w,
                          height: 100.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appRed,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.redAccent.withOpacity(0.2),
                                spreadRadius: 2.0,
                                blurRadius: 0.8,
                              )
                            ],
                          ),
                          child: Text(
                            "Content ${index + 1}",
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) =>
                          SizedBox(width: 10.w),
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appRed,
          onPressed: () => chooseFile().then((path) {
            if (path != null) {
              navigate(path);
            }
          }),
          child: Icon(Icons.file_open_rounded, size: 26.r,),
        ),
      ),
    );
  }
}
