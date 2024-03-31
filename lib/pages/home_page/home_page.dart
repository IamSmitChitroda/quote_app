import 'package:quote_app/headers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showRandomQuote() {
    Random r = Random();

    String category = "art";

    List<Quote> l = allQuotes
        .where(
          (element) => element.category == category,
        )
        .toList();

    Quote q = l[r.nextInt(l.length)];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Welcome !!"),
        contentPadding: const EdgeInsets.all(16),
        children: [
          Text(q.quote),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        showRandomQuote();
      },
    );
    super.initState();
  }

  bool _isList = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget allCategory({required BuildContext context}) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allCategories
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Global.selectedCategory == e
                      ? Global.selectedCategory = "All"
                      : Global.selectedCategory = e;

                  selectedCategoryQuote = allQuotes
                      .where((element) =>
                          element.category == Global.selectedCategory)
                      .toList();
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        color: Colors.grey,
                        blurRadius: 5,
                      )
                    ],
                    border: Border.all(
                      width: Global.selectedCategory == e ? 3 : 1,
                      color: Global.selectedCategory == e
                          ? Colors.primaries[allCategories.indexOf(e)]
                          : Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(e.replaceFirst(e[0], e[0].toUpperCase())),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(
        isList: _isList,
        context: context,
        toggleList: () {
          _isList = !_isList;
          setState(() {});
        },
        scaffoldKey: scaffoldKey,
        // openDrawerFunction: () => Scaffold.of(context).openDrawer(),
        // openDrawerFunction: () => ScaffoldKey.currentState!.openDrawer(),
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Smit Chitroda"),
                accountEmail: Text("smit@mail.io"))
          ],
        ),
      ),
      body: Column(
        children: [
          //Categories
          allCategory(
              // onPressed: () {
              //   Global.selectedCategory = e;
              //   selectedCategoryQuote = allQuotes
              //       .where((element) =>
              //           element.category == Global.selectedCategory)
              //       .toList();
              //   setState(() {});
              // },
              context: context),
          //Quotes
          _isList ? quotesListView() : quotesMasonryGridView(context: context),
        ],
      ),
    );
  }
}
