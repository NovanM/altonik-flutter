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
    // _readDB_onechild();
    // _read_once();
    // oneChange();
    dataChange();
  }

  DatabaseReference _dbref;
  String databasejson = '';
  var datacek;
  MonitoringData monitoringData;

  // ignore: non_constant_identifier_names
  _readDB_onechild() {
    _dbref
        .child("monitoring")
        .child("suhu")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print("read " + dataSnapshot.value);
      setState(() {
        databasejson = dataSnapshot.value;
        monitoringData.suhu = dataSnapshot.value;
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
        datacek = dataSnapshot.value;
      });
    });
  }

  void oneChange() {
    _dbref.child('monitoring').child('nutrisi_a').onValue.listen((Event event) {
      double data = event.snapshot.value;

      print('weight data: $data');
      setState(() {
        monitoringData.nutrisiA = data.toInt();
      });
    });
  }

  void dataChange() {
    _dbref.child('monitoring').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map data = event.snapshot.value;
      print(data);
      data.forEach((key, value) {
        setState(() {
          monitoringData.nutrisi = data['nutrisi'];
          monitoringData.nutrisiA = data['nutrisi_a'];
          monitoringData.nutrisiB = data['nutrisi_b'];
          monitoringData.ph = data['ph'];
          monitoringData.phDown = data['ph_down'];
          monitoringData.suhu = data['suhu'];
          monitoringData.volumeTandon = data['vol_tandon'];
          print(monitoringData);
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
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Monitoring Tanaman Pak Coy"),
                Row(
                  children: [
                    Image.asset(
                      "assets/pakcoy_img.png",
                      width: 150,
                      height: 100,
                    ),
                    sensor("assets/suhu_ic.png", "Suhu", "38 C"),
                    sensor("assets/ph_ic.png", "Ph", "7.1"),
                  ],
                ),
                Row(
                  children: [
                    doughnatChart("Air Tandon", 230, 200, 20),
                    Column(
                      children: [
                        sensor("assets/nutrisi_ic.png", "Nutrisi", "5 ppm"),
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
                    doughnatChart("Nutrisi A", 150, 150, 20),
                    Spacer(),
                    doughnatChart("Nutrisi B", 150, 150, 20)
                  ],
                ),
                Row(
                  children: [
                    doughnatChart("Ph UP", 150, 150, 20),
                    Spacer(),
                    doughnatChart("Ph Down", 150, 150, 20)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                history("assets/ic_nutrisi_history.png",
                    "Pemberian Nutrisi Terakhir"),
                SizedBox(
                  height: 25,
                ),
                history("assets/water_ic.png", "Pengurasan air terakhir"),
                SizedBox(
                  height: 50,
                ),
                Text("data real"),
                SizedBox(
                  height: 50,
                )
//tesing data realtime
              ],
            ),
          ),
        ),
      ),
    );
  }
}
