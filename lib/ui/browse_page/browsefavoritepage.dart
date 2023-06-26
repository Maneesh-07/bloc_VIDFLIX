import 'package:bloc_VIDFLIX/ui/browse_page/favoriteslist.dart';
import 'package:bloc_VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:bloc_VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BrowseFavoritepage extends StatelessWidget {
   BrowseFavoritepage({super.key});

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            appBar: PreferredSize(
                child: NewappbarWidgets(), preferredSize: Size.fromHeight(70)),
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FavoritesScreen(),
            ),
          );
        });
  }
}
