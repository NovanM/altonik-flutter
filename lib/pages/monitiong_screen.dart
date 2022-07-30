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
    // _read_once();
    // oneChange();
    dataChange();
  }

  var nutrisi;
  var nutrisiA;
  var nutrisiB;
  var ph;
  var phDown;
  var phUP;
  var suhu;
  var volumeTandon;
  var afterKuras;
  var afterNutrisi;
  var hariTanam;
  var kekeruhan;

  void dataChange() {
    widget.databaseReference.child('monitoring').onValue.listen((event) {
      Map dataku = event.snapshot.value;
      dataku.forEach((key, value) {
        setState(() {
          nutrisi = dataku['nutrisi'];
          nutrisiA = dataku['nutrisi_a'];
          nutrisiB = dataku['nutrisi_b'];
          ph = dataku['ph'];
          hariTanam = dataku['hari_tanam'];
          kekeruhan = dataku['kekeruhan'];
          phDown = dataku['ph_down'];
          phUP = dataku['ph_up'];
          suhu = dataku['suhu'];
          volumeTandon = dataku['vol_tandon'];
          afterNutrisi = DateTime.parse(dataku['after_nutrisi']);
          afterKuras = dataku['after_kuras'];
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
    TextEditingController hari =
        new TextEditingController(text: hariTanam.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    addHaritanam() {
      widget.databaseReference
          .child("monitoring")
          .update({"hari_tanam": int.parse(hari.text)});
      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          .showSnackBar(new SnackBar(
        content: new Text('Update Hari Tanam'),
        backgroundColor: Colors.green,
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
                SizedBox(height: 50),
                Text(
                  "Monitoring Tanaman Selada",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/pakcoy_img.png",
                      width: 110,
                      height: 100,
                    ),
                    sensor(
                        "assets/suhu_ic.png", "Suhu", suhu.toString() + " C"),
                    sensor("assets/ph_ic.png", "Ph", ph.toString()),
                  ],
                ),
                (hariTanam != null)
                    ? TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Hari Tanaman Selada',
                          labelStyle: labelText,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/usia_ic.png',
                              fit: BoxFit.cover,
                              width: 20,
                            ),
                          ),
                          border: new OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        controller: hari,
                        style: labelText,
                      )
                    : Container(),
                ElevatedButton(
                  onPressed: () => addHaritanam(),
                  child: Text('Perbaruhi'),
                  style: ElevatedButton.styleFrom(primary: mainColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    doughnatChart("Air Tandon", 180, 180, volumeTandon),
                    Column(
                      children: [
                        sensor("assets/nutrisi_ic.png", "Nutrisi",
                            nutrisi.toString() + " ppm"),
                        sensor("assets/water_ic.png", "Kekeruhan",
                            kekeruhan.toString() + ' ntu')
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
                  DateFormat('d MMM - kk:mm').format(afterNutrisi),
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
