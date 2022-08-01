part of 'pages.dart';

class Monitoring extends StatefulWidget {
  final DatabaseReference databaseReference;
  const Monitoring({Key key, this.databaseReference}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  //tesing data realtime
  // @override
  // void initState() {
  //   super.initState();
  //   // _read_once();
  //   // oneChange();
  //   dataChange();
  // }

  // var nutrisi;
  // var nutrisiA;
  // var nutrisiB;
  // var ph;
  // var phDown;
  // var phUP;
  // var suhu;
  // var volumeTandon;
  // var afterKuras;
  // var afterNutrisi;
  // var hariTanam;
  // var kekeruhan;

  // void dataChange() {
  //   widget.databaseReference.child('monitoring').onValue.listen((event) {
  //     Map dataku = event.snapshot.value;
  //     dataku.forEach((key, value) {
  //       setState(() {
  //         nutrisi = dataku['nutrisi'];
  //         nutrisiA = dataku['nutrisi_a'];
  //         nutrisiB = dataku['nutrisi_b'];
  //         ph = dataku['ph'];
  //         hariTanam = dataku['hari_tanam'];
  //         kekeruhan = dataku['kekeruhan'];
  //         phDown = dataku['ph_down'];
  //         phUP = dataku['ph_up'];
  //         suhu = dataku['suhu'];
  //         volumeTandon = dataku['vol_tandon'];
  //         afterNutrisi = dataku['after_nutrisi'];

  //         afterKuras = dataku['after_kuras'];
  //       });
  //     });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    Map mapData = Map();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<Object>(
              stream: widget.databaseReference.onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Loading.. \n\nMohon Tunggu Proses Deteksi Kualitas Panen Sedang Berjalan',
                                textAlign: TextAlign.center,
                                style: labelText,
                              ),
                            )
                          ]),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Loading..',
                                textAlign: TextAlign.center,
                                style: labelText,
                              ),
                            )
                          ]),
                    ),
                  );
                } else if (snapshot.hasData) {
                  print('Error get data realtime');
                  DataSnapshot dataValues =
                      snapshot.data.snapshot ?? Container();
                  Map<dynamic, dynamic> values = dataValues.value;
                  print(values);
                  values.forEach((key, value) {
                    mapData['suhu'] = value['suhu'];
                    mapData['ph'] = value['ph'];
                    mapData['vol_tandon'] = value['vol_tandon'];
                    mapData['hari_tanam'] = value['hari_tanam'];
                    mapData['kekeruhan'] = value['kekeruhan'];
                    mapData['nutrisi'] = value['nutrisi'];
                    mapData['nutrisi_a'] = value['nutrisi_a'];
                    mapData['nutrisi_b'] = value['nutrisi_b'];
                    // mapData['ph'] = int.parse(value['ph']);
                    mapData['ph_down'] = value['ph_down'];
                    mapData['ph_up'] = value['ph_up'];
                    mapData['suhu'] = value['suhu'];
                    mapData['after_nutrisi'] = value['after_nutrisi'];
                    mapData['after_kuras'] = value['after_kuras'];
                  });
                }

                TextEditingController hari = new TextEditingController(
                    text: mapData['hari_tanam'].toString());
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

                return Container(
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
                          sensor("assets/suhu_ic.png", "Suhu",
                              mapData['suhu'].toString() + " C"),
                          sensor("assets/ph_ic.png", "Ph",
                              mapData['ph'].toString()),
                        ],
                      ),
                      (mapData['hari_tanam'] != null)
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
                          doughnatChart(
                              "Air Tandon", 180, 180, mapData['vol_tandon']),
                          Column(
                            children: [
                              sensor("assets/nutrisi_ic.png", "Nutrisi",
                                  mapData['nutrisi'].toString() + " ppm"),
                              sensor("assets/water_ic.png", "Kekeruhan",
                                  mapData['kekeruhan'].toString() + ' ntu')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          doughnatChart(
                              "Nutrisi A", 150, 150, mapData['nutrisi_a']),
                          Spacer(),
                          doughnatChart(
                              "Nutrisi B", 150, 150, mapData['nutrisi_b'])
                        ],
                      ),
                      Row(
                        children: [
                          doughnatChart("Ph UP", 150, 150, mapData['ph_up']),
                          Spacer(),
                          doughnatChart("Ph Down", 150, 150, mapData['ph_down'])
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      history(
                        "assets/ic_nutrisi_history.png",
                        "Pemberian Nutrisi Terakhir",
                        DateFormat('d MMM - hh:mm')
                            .format(DateTime.parse(mapData['after_nutrisi'])),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      history(
                        "assets/water_ic.png",
                        "Pengurasan air terakhir",
                        mapData['after_kuras'],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
