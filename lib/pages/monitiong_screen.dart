part of 'pages.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({Key key}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  //tesing data realtime
  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    _readDB_onechild();
    // _read_once();
    // oneChange();
    dataChange();
  }

  DatabaseReference _dbref;
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

  // ignore: non_constant_identifier_names
  _readDB_onechild() {
    _dbref
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

  // ignore: non_constant_identifier_names
  // ignore: unused_element
  _read_once() {
    _dbref.once().then((DataSnapshot dataSnapshot) {
      print("read once" + dataSnapshot.value);
      setState(() {
        databasejson = dataSnapshot.value.toString();
      });
    });
  }

  void oneChange() {
    _dbref
        .child('monitoring')
        .child('sensorsatu')
        .onValue
        .listen((Event event) {
      int data = event.snapshot.value;

      print('weight data: $data');
      setState(() {
        suhu = data;
      });
    });
  }

  void dataChange() {
    _dbref.child('monitoring').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map data = event.snapshot.value;
      data.forEach((key, value) {
        setState(() {
          nutrisi = data['nutrisi'];
          nutrisiA = data['nutrisi_a'];
          nutrisiB = data['nutrisi_b'];
          ph = data['ph'];
          phDown = data['ph_down'];
          phUP = data['ph_up'];
          suhu = data['suhu'];
          volumeTandon = data['vol_tandon'];
          kuras = data['kuras'];
          afterKuras = data['after_kuras'];
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
                      width: 150,
                      height: 100,
                    ),
                    sensor(
                        "assets/suhu_ic.png", "Suhu", suhu.toString() + " C"),
                    sensor("assets/ph_ic.png", "Ph", "7.1"),
                  ],
                ),
                Row(
                  children: [
                    doughnatChart("Air Tandon", 230, 200, volumeTandon),
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
                history("assets/ic_nutrisi_history.png",
                    "Pemberian Nutrisi Terakhir", nutrisi,
                    value: kuras),
                SizedBox(
                  height: 25,
                ),
                history("assets/water_ic.png", "Pengurasan air terakhir",
                    afterKuras,
                    value: kuras),
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
