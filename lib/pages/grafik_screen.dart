part of 'pages.dart';

class Grafik extends StatefulWidget {
  const Grafik({Key key}) : super(key: key);

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Grafik Monitoring",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              grafik(),
            ],
          ),
        ),
      ),
    );
  }
}
