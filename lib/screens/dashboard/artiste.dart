import 'dart:io';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as bg;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/api/file_manager.dart';
import 'package:playbucks/utils/widgets.dart';

class ArtisteDashboard extends ConsumerStatefulWidget {
  const ArtisteDashboard({super.key});

  @override
  ConsumerState<ArtisteDashboard> createState() => _ArtisteDashboardState();
}

class _ArtisteDashboardState extends ConsumerState<ArtisteDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

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
        title: Text(
          "Dashboard",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: IconButton(
                onPressed: () => context.router.goNamed(Pages.login),
                icon: const Icon(Icons.power_settings_new_rounded),
                iconSize: 26.r,
                splashRadius: 20.r,
              ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                width: 390.w,
                height: 106.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 90.w,
                        height: 106.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: neutral2,
                          image: user.cover.isEmpty
                              ? null
                              : DecorationImage(
                                  image: FileImage(File(user.cover)),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: user.cover.isEmpty
                            ? Text(
                                user.fullName.substring(0, 1),
                                style: context.textTheme.headlineLarge,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 25.w),
                    SizedBox(
                      width: 240.w,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 230.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.headlineLarge,
                                ),
                                Text(
                                  "@${user.username}",
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const bg.Badge(
                                      badgeStyle: bg.BadgeStyle(
                                        shape: bg.BadgeShape.twitter,
                                        badgeColor: mainGold,
                                        elevation: 2.0,
                                      ),
                                      badgeContent: Icon(Icons.done_rounded,
                                          color: Colors.black, size: 10),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Verified Playbucks Artiste",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  'Joined in ${DateTime.now().year}',
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0.w,
                            top: 0.h,
                            child: GestureDetector(
                              onTap: () => context.router.pushNamed(Pages.editProfile),
                              child: Icon(
                                Icons.edit_rounded,
                                size: 18.r,
                                color: mainGold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 390.w,
                decoration: BoxDecoration(
                  color: neutral2,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Text(user.bio,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: mainGold,
                tabs: const [
                  Tab(
                    child: Text("Summary"),
                  ),
                  Tab(
                    child: Text("Analytics"),
                  ),
                  Tab(
                    child: Text("Account"),
                  ),
                  Tab(
                    child: Text("Profile"),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          const Center(child: Copyright()),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(height: 50.h),
                          const Center(child: Copyright()),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Text(
                            "Banking Details",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "This information would be used to facilitate deposits.",
                            style: context.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 100.h),
                          Center(
                            child: Text(
                              "You have not yet linked a bank card.",
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainGold,
                                elevation: 2.0,
                                minimumSize: Size(100.w, 35.h),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Add New Card",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          const Center(child: Copyright()),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          const Center(child: Copyright()),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController _nameController, _usernameController, _bioController;
  String cover = "";

  @override
  void initState() {
    super.initState();

    User user = ref.read(currentUserProvider);
    _nameController = TextEditingController(text: user.fullName);
    _usernameController = TextEditingController(text: user.username);
    _bioController = TextEditingController(text: user.bio);
    cover = user.cover;
  }

  @override
  void dispose() {
    _bioController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

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
        title: Text(
          "Edit Profile",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: SizedBox(
                    width: 250.w,
                    height: 250.w,
                    child: Center(
                      child: SizedBox(
                        width: 230.w,
                        height: 230.w,
                        child: Stack(
                          children: [
                            Container(
                              width: 200.w,
                              height: 200.w,
                              decoration: BoxDecoration(
                                color: neutral2,
                                borderRadius: BorderRadius.circular(10.r),
                                image: cover.isEmpty
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(
                                          File(cover),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              alignment: Alignment.center,
                              child: cover.isEmpty
                                  ? Text(
                                      user.fullName.substring(0, 1),
                                      style: context.textTheme.headlineLarge,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 20.w,
                              right: 20.w,
                              child: GestureDetector(
                                onTap: () =>
                                    FileManager.single(type: FileType.image)
                                        .then((resp) {
                                  if (resp != null) {
                                    setState(() => cover = resp.path);
                                  }
                                }),
                                child: Container(
                                  width: 30.r,
                                  height: 30.r,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: mainGold),
                                  child: Icon(
                                    Icons.edit_rounded,
                                    size: 18.r,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    user.fullName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.headlineSmall,
                  ),
                ),
                Center(
                  child: Text(
                    "@${user.username}",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  "Full Name",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SpecialForm(
                  controller: _nameController,
                  width: 390.w,
                  height: 40.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "Username",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SpecialForm(
                  controller: _usernameController,
                  width: 390.w,
                  height: 40.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "Bio",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SpecialForm(
                  controller: _bioController,
                  width: 390.w,
                  height: 160.h,
                  maxLines: 10,
                ),
                SizedBox(height: 50.h),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      elevation: 2.0,
                      minimumSize: Size(100.w, 35.h),
                    ),
                    onPressed: () {
                      ref.watch(currentUserProvider.notifier).state = User(
                          cover: cover,
                          fullName: _nameController.text.trim(),
                          username: _usernameController.text.trim(),
                          bio: _bioController.text.trim(),
                      );
                      context.router.pop();
                    },
                    child: Text(
                      "Save",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                const Center(child: Copyright()),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomArtistePage extends StatelessWidget {
  final User artiste;
  const CustomArtistePage({super.key, required this.artiste});

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
        title: Text(
          "Artiste",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                SizedBox(
                  width: 390.w,
                  height: 106.h,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 90.w,
                          height: 106.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: neutral2,
                            image: artiste.cover.isEmpty
                                ? null
                                : DecorationImage(
                              image: FileImage(File(artiste.cover)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: artiste.cover.isEmpty
                              ? Text(
                            artiste.fullName.substring(0, 1),
                            style: context.textTheme.headlineLarge,
                          )
                              : null,
                        ),
                      ),
                      SizedBox(width: 25.w),
                      SizedBox(
                        width: 230.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              artiste.fullName,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.headlineLarge,
                            ),
                            Text(
                              "@${artiste.username}",
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const bg.Badge(
                                  badgeStyle: bg.BadgeStyle(
                                    shape: bg.BadgeShape.twitter,
                                    badgeColor: mainGold,
                                    elevation: 2.0,
                                  ),
                                  badgeContent: Icon(Icons.done_rounded,
                                      color: Colors.black, size: 10),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Verified Playbucks Artiste",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Joined in ${DateTime.now().year}',
                              style: context.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 390.w,
                  decoration: BoxDecoration(
                    color: neutral2,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(artiste.bio,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(height: 50.h),
                const Center(child: Copyright()),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

