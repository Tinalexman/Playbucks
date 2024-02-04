import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/api/file_manager.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  bool? _artiste;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Text(
                    "User Registration",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Text(
                  "How will you be registering with Playbucks?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 100.h,
                ),
                GestureDetector(
                  onTap: () => setState(() => _artiste = true),
                  child: _UserCategory(
                    image: 'assets/compose.svg',
                    header: "Artiste",
                    content: "Promote your songs to millions of users.",
                    selected: _artiste != null && _artiste!,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () => setState(() => _artiste = false),
                  child: _UserCategory(
                    image: 'assets/listen.svg',
                    header: "Listener",
                    content: "Earn while listening to your favorite artistes.",
                    selected: _artiste != null && !_artiste!,
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_artiste == null) return;
                      context.router.pushNamed(_artiste!
                          ? Pages.registerArtiste
                          : Pages.registerListener);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _artiste == null ? neutral2 : mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _artiste == null ? null : Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserCategory extends StatelessWidget {
  final String image;
  final String header;
  final String content;
  final bool selected;

  const _UserCategory({
    super.key,
    required this.selected,
    required this.image,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: selected ? mainGold : theme, width: 2.0),
        borderRadius: BorderRadius.circular(10.r),
        color: selected ? mainGold : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: selected ? Colors.black : null),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  content,
                  style: context.textTheme.bodyLarge!
                      .copyWith(color: selected ? Colors.black : null),
                )
              ],
            ),
          ),
          SvgPicture.asset(
            image,
            height: 120.h,
          ),
        ],
      ),
    );
  }
}

class _ListenerMusicPreferencePage extends StatefulWidget {
  final VoidCallback onNext;

  const _ListenerMusicPreferencePage({super.key, required this.onNext});

  @override
  State<_ListenerMusicPreferencePage> createState() =>
      _ListenerMusicPreferencePageState();
}

