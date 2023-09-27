import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class tes2 extends StatefulWidget {
  const tes2({Key? key}) : super(key: key);

  @override
  State<tes2> createState() => _tes2State();
}

class _tes2State extends State<tes2> {
  late StreamSubscription _streamSubscription;
  final Stream _stream = Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  int percent = 100;
  int getSteam = 0;
  double circular = 1.0;
  bool isPlaying = false;

  void playStream() {
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
    setState(() {
      isPlaying = true;
    });
  }

  void stopStream() {
    _streamSubscription.cancel();
    setState(() {
      isPlaying = false;
    });
  }

  void resetStream() {
    setState(() {
      percent = 100;
      circular = 1.0;
    });
  }

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
              SizedBox(height: 20),
              if (percent == 100)
                Text(
                  "Full",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green),
                )
              else if (percent == 0)
                Text(
                  "Empty",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
                ),
            ],
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: isPlaying ? stopStream : playStream,
            child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: resetStream,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
