import "package:quote_app/headers.dart";

AppBar appBar({
  String title = "Home Page",
  required bool isList,
  required void Function() toggleList,
}) {
  return AppBar(
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
