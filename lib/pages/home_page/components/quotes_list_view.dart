import 'package:quote_app/headers.dart';

Widget quotesListView() {
  bool isCategorySelected = Global.selectedCategory != "All";

  return isCategorySelected
      ? Expanded(
          flex: 12,
          child: ListView.separated(
            itemCount: selectedCategoryQuote.length,
            itemBuilder: (context, index) => ExpansionTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detailPage,
                    arguments: selectedCategoryQuote[index],
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              title: Text(
                selectedCategoryQuote[index].quote,
                style: TextStyle(
                  fontFamily: AppFonts.foundation.name,
                ),
              ),
              children: [
                Text("Author: ${selectedCategoryQuote[index].author}"),
                Text("Category: ${selectedCategoryQuote[index].category}"),
              ],
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: 16,
              endIndent: 16,
            ),
          ),
        )
      : Expanded(
          flex: 12,
          child: ListView.separated(
            itemCount: allQuotes.length,
            itemBuilder: (context, index) => ExpansionTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detailPage,
                    arguments: allQuotes[index],
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              title: Text(
                allQuotes[index].quote,
                style: TextStyle(
                  fontFamily: AppFonts.foundation.name,
                ),
              ),
              children: [
                Text("Author: ${allQuotes[index].author}"),
                Text("Category: ${allQuotes[index].category}"),
              ],
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: 16,
              endIndent: 16,
            ),
          ),
        );
}
