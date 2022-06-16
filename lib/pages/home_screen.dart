part of 'pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: MediaQuery.of(context).size.width - 100,
            top: -10,
            child: Container(
              width: 160,
              height: 160,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mainColor),
            ),
          ),
          Positioned(
            top: 30,
            left: -10,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Image.asset(
                  "assets/pakcoy_img.png",
                  width: 100,
                  height: 80,
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width - 40,
            top: 100,
            child: Container(
              width: 160,
              height: 160,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mainColor),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width - 40,
            bottom: -380,
            left: -50,
            child: Container(
              width: 160,
              height: 160,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: secondColor),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width - 20,
            bottom: -400,
            right: -100,
            child: Container(
              width: 160,
              height: 160,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mainColor),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/altonik_ic.png",
                  width: 100,
                  height: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: Text('Tanaman Pak Coy'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Monitoring()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    primary: mainColor,
                    minimumSize: Size(300, 50),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: Text('Pengurasan Air'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Drain()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    primary: mainColor,
                    minimumSize: Size(300, 50),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
