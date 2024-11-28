import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_accurascan_fm_liveness/flutter_accurascan_fm_liveness.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String faceMatchURL = '';
  String matchFileURL = '';
  String livenessScore = '';
  dynamic result = {'isValid': false};

  @override
  void initState() {
    super.initState();
  }

  Future<void> startLiveness() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    try {
      var accuraConfs = {"face_uri": this.faceMatchURL};

      await AccuraLiveness.setLivenessFeedbackTextSize(18);
      await AccuraLiveness.setLivenessFeedBackframeMessage("Frame Your Face");
      await AccuraLiveness.setLivenessFeedBackAwayMessage("Move Phone Away");
      await AccuraLiveness.setLivenessFeedBackOpenEyesMessage(
          "Keep Your Eyes Open");
      await AccuraLiveness.setLivenessFeedBackCloserMessage(
          "Move Phone Closer");
      await AccuraLiveness.setLivenessFeedBackCenterMessage(
          "Move Phone Closer");
      await AccuraLiveness.setLivenessFeedbackMultipleFaceMessage(
          "Multiple Face Detected");
      await AccuraLiveness.setLivenessFeedBackFaceSteadymessage(
          "Keep Your Head Straight");
      await AccuraLiveness.setLivenessFeedBackBlurFaceMessage(
          "Blur Detected Over Face");
      await AccuraLiveness.setLivenessFeedBackGlareFaceMessage(
          "Glare Detected");
      await AccuraLiveness.setLivenessBlurPercentage(80);
      await AccuraLiveness.setLivenessGlarePercentage_0(-1);
      await AccuraLiveness.setLivenessGlarePercentage_1(-1);
      await AccuraLiveness.setLivenessFeedBackLowLightMessage(
          "Low light detected");
      await AccuraLiveness.setLivenessfeedbackLowLightTolerence(39);
      await AccuraLiveness.setLivenessURL("Your URL");

      await AccuraLiveness.startLiveness([accuraConfs])
          .then((value) => {
                setState(() {
                  result = json.decode(value);
                  print("result: $result");
                  matchFileURL = result['detect'].toString();
                  livenessScore = result['score'].toString();
                })
              })
          .onError((error, stackTrace) => {});
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Accura Liveness'),
          backgroundColor: Colors.red[800],
        ),
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_home.png"),
                  fit: BoxFit.cover)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              matchFileURL != ''
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(210, 50, 63, 1))),
                      height: 300,
                      width: 200,
                      child: Image.file(
                        File(matchFileURL.replaceAll('file:///', '')),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ), backgroundColor: Colors.red[800],
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 20, left: 20)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/ic_liveness.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "LIVENESS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    startLiveness();
                  },
                ),
              ),
              Visibility(
                visible: true,
                child: livenessScore != ''
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            double.parse(livenessScore)
                                    .toStringAsFixed(2)
                                    .toString() +
                                "%",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )
                    : Container(),
              )
            ],
          )),
        ),
      ),
    );
  }
}
