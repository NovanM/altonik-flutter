part of 'widget.dart';

Widget history(
  String imagePath,
  String title,
) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
        color: historyColor, borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title),
            Row(
              children: [Text(DateTime.now().toString())],
            )
          ],
        )
      ],
    ),
  );
}
