import "package:flutter/cupertino.dart";
import "package:quote_app/headers.dart";

AppBar appBar({
  String title = "Home Page",
  required bool isList,
  required BuildContext context,
  required void Function() toggleList,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return AppBar(
    leading: IconButton(
      // onPressed: openDrawerFunction,
      icon: const Icon(CupertinoIcons.profile_circled),
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
    ),
    centerTitle: true,
    title: Text(title),
    actions: [
      IconButton(
        onPressed: toggleList,
        icon: Icon(
          isList ? Icons.grid_view_outlined : Icons.list,
        ),
      ),
    ],
  );
}
