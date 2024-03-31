import 'package:quote_app/headers.dart';

Widget quotesMasonryGridView({required BuildContext context}) {
  bool isCategorySelected = Global.selectedCategory != "All";
  return Expanded(
    flex: 12,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        thickness: 10,
        interactive: true,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemBuilder: (BuildContext context, int index) {
            return isCategorySelected
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailPage,
                        arguments: selectedCategoryQuote[index],
                      );
                    },
                    child: Card(
                      color: Colors.primaries[index % 18].shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              selectedCategoryQuote[index].quote,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text("- ${selectedCategoryQuote[index].author}"),
                          ],
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailPage,
                        arguments: allQuotes[index],
                      );
                    },
                    child: Card(
                      color: Colors.primaries[index % 18].shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              allQuotes[index].quote,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text("- ${allQuotes[index].author}"),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          itemCount: isCategorySelected
              ? selectedCategoryQuote.length
              : allQuotes.length,
        ),
      ),
    ),
  );
}
