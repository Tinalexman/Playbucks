import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/search.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final FocusNode node = FocusNode();
  final TextEditingController searchController = TextEditingController();

  void onSearch(String text) {}

  @override
  void initState() {
    super.initState();
    node.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final List<SearchTerm> searches = ref.watch(searchesProvider);

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
          "Search",
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SpecialForm(
                width: 390.w,
                height: 40.h,
                focus: node,
                prefix: SizedBox(
                  height: 40.h,
                  width: 40.h,
                  child: Icon(
                    Icons.search_rounded,
                    color: mainGold,
                    size: 26.r,
                  ),
                ),
                controller: searchController,
                hint: "Search song or artiste",
                action: TextInputAction.go,
                onActionPressed: onSearch,
                onChange: (text) => onSearch(text),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Recent",
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: mainGold,
                      decorationColor: mainGold,
                      decorationThickness: 1.5.h,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == searches.length) {
                      return SizedBox(height: 50.h);
                    }

                    return _SearchContainer(
                      data: searches[index],
                      onRemove: () {},
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: searches.length + 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchContainer extends StatelessWidget {
  final SearchTerm data;
  final VoidCallback onRemove;

  const _SearchContainer({
    super.key,
    required this.data,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 50.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: theme,
              backgroundImage: AssetImage(data.artisteImage),
            ),
            SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.artisteName,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    data.song,
                    style: context.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => context.router.pushNamed(Pages.editProfile),
              child: Icon(
                Boxicons.bx_x,
                color: mainGold,
                size: 26.r,
              ),
            )
          ],
        ),
      ),
    );
  }
}
