part of 'pages.dart';

class Drain extends StatefulWidget {
  const Drain({Key key}) : super(key: key);

  @override
  State<Drain> createState() => _DrainState();
}

class _DrainState extends State<Drain> {
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
  var volumeTandon;
  var suhu;
  var ph;
  var kuras;
  var afterKuras;
  // ignore: non_constant_identifier_names
  _readDB_onechild() {
    _dbref
        .child("monitoring")
        .child("vol_tandon")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print("read " + dataSnapshot.value);
      setState(() {
        volumeTandon = dataSnapshot.value;
      });
    });
  }

  void dataChange() {
    _dbref.child('monitoring').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map data = event.snapshot.value;
      data.forEach((key, value) {
        setState(() {
          ph = data['ph'];
          volumeTandon = data['vol_tandon'];
          suhu = data['suhu'];
          kuras = data['kuras'];
          afterKuras = data['after_kuras'];
        });
      });
    });
  }

  updatevalue() {
    _dbref.child("monitoring").update({"after_kuras": "2022-06-15 - 00:00"});
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
                  "Pengurasan Air Tanaman Pak Coy",
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
                    sensor("assets/ph_ic.png", "Ph", ph.toString()),
                  ],
                ),
                doughnatChart("Air Tandon", 230, 200, volumeTandon),
                SizedBox(
                  height: 20,
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
