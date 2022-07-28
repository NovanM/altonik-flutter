part of 'pages.dart';

class Monitoring extends StatefulWidget {
  final DatabaseReference databaseReference;
  const Monitoring({Key key, this.databaseReference}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  //tesing data realtime
  @override
  void initState() {
    super.initState();
    // _readDB_onechild();
    // _read_once();
    // oneChange();
    dataChange();
  }

  String databasejson = '';
  var nutrisi;
  var nutrisiA;
  var nutrisiB;
  var ph;
  var phDown;
  var phUP;
  var suhu;
  var volumeTandon;
  var kuras;
  var afterKuras;
  var isDone = 5;
  // ignore: non_constant_identifier_names
  _readDB_onechild() {
    widget.databaseReference
        .child("monitoring")
        .child("sensorsatu")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print("read " + dataSnapshot.value);
      setState(() {
        databasejson = dataSnapshot.value;
      });
    });
  }

  void dataChange() {
    widget.databaseReference.child('monitoring').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map dataku = event.snapshot.value;
      dataku.forEach((key, value) {
        setState(() {
          nutrisi = dataku['nutrisi'];
          nutrisiA = dataku['nutrisi_a'];
          nutrisiB = dataku['nutrisi_b'];
          ph = dataku['ph'];
          phDown = dataku['ph_down'];
          phUP = dataku['ph_up'];
          suhu = dataku['suhu'];
          volumeTandon = dataku['vol_tandon'];
          kuras = dataku['kuras'];
          afterKuras = dataku['after_kuras'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Monitoring Tanaman Pak Coy",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/pakcoy_img.png",
                      width: 140,
                      height: 100,
                    ),
                    sensor(
                        "assets/suhu_ic.png", "Suhu", suhu.toString() + " C"),
                    sensor("assets/ph_ic.png", "Ph", ph.toString()),
                  ],
                ),
                Row(
                  children: [
                    doughnatChart("Air Tandon", 200, 200, volumeTandon),
                    Column(
                      children: [
                        sensor("assets/nutrisi_ic.png", "Nutrisi",
                            nutrisi.toString() + " ppm"),
                        sensor("assets/usia_ic.png", "Usia", "7 hari")
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    doughnatChart("Nutrisi A", 150, 150, nutrisiA),
                    Spacer(),
                    doughnatChart("Nutrisi B", 150, 150, nutrisiB)
                  ],
                ),
                Row(
                  children: [
                    doughnatChart("Ph UP", 150, 150, phUP),
                    Spacer(),
                    doughnatChart("Ph Down", 150, 150, phDown)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                history(
                  "assets/ic_nutrisi_history.png",
                  "Pemberian Nutrisi Terakhir",
                  afterKuras,
                ),
                SizedBox(
                  height: 25,
                ),
                history(
                  "assets/water_ic.png",
                  "Pengurasan air terakhir",
                  afterKuras,
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
