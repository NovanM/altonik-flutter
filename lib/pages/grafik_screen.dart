part of 'pages.dart';

class Grafik extends StatefulWidget {
  const Grafik({Key key}) : super(key: key);

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  var suhu;
  var kekeruhan;
  var ph;
  var nutrisi;
  var data;
  var dataCounter = [10, 20];
  bool isNotNull = false;
  Future<dynamic> getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("grafik").get();

    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var d in data) {
      setState(() {
        suhu = d['suhu'];
        ph = d['ph'];
        kekeruhan = d['kekurahan'];
        nutrisi = d['nutrisi'];
        print(suhu);
        print(ph);
        print(kekeruhan);
        print(nutrisi);
        isNotNull = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Grafik Monitoring",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isNotNull ? grafik(suhu) : CircularProgressIndicator(),
                  isNotNull ? grafik(ph) : Container(),
                  isNotNull ? grafik(nutrisi) : Container(),
                  isNotNull ? grafik(kekeruhan) : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
