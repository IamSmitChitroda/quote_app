import 'package:quote_app/headers.dart';

Widget dialogueDemo({
  required BuildContext context,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: const Text("Simple Dialogue"),
                children: [
                  RadioListTile(
                    title: const Text("Male"),
                    value: "Male",
                    groupValue: "Male",
                    onChanged: (val) {},
                  ),
                  RadioListTile(
                    title: const Text("Female"),
                    value: "Female",
                    groupValue: "Female",
                    onChanged: (val) {},
                  ),
                ],
              ),
            );
          },
          child: const Text("Simple Dialogue"),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                //Custom (full-screen)
                child: Container(
                  margin: const EdgeInsets.all(30),
                  color: Colors.blue,
                  child: const SizedBox.expand(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          },
          child: const Text("Conformational Dialogue"),
        ),
      ],
    ),
  );
}