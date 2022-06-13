part of 'widget.dart';

Widget sensor(String imagePath, String name, String value) {
  return Row(
    children: [
      Image.asset(
        imagePath,
        width: 70,
        height: 70,
      ),
      Column(
        children: [Text(name), Text(value)],
      )
    ],
  );
}
