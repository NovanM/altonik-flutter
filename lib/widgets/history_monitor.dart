part of 'widget.dart';

Widget history(String imagePath, String title, String counterDate,
    {value = false}) {
  DateTime now = DateTime.now();
  String date = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  return Container(
    width: double.infinity,
    height: 70,
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
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                value
                    ? Text(
                        date,
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        counterDate,
                        style: TextStyle(fontSize: 16),
                      )
              ],
            )
          ],
        )
      ],
    ),
  );
}
