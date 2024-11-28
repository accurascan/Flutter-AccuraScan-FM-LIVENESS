import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_accurascan_fm_liveness/flutter_accurascan_fm_liveness.dart';

void main() {
  runApp(const MaterialApp(
    home: FaceMatch(),
    debugShowCheckedModeBanner: false,
  ));
}

class FaceMatch extends StatefulWidget {
  const FaceMatch({Key? key}) : super(key: key);

  @override
  State<FaceMatch> createState() => _FaceMatchState();
}

class _FaceMatchState extends State<FaceMatch> {
  dynamic _result = {'isValid': false};
  String facematchURI = '';
  String facematchURI2 = '';
  String Score = "0";

  Future<void> openGallery() async {
    try {
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };

      await AccuraFacematch.getGallery1([accuraConfs])
          .then((value) => {
                setState(() {
                  _result = json.decode(value);
                  facematchURI = _result["Image"];
                  if (_result.toString().contains("score")) {
                    Score = _result["score"];
                  }
                  print("RESULT:- $_result");
                })
              })
          .onError((error, stackTrace) => {});
    } on PlatformException {}
    if (!mounted) return;
  }

  Future<void> openGallery2() async {
    try {
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };
      await AccuraFacematch.getGallery2([accuraConfs])
          .then((value) => {
                setState(() {
                  _result = json.decode(value);
                  facematchURI2 = _result["Image"];
                  if (_result.toString().contains("score")) {
                    Score = _result["score"];
                  }
                  print("RESULT:- $_result");
                })
              })
          .onError((error, stackTrace) => {});
    } on PlatformException {}
    if (!mounted) return;
  }

  Future<void> openCamera() async {
    try {
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };
      await AccuraFacematch.setFaceMatchFeedbackTextSize(18);
      await AccuraFacematch.setFaceMatchFeedBackframeMessage("Frame Your Face");
      await AccuraFacematch.setFaceMatchFeedBackAwayMessage("Move Phone Away");
      await AccuraFacematch.setFaceMatchFeedBackOpenEyesMessage(
          "Keep Your Eyes Open");
      await AccuraFacematch.setFaceMatchFeedBackCloserMessage(
          "Move Phone Closer");
      await AccuraFacematch.setFaceMatchFeedBackCenterMessage(
          "Move Phone Center");
      await AccuraFacematch.setFaceMatchFeedbackMultipleFaceMessage(
          "Multiple Face Detected");
      await AccuraFacematch.setFaceMatchFeedBackFaceSteadymessage(
          "Keep Your Head Straight");
      await AccuraFacematch.setFaceMatchFeedBackLowLightMessage(
          "Low light detected");
      await AccuraFacematch.setFaceMatchFeedBackBlurFaceMessage(
          "Blur Detected Over Face");
      await AccuraFacematch.setFaceMatchFeedBackGlareFaceMessage(
          "Glare Detected");
      await AccuraFacematch.setFaceMatchBlurPercentage(80);
      await AccuraFacematch.setFaceMatchGlarePercentage_0(-1);
      await AccuraFacematch.setFaceMatchGlarePercentage_1(-1);

      await AccuraFacematch.getCamera1([accuraConfs]).then((value) => {
            setState(() {
              _result = json.decode(value);
              facematchURI = _result["Image"];
              if (_result.toString().contains("score")) {
                Score = _result["score"];
              }
              print("RESULT:- $_result");
            })
          });
    } on PlatformException {}
    if (!mounted) return;
  }

  Future<void> openCamera2() async {
    try {
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };

      await AccuraFacematch.setFaceMatchFeedbackTextSize(18);
      await AccuraFacematch.setFaceMatchFeedBackframeMessage("Frame Your Face");
      await AccuraFacematch.setFaceMatchFeedBackAwayMessage("Move Phone Away");
      await AccuraFacematch.setFaceMatchFeedBackOpenEyesMessage(
          "Keep Your Eyes Open");
      await AccuraFacematch.setFaceMatchFeedBackCloserMessage(
          "Move Phone Closer");
      await AccuraFacematch.setFaceMatchFeedBackCenterMessage(
          "Move Phone Center");
      await AccuraFacematch.setFaceMatchFeedbackMultipleFaceMessage(
          "Multiple Face Detected");
      await AccuraFacematch.setFaceMatchFeedBackFaceSteadymessage(
          "Keep Your Head Straight");
      await AccuraFacematch.setFaceMatchFeedBackLowLightMessage(
          "Low light detected");
      await AccuraFacematch.setFaceMatchFeedBackBlurFaceMessage(
          "Blur Detected Over Face");
      await AccuraFacematch.setFaceMatchFeedBackGlareFaceMessage(
          "Glare Detected");
      await AccuraFacematch.setFaceMatchBlurPercentage(80);
      await AccuraFacematch.setFaceMatchGlarePercentage_0(-1);
      await AccuraFacematch.setFaceMatchGlarePercentage_1(-1);

      await AccuraFacematch.getCamera2([accuraConfs]).then((value) => {
            setState(() {
              _result = json.decode(value);
              facematchURI2 = _result["Image"];
              if (_result.toString().contains("score")) {
                Score = _result["score"];
              }
              print("RESULT:- $_result");
            })
          });
    } on PlatformException {}
    if (!mounted) return;
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
        title: const Text('Accura Face Match'),
        backgroundColor: Colors.red[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                facematchURI != ''
                    ? Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        height: 160,
                        width: MediaQuery.of(context).size.width - 10,
                        child: Image.file(
                          new File(facematchURI.replaceAll("file:///", '')),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
                        height: 160,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/placeholder.png"),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              child: Image(
                                  image: AssetImage("assets/images/icon.png")),
                            ),
                            SizedBox(width: 5),
                            Text("Upload Face Image"),
                          ],
                        )),
                      ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ), backgroundColor: Colors.red[800],
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 32, left: 32)),
                        onPressed: () {
                          openCamera();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              child: Image(
                                  image: AssetImage("assets/images/cam.png")),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                facematchURI2 != ''
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 160,
                        width: MediaQuery.of(context).size.width - 10,
                        child: Image.file(
                          new File(facematchURI2.replaceAll("file:///", '')),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
                        height: 160,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/placeholder.png"),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              child: Image(
                                  image: AssetImage("assets/images/icon.png")),
                            ),
                            SizedBox(width: 5),
                            Text("Upload Face Image"),
                          ],
                        )),
                      ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ), backgroundColor: Colors.red[800],
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 32, left: 32)),
                        onPressed: () {
                          openCamera2();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              child: Image(
                                  image: AssetImage("assets/images/cam.png")),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 10,
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "MatchScore: $Score%",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Available in Mobile and Web SDK / API \n Try it now",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
