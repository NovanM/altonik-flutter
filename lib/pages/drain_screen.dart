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
  var kekeruhan;
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
      setState(() {
        volumeTandon = dataSnapshot.value;
      });
    });
  }

  void dataChange() {
    _dbref.child('monitoring').onValue.listen((event) {
      Map data = event.snapshot.value;
      data.forEach((key, value) {
        setState(() {
          ph = data['ph'];
          volumeTandon = data['vol_tandon'];
          kekeruhan = data['kekeruhan'];
          kuras = data['kuras'];
          afterKuras = data['after_kuras'];
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    updatevalue() {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d MMM – kk:mm').format(now);
      _dbref.child("monitoring").update({"after_kuras": formattedDate});
      _dbref.child("monitoring").update({"kuras": true});
      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          .showSnackBar(new SnackBar(
        content: new Text('Pengurasan Air Dilakukan '),
        backgroundColor: mainColor,
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
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
                  "Pengurasan Air ",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/pakcoy_img.png",
                      width: 100,
                      height: 100,
                    ),
                    sensor("assets/water_ic.png", "Kekeruhan",
                        kekeruhan.toString() + ' ntu'),
                    sensor("assets/ph_ic.png", "Ph", ph.toString()),
                  ],
                ),
                doughnatChart("Air Tandon", 230, 200, volumeTandon),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Pengurasan Air'),
                  onPressed: () => updatevalue(),
                  style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    primary: mainColor,
                    minimumSize: Size(300, 50),
                  ),
                ),
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
