part of 'widget.dart';

Widget sensor(String imagePath, String name, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        imagePath,
        width: 60,
        height: 60,
        fit: BoxFit.fitWidth,
      ),
      SizedBox(
        width: 4,
      ),
      Column(
        children: [
          Text(name),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      )
    ],
  );
}
