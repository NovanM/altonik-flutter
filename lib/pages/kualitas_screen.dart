part of 'pages.dart';

class Grade extends StatefulWidget {
  const Grade({Key key}) : super(key: key);

  @override
  State<Grade> createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    dataChange();
  }

  DatabaseReference _dbref;
  var initialApp = true;
  var datePanen;
  var hariTanam;

  // ignore: non_constant_identifier_names
  void dataChange() {
    _dbref.child('monitoring').onValue.listen((event) {
      Map dataku = event.snapshot.value;
      var dateNow = new DateTime.now();
      dataku.forEach((key, value) {
        setState(() {
          initialApp = dataku['start_app'];
          hariTanam = dataku['hari_tanam'];
          datePanen = new DateTime(dateNow.year, dateNow.month,
              dateNow.day + (45 - dataku['hari_tanam']));
        });
      });
    });
  }

  // Future getData() async {
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection("siap_panen").get();
  //   final data = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   for (var d in data) {
  //     setState(() {
  //       talangPertama = d['talang_pertama'];
  //       talangKedua = d['talang_kedua'];
  //       print(talangPertama);
  //       isNotNull = true;
  //     });
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialApp
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("siap_panen")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(child: Container());
                }
                Map dataTalangPertama = {
                  'baik': 0,
                  'sangat_baik': 0,
                  'cukup': 0,
                };
                for (var x in streamSnapshot.data.docs[1]['talang_pertama']) {
                  if (x == 0) {
                    dataTalangPertama['baik']++;
                  } else if (x == 1) {
                    dataTalangPertama['cukup']++;
                  } else if (x == 2) {
                    dataTalangPertama['sangat_baik']++;
                  }
                }

                Map dataTalangKedua = {
                  'baik': 0,
                  'sangat_baik': 0,
                  'cukup': 0,
                };
                for (var x in streamSnapshot.data.docs[0]['talang_kedua']) {
                  if (x == 0) {
                    dataTalangKedua['baik']++;
                  } else if (x == 1) {
                    dataTalangKedua['cukup']++;
                  } else if (x == 2) {
                    dataTalangKedua['sangat_baik']++;
                  }
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kualitas Tanaman Selada",
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
                          Image.asset(
                            "assets/hari_tanam_ic.png",
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hari Tanam',
                                style: labelText,
                              ),
                              Text(
                                hariTanam.toString(),
                                style: labelText,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (datePanen != null)
                          ? history(
                              'assets/usia_ic.png',
                              'Perkiraan Masa Panen',
                              DateFormat('d MMM ').format(datePanen))
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boxKualitas('A1',
                              streamSnapshot.data.docs[1]['talang_pertama'][0]),
                          boxKualitas('A2',
                              streamSnapshot.data.docs[1]['talang_pertama'][1]),
                          boxKualitas('A2',
                              streamSnapshot.data.docs[1]['talang_pertama'][2]),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('A : Talang Pertama Hidroponik'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boxKualitas('B1',
                              streamSnapshot.data.docs[0]['talang_kedua'][0]),
                          boxKualitas('B2',
                              streamSnapshot.data.docs[0]['talang_kedua'][1]),
                          boxKualitas('B3',
                              streamSnapshot.data.docs[0]['talang_kedua'][2]),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('B : Talang Kedua Hidroponik'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Cukup Baik',
                            style: labelText.copyWith(color: mainColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.green.withOpacity(0.5),
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Baik',
                            style: labelText.copyWith(color: mainColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: mainColor,
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Sangat Baik',
                            style: labelText.copyWith(color: mainColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Prediksi Jumlah Kualitas',
                            style: labelText,
                          ),
                          Spacer(),
                          Text(
                            'Total',
                            style: labelText,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "A : " +
                                dataTalangPertama['cukup'].toString() +
                                " " +
                                dataTalangPertama['baik'].toString() +
                                " " +
                                dataTalangPertama['sangat_baik'].toString(),
                            style: labelText,
                          ),
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Cukup Baik : ' +
                                (dataTalangPertama['cukup'] +
                                        dataTalangKedua['cukup'])
                                    .toString(),
                            style: labelText.copyWith(color: mainColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "B : " +
                                dataTalangKedua['cukup'].toString() +
                                " " +
                                dataTalangKedua['baik'].toString() +
                                " " +
                                dataTalangKedua['sangat_baik'].toString(),
                            style: labelText,
                          ),
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.green.withOpacity(0.5),
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Baik: ' +
                                (dataTalangPertama['baik'] +
                                        dataTalangKedua['baik'])
                                    .toString(),
                            style: labelText.copyWith(color: mainColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: mainColor,
                                border: Border.all(
                                    color: mainColor.withOpacity(0.7))),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Sangat Baik : ' +
                                (dataTalangPertama['sangat_baik'] +
                                        dataTalangKedua['sangat_baik'])
                                    .toString(),
                            style: labelText.copyWith(color: mainColor),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
