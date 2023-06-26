import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/widgets/appbarWidget.dart';
import 'package:bloc_VIDFLIX/widgets/girdview.dart';
import 'package:bloc_VIDFLIX/widgets/list_view.dart';
import 'package:flutter/material.dart';

List videos = [];
// ValueNotifier<bool> isListview = ValueNotifier(true);

class HomeVideolist extends StatelessWidget {
  const HomeVideolist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isListView,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: mainBGColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), // here the desired height
            child: AppBarWidget(),
          ),
          body: isListView.value == true
              ? Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: ListViewWidgetForAllVideos(),
                )
              : GridViewWidgetForAllVideos(),
          // floatingActionButton: ResumeButton(),
        );
      },
    );
  }
}