class _ListenerMusicPreferencePageState
    extends State<_ListenerMusicPreferencePage> {
  late List<Holder> _musicCategories, _musicStyles;
  final List<String> _favorites = [];
  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    super.initState();
    _musicCategories = [
      Holder(content: "Afro-beats"),
      Holder(content: "Pop"),
      Holder(content: "Hip-Hop/Rap"),
      Holder(content: "Electronic/Dance"),
      Holder(content: "R&B/Soul"),
      Holder(content: "Country"),
      Holder(content: "Jazz"),
      Holder(content: "Classical"),
      Holder(content: "Indie/Alternative"),
      Holder(content: "Reggae"),
      Holder(content: "Metal"),
      Holder(content: "Folk"),
      Holder(content: "Alternative Fusion"),
    ];
    _musicStyles = [
      Holder(content: "Upbeat and Energetic"),
      Holder(content: "Chill and Relaxing"),
      Holder(content: "Melancholic and Emotional"),
      Holder(content: "Experimental and Avant-Garde"),
      Holder(content: "Dance and Party"),
      Holder(content: "Acoustic and Unplugged"),
      Holder(content: "Powerful and Vocals-driven")
    ];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Text(
                    "Genres and Style Preference (1 of 5)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Tell us about the type of music you listen to.",
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Genres",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Which genres get you going?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: List.generate(
                    _musicCategories.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _musicCategories[index]
                          .selected = !_musicCategories[index].selected),
                      child: Chip(
                        label: Text(
                          _musicCategories[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _musicCategories[index].selected
                                  ? Colors.black
                                  : null),
                        ),
                        elevation: _musicCategories[index].selected ? 1 : 0,
                        backgroundColor: _musicCategories[index].selected
                            ? mainGold
                            : neutral2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Style",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Which styles catch your fancy?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: List.generate(
                    _musicStyles.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _musicStyles[index].selected =
                          !_musicStyles[index].selected),
                      child: Chip(
                        label: Text(
                          _musicStyles[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _musicStyles[index].selected
                                ? Colors.black
                                : null,
                          ),
                        ),
                        elevation: _musicStyles[index].selected ? 1 : 0,
                        backgroundColor:
                            _musicStyles[index].selected ? mainGold : neutral2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Your Favorite Artistes",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Let us know about any band or artistes you are fond of.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _favorites.length,
                    (index) => Chip(
                        onDeleted: () =>
                            setState(() => _favorites.removeAt(index)),
                        deleteIcon: Icon(Boxicons.bx_x,
                            color: Colors.black, size: 18.r),
                        label: Text(
                          _favorites[index],
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: mainGold),
                  ),
                ),
                SizedBox(height: 10.h),
                SpecialForm(
                  controller: _name,
                  hint: "Enter Artiste/Band Name",
                  width: 250.w,
                  height: 35.h,
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold, minimumSize: Size(90.w, 30.h)),
                  onPressed: () {
                    String name = _name.text.trim();
                    if (name.isEmpty) {
                      showError("No name was provided");
                      return;
                    }

                    setState(() {
                      _favorites.add(name);
                      _name.clear();
                    });

                    unFocus();
                  },
                  child: Text(
                    'Add',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListenerMusicDiscoveryPage extends StatefulWidget {
  final VoidCallback onNext;

  const _ListenerMusicDiscoveryPage({super.key, required this.onNext});

  @override
  State<_ListenerMusicDiscoveryPage> createState() =>
      _ListenerMusicDiscoveryPageState();
}

class _ListenerMusicDiscoveryPageState
    extends State<_ListenerMusicDiscoveryPage>
    with SingleTickerProviderStateMixin {
  late List<Holder> _seek, _newSongs;
  int? _seekIndex, _newSongIndex;
  bool _recommended = false;

  late AnimationController _controller;
  late TextEditingController _nameController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _seek = [
      Holder(content: "Never"),
      Holder(content: "Sometimes"),
      Holder(content: "Often"),
      Holder(content: "Always"),
    ];

    _newSongs = [
      Holder(content: "Playlists"),
      Holder(content: "Radio"),
      Holder(content: "Recommendations"),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Text(
                  "Music Discovery (2 of 5)",
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: mainGold),
                ),
              ),
              Center(
                child: Text(
                  "Understanding how you discover and consume music will help optimize the promotion and discovery process.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "How often do you actively seek new music?",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 5.0,
                children: List.generate(
                  _seek.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _seekIndex = index),
                    child: Chip(
                      label: Text(
                        _seek[index].content,
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: (_seekIndex == null || _seekIndex! != index)
                                ? null
                                : Colors.black),
                      ),
                      elevation: 1,
                      backgroundColor:
                          (_seekIndex == null || _seekIndex! != index)
                              ? neutral2
                              : mainGold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "How do you usually discover new songs?",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 5.0,
                children: List.generate(
                  _newSongs.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _newSongIndex = index),
                    child: Chip(
                      label: Text(
                        _newSongs[index].content,
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: (_newSongIndex == null ||
                                    _newSongIndex! != index)
                                ? null
                                : Colors.black),
                      ),
                      elevation: 1,
                      backgroundColor:
                          (_newSongIndex == null || _newSongIndex! != index)
                              ? neutral2
                              : mainGold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Do you follow any music blogs or websites for recommendation?",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    "Yes",
                    style: context.textTheme.bodyLarge,
                  ),
                  Checkbox(
                    value: _recommended,
                    onChanged: (val) {
                      setState(() => _recommended = true);
                      _controller.forward();
                    },
                    activeColor: mainGold,
                  ),
                  Text(
                    "No",
                    style: context.textTheme.bodyLarge,
                  ),
                  Checkbox(
                    value: !_recommended,
                    onChanged: (val) {
                      setState(() => _recommended = false);
                      _controller.reverse();
                    },
                    activeColor: mainGold,
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _sizeAnimation,
                child: SizedBox(
                    width: 390.w,
                    height: 50.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SpecialForm(
                        controller: _nameController,
                        width: 250.w,
                        height: 35.h,
                        hint: "Please enter the music blog or website",
                      ),
                    )),
              ),
              SizedBox(
                height: 80.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGold,
                    minimumSize: Size(90.w, 35.h),
                  ),
                  child: Text(
                    'Proceed',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _GeographicPage extends StatefulWidget {
  final String header;
  final String subtitle;
  final VoidCallback onNext;

  const _GeographicPage(
      {super.key,
      required this.onNext,
      required this.header,
      required this.subtitle});

  @override
  State<_GeographicPage> createState() => _GeographicPageState();
}

class _GeographicPageState extends State<_GeographicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Text(
                  widget.header,
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: mainGold),
                ),
              ),
              Center(
                child: Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 80.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGold,
                    minimumSize: Size(90.w, 35.h),
                  ),
                  child: Text(
                    'Proceed',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _ListenerDemographicPage extends StatefulWidget {
  final VoidCallback onNext;

  const _ListenerDemographicPage({super.key, required this.onNext});

  @override
  State<_ListenerDemographicPage> createState() =>
      _ListenerDemographicPageState();
}

class _ListenerDemographicPageState extends State<_ListenerDemographicPage> {
  final TextEditingController _ageController = TextEditingController();
  late List<Holder> _genders,
      _occupations,
      _education,
      _languages,
      _notification,
      _dsp;

  int? _genderIndex,
      _occupationIndex,
      _educationIndex,
      _notificationIndex,
      _dspIndex;

  @override
  void initState() {
    super.initState();

    _genders = [
      Holder(content: "Male"),
      Holder(content: "Female"),
      Holder(content: "Other"),
    ];

    _occupations = [
      Holder(content: "Self Employed"),
      Holder(content: "Employed"),
      Holder(content: "Student"),
    ];

    _education = [
      Holder(content: "High School"),
      Holder(content: "Undergraduate"),
      Holder(content: "Graduate"),
    ];

    _languages = [
      Holder(content: "English"),
      Holder(content: "Yoruba"),
      Holder(content: "Igbo"),
      Holder(content: "Hausa")
    ];

    _notification = [
      Holder(content: "Never"),
      Holder(content: "Sometimes"),
      Holder(content: "Often"),
      Holder(content: "Always"),
    ];

    _dsp = [
      Holder(content: "Spotify"),
      Holder(content: "Apple Music"),
      Holder(content: "Audiomack"),
    ];
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Text(
                    "Demographic Information (4 of 5)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "We need to ensure a well-rounded understanding of our audience.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Age",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SpecialForm(
                  controller: _ageController,
                  width: 60.w,
                  height: 35.h,
                  type: TextInputType.number,
                  hint: "e.g 21",
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Gender",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _genders.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _genderIndex = index),
                      child: Chip(
                        label: Text(
                          _genders[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_genderIndex == null ||
                                      _genderIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor:
                            (_genderIndex == null || _genderIndex! != index)
                                ? neutral2
                                : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Occupation",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _occupations.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _occupationIndex = index),
                      child: Chip(
                        label: Text(
                          _occupations[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_occupationIndex == null ||
                                      _occupationIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: (_occupationIndex == null ||
                                _occupationIndex! != index)
                            ? neutral2
                            : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Education Level",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _education.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _educationIndex = index),
                      child: Chip(
                        label: Text(
                          _education[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_educationIndex == null ||
                                      _educationIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: (_educationIndex == null ||
                                _educationIndex! != index)
                            ? neutral2
                            : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Language Preference",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Which languages do you prefer to listen to your songs?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: List.generate(
                    _languages.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _languages[index].selected =
                          !_languages[index].selected),
                      child: Chip(
                        label: Text(
                          _languages[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _languages[index].selected
                                  ? Colors.black
                                  : null),
                        ),
                        elevation: _languages[index].selected ? 1 : 0,
                        backgroundColor:
                            _languages[index].selected ? mainGold : neutral2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Notification Preference",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "How often do you want to get updates on new songs?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _notification.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _notificationIndex = index),
                      child: Chip(
                        label: Text(
                          _notification[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_notificationIndex == null ||
                                      _notificationIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: (_notificationIndex == null ||
                                _notificationIndex! != index)
                            ? neutral2
                            : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Digital Service Platform",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Which DSP do you want to receive streams and promotional content from?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _dsp.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _dspIndex = index),
                      child: Chip(
                        label: Text(
                          _dsp[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_dspIndex == null || _dspIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor:
                            (_dspIndex == null || _dspIndex! != index)
                                ? neutral2
                                : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatefulWidget {
  final String header;
  final VoidCallback onFinish;

  const PrivacyPolicyPage(
      {super.key, required this.onFinish, required this.header});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool readTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    widget.header,
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Please read through our privacy and data consent policy.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  width: 390.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: neutral2),
                  alignment: Alignment.center,
                  child: Text(
                    loremIpsum,
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  width: 390.w,
                  child: Wrap(
                    spacing: 5.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: readTerms,
                        fillColor: MaterialStateProperty.all(mainGold),
                        onChanged: (val) => setState(() => readTerms = val!),
                      ),
                      Text("I agree to the Privacy and Data Consent Policy.",
                          style: context.textTheme.bodyMedium),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (readTerms) {
                        widget.onFinish();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !readTerms ? neutral2 : mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Finish',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: !readTerms ? null : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListenerRegistration extends StatefulWidget {
  const ListenerRegistration({super.key});

  @override
  State<ListenerRegistration> createState() => _ListenerRegistrationState();
}

class _ListenerRegistrationState extends State<ListenerRegistration> {
  late List<Widget> _children;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _children = [
      _ListenerMusicPreferencePage(onNext: next),
      _ListenerMusicDiscoveryPage(onNext: next),
      _GeographicPage(
        onNext: next,
        header: "Geological Preference (3 of 5)",
        subtitle:
            "Please provide your geographical location so we can tailor promotions "
            "based on your regional music preferences.",
      ),
      _ListenerDemographicPage(onNext: next),
      PrivacyPolicyPage(
        onFinish: () => context.router.pushReplacementNamed(Pages.home),
        header: "Privacy and Data Consent (5 of 5)",
      ),
    ];
  }

  void next() => setState(() => ++_index);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: _children,
    );
  }
}

class _ArtisteProfileSetup extends StatefulWidget {
  final VoidCallback onNext;

  const _ArtisteProfileSetup({super.key, required this.onNext});

  @override
  State<_ArtisteProfileSetup> createState() => _ArtisteProfileSetupState();
}

class _ArtisteProfileSetupState extends State<_ArtisteProfileSetup> {
  final TextEditingController _name = TextEditingController(),
      _username = TextEditingController();
  String? _coverImage;

  @override
  void dispose() {
    _username.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    "Basic Information (1 of 6)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Please fill in these details.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Cover Image",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Let your audience recognize you.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 200.h,
                        width: 200.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: _coverImage == null
                              ? neutral2
                              : Colors.transparent,
                          image: _coverImage == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(File(_coverImage!)),
                                  fit: BoxFit.cover),
                        ),
                        child: _coverImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_rounded, size: 36.r),
                                  Text(
                                    "Upload Image (optional)",
                                    style: context.textTheme.bodyMedium,
                                  )
                                ],
                              )
                            : null),
                    ElevatedButton(
                      onPressed: () =>
                          FileManager.single(type: FileType.image).then(
                        (resp) => setState(() => _coverImage = resp?.path),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainGold,
                        minimumSize: Size(90.w, 35.h),
                      ),
                      child: Text(
                        'Choose',
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  "Artiste/Band Name",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                SpecialForm(
                  controller: _name,
                  width: 250.w,
                  height: 35.h,
                  hint: "Enter your name or your band name.",
                ),
                SizedBox(height: 20.h),
                Text(
                  "Username (optional)",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                SpecialForm(
                  controller: _username,
                  width: 250.w,
                  height: 35.h,
                  hint: "Enter your username.",
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtisteMusicDetailsPage extends StatefulWidget {
  final VoidCallback onNext;

  const _ArtisteMusicDetailsPage({super.key, required this.onNext});

  @override
  State<_ArtisteMusicDetailsPage> createState() =>
      _ArtisteMusicDetailsPageState();
}

class _ArtisteMusicDetailsPageState extends State<_ArtisteMusicDetailsPage> {
  final TextEditingController _name = TextEditingController();

  late List<Holder> _primary, _secondary, _styles;
  int? _primaryIndex, _secondaryIndex, _styleIndex;

  final List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _primary = [
      Holder(content: "Afro-beats"),
      Holder(content: "Pop"),
      Holder(content: "Hip-Hop/Rap"),
      Holder(content: "Electronic/Dance"),
      Holder(content: "R&B/Soul"),
      Holder(content: "Country"),
      Holder(content: "Jazz"),
      Holder(content: "Classical"),
      Holder(content: "Indie/Alternative"),
      Holder(content: "Reggae"),
      Holder(content: "Metal"),
      Holder(content: "Folk"),
      Holder(content: "Alternative Fusion"),
    ];

    _secondary = List.of(_primary);

    _styles = [
      Holder(content: "Upbeat and Energetic"),
      Holder(content: "Chill and Relaxing"),
      Holder(content: "Melancholic and Emotional"),
      Holder(content: "Experimental and Avant-Garde"),
      Holder(content: "Dance and Party"),
      Holder(content: "Acoustic and Unplugged"),
      Holder(content: "Powerful and Vocals-driven")
    ];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    "Genres and Style (3 of 6)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Choose the genre and style of your music.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Genres",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Select your primary genre",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _primary.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _primaryIndex = index),
                      child: Chip(
                        label: Text(
                          _primary[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_primaryIndex == null ||
                                      _primaryIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor:
                            (_primaryIndex == null || _primaryIndex! != index)
                                ? neutral2
                                : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Select your secondary genre (optional)",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _secondary.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _secondaryIndex =
                          index == _primaryIndex ? null : index),
                      child: index == _primaryIndex
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                _secondary[index].content,
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: (_secondaryIndex == null ||
                                            _secondaryIndex! != index)
                                        ? null
                                        : Colors.black),
                              ),
                              elevation: 1,
                              backgroundColor: (_secondaryIndex == null ||
                                      _secondaryIndex! != index)
                                  ? neutral2
                                  : mainGold,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Style",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Select the style of your music",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _styles.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _styleIndex = index),
                      child: Chip(
                        label: Text(
                          _styles[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  (_styleIndex == null || _styleIndex! != index)
                                      ? null
                                      : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor:
                            (_styleIndex == null || _styleIndex! != index)
                                ? neutral2
                                : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Similar Artistes",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Let us know about any band or artistes whose style is similar to yours.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _favorites.length,
                    (index) => Chip(
                        onDeleted: () =>
                            setState(() => _favorites.removeAt(index)),
                        deleteIcon: Icon(Boxicons.bx_x,
                            color: Colors.black, size: 18.r),
                        label: Text(
                          _favorites[index],
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: mainGold),
                  ),
                ),
                SizedBox(height: 10.h),
                SpecialForm(
                  controller: _name,
                  hint: "Enter Artiste/Band Name",
                  width: 250.w,
                  height: 35.h,
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold, minimumSize: Size(90.w, 30.h)),
                  onPressed: () {
                    String name = _name.text.trim();
                    if (name.isEmpty) {
                      showError("No name was provided");
                      return;
                    }

                    setState(() {
                      _favorites.add(name);
                      _name.clear();
                    });

                    unFocus();
                  },
                  child: Text(
                    'Add',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtisteBiographyPage extends StatefulWidget {
  final VoidCallback onNext;

  const _ArtisteBiographyPage({super.key, required this.onNext});

  @override
  State<_ArtisteBiographyPage> createState() => _ArtisteBiographyPageState();
}

class _ArtisteBiographyPageState extends State<_ArtisteBiographyPage> {
  final TextEditingController _bio = TextEditingController(),
      _links = TextEditingController();
  final TextEditingController _spotify = TextEditingController(),
      _apple = TextEditingController(),
      _sc = TextEditingController();

  @override
  void dispose() {
    _bio.dispose();
    _links.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    "Biography and DSPs (4 of 6)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Tell us more about yourself.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Biography",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Give us a brief introduction to yourself or your band. Share your background, influences, and musical journey.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SpecialForm(
                    controller: _bio,
                    width: 390.w,
                    height: 150.h,
                    maxLines: 10,
                    hint: "Enter your biography"),
                SizedBox(height: 20.h),
                Text(
                  "Digital Service Platforms",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Provide the links to your profile on these platforms if available as they will be used for promotions.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Spotify",
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                    SpecialForm(
                      controller: _spotify,
                      width: 250.w,
                      height: 35.h,
                      hint: "Enter your Spotify profile link",
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Apple Music",
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SpecialForm(
                      controller: _apple,
                      width: 250.w,
                      height: 35.h,
                      hint: "Enter your Apple Music profile link",
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Audiomack",
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SpecialForm(
                      controller: _sc,
                      width: 250.w,
                      height: 35.h,
                      hint: "Enter your Audiomack profile link",
                    ),
                  ],
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtisteNotificationPreferencePage extends StatefulWidget {
  final VoidCallback onNext;

  const _ArtisteNotificationPreferencePage({super.key, required this.onNext});

  @override
  State<_ArtisteNotificationPreferencePage> createState() =>
      _ArtisteNotificationPreferencePageState();
}

class _ArtisteNotificationPreferencePageState
    extends State<_ArtisteNotificationPreferencePage> {
  late List<Holder> _notification;
  int? _notificationIndex;

  @override
  void initState() {
    super.initState();
    _notification = [
      Holder(content: "Never"),
      Holder(content: "Sometimes"),
      Holder(content: "Often"),
      Holder(content: "Always"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    "Preferences and Data (5 of 6)",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: mainGold),
                  ),
                ),
                Center(
                  child: Text(
                    "Tell us more about yourself.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Notification Preference",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "How do you want to receive updates on campaign performance, listener engagement and promotional opportunities?",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(
                    _notification.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _notificationIndex = index),
                      child: Chip(
                        label: Text(
                          _notification[index].content,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (_notificationIndex == null ||
                                      _notificationIndex! != index)
                                  ? null
                                  : Colors.black),
                        ),
                        elevation: 1,
                        backgroundColor: (_notificationIndex == null ||
                                _notificationIndex! != index)
                            ? neutral2
                            : mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Previous Performance Data (Optional)",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Please provide your previous performance data on other platforms if available.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(90.w, 35.h),
                    ),
                    child: Text(
                      'Proceed',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArtisteRegistration extends StatefulWidget {
  const ArtisteRegistration({super.key});

  @override
  State<ArtisteRegistration> createState() => _ArtisteRegistrationState();
}

class _ArtisteRegistrationState extends State<ArtisteRegistration> {
  late List<Widget> _children;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _children = [
      _ArtisteProfileSetup(onNext: next),
      _GeographicPage(
        onNext: next,
        header: "Geographic Location (2 of 6)",
        subtitle: "Let us know the region you are making your music.",
      ),
      _ArtisteMusicDetailsPage(onNext: next),
      _ArtisteBiographyPage(onNext: next),
      _ArtisteNotificationPreferencePage(onNext: next),
      PrivacyPolicyPage(
          onFinish: () => context.router.pushReplacementNamed(Pages.home),
          header: "Privacy and Data Consent (6 of 6)"),
    ];
  }

  void next() => setState(() => ++_index);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: _children,
    );
  }
}
