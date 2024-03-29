import 'package:quote_app/headers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showRandomQuote() {
    //Random  => dart:math
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        isList: _isList,
        toggleList: () {
          _isList = !_isList;
          setState(() {});
        },
      ),
      body: Column(
        children: [
          //Categories
          categoryList(),
          //Quotes
          _isList ? quotesListView() : quotesGridView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailPage,
          );
        },
      ),
    );
  }
}
