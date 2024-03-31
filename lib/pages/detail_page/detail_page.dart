import 'package:quote_app/headers.dart';
import 'dart:ui' as ui;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double backgroundOpacity = 1;
  double fontOpacity = 1;
  String fonts = AppFonts.dancingScript.name;

  GlobalKey widgetKey = GlobalKey();

  Future<File> getFileFromWidget() async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List list = data!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(list);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    Quote quote = ModalRoute.of(context)!.settings.arguments as Quote;

    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        if (val) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert !!"),
            content: const Text("Are you sure to exit?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // _canPop = true;
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Page"),
          actions: [
            IconButton(
              onPressed: () {
                backgroundOpacity = 1;
                Global.backgroundColor = Colors.white;
                fonts = AppFonts.dancingScript.name;
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: RepaintBoundary(
                key: widgetKey,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color:
                        Global.backgroundColor.withOpacity(backgroundOpacity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        quote.quote,
                        style: TextStyle(
                          color: Global.fontColor.withOpacity(fontOpacity),
                          // fontSize: 27.75,
                          fontSize: Global.fontSize,
                          fontFamily: fonts,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SelectableText(
                        "- ${quote.author}",
                        style: TextStyle(
                          fontFamily: fonts,
                          color: Global.fontColor.withOpacity(fontOpacity),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              //Column
              child: ListView(
                children: [
                  // Background data-------------------------------------------------------------------------------------------------
                  const Text(
                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t----: Background color data :----",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // BackGroundColour --------------------------------------------------------------------
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Colour Picker
                        GestureDetector(
                          onTap: () {
                            Global.backgroundColor = Colors.grey;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Pick a color"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Back"))
                                      ],
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: Global.backgroundColor,
                                          paletteType: PaletteType.hueWheel,
                                          onColorChanged: (Color value) {
                                            Global.backgroundColor = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        ...List.generate(
                          18,
                          (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                Global.backgroundColor =
                                    Colors.primaries[index];
                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.primaries[index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // BackgroundColourOpacityScrollbar
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Slider(
                      value: backgroundOpacity,
                      min: 0,
                      max: 1,
                      onChanged: (val) {
                        backgroundOpacity = val;
                        setState(() {});
                      },
                    ),
                  ),
                  // Font data-------------------------------------------------------------------------------------------------
                  const Text(
                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t----: Font color data :----",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // BackGroundColour ---------------------------------------------------------------------
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Colour Picker
                        GestureDetector(
                          onTap: () {
                            Global.fontColor = Colors.grey;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Pick a color"),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: Global.fontColor,
                                            paletteType: PaletteType.hueWheel,
                                            onColorChanged: (Color value) {
                                              Global.fontColor = value;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                        ...List.generate(
                          18,
                          (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                Global.fontColor = Colors.primaries[index];
                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.primaries[index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // FontColourOpacityScrollbar
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Slider(
                      value: fontOpacity,
                      min: 0,
                      max: 1,
                      onChanged: (val) {
                        fontOpacity = val;
                        setState(() {});
                      },
                    ),
                  ),
                  // FontSizeScrollbar
                  const Text(
                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t ----: Font Size :----",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Slider(
                      value: Global.fontSize,
                      min: 1,
                      max: 27.75,
                      onChanged: (val) {
                        Global.fontSize = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListWheelScrollView(
                  itemExtent: 50,
                  clipBehavior: Clip.antiAlias,
                  // useMagnifier: true,
                  // magnification: 1,
                  diameterRatio: 0.7,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Text(
                      "----: Scroll down and select font :----",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...AppFonts.values
                        .map(
                          (e) => TextButton(
                            onPressed: () {
                              fonts = e.name;
                              setState(() {});
                            },
                            child: Text(
                              "Abc",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: e.name,
                                  color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Options"),
                    content: const Text("Select any one option."),
                    actions: [
                      // Share
                      ElevatedButton.icon(
                        onPressed: () async {
                          ShareExtend.share(
                            (await getFileFromWidget()).path,
                            "image",
                          );
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                      ),
                      // Save
                      ElevatedButton.icon(
                        onPressed: () async {
                          ImageGallerySaver.saveFile(
                            (await getFileFromWidget()).path,
                            isReturnPathOfIOS: true,
                          ).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Saved to gallery !!"),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Save"),
                      ),
                      // Copy
                      ElevatedButton.icon(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: "${quote.quote}\n\n-${quote.author}",
                            ),
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Quote copied to clipboard !!"),
                              ),
                            );
                          });
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text("Copy"),
                      ),
                    ],
                  );
                });
          },
          label: const Text("Share"),
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
