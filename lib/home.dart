import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class contoh2 extends StatefulWidget {
  const contoh2({Key? key}) : super(key: key);

  @override
  State<contoh2> createState() => _contoh2State();
}


class _contoh2State extends State<contoh2> {
  late StreamSubscription _streamSubscription;
  final Stream _stream = Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });
  int percent = 100;
  int getSteam = 0;
  double circular = 1.0; // Ubah nama variabel yang sebelumnya "double circular 1;" menjadi "double circular = 1.0;"


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          final double avaWidth = constraints.maxWidth;
          final double avaHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CircularPercentIndicator(
                  radius: avaHeight / 5,
                  lineWidth: 10,
                  percent: circular,
                  center: Text("$percent %"),
                ),
                ),
            ],
          ); // Column
        }),
      ), // LayoutBuilder // Center
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _streamSubscription = _stream.listen((event) {
            getSteam = int.parse(event.toString());
            setState(() {
              if (percent - getSteam <= 0) {
                _streamSubscription.cancel();
                percent = 0;
                circular = 0;
              } else {
                percent = percent - getSteam;
                circular = percent / 100;
              }
            });
          });
        },
      ),
    ); // Scaffold
  }
}
