# Flutter Accura Scan FaceMatch And Liveness

Accura Scan OCR is used for Optical character recognition.

Accura Scan Face Match is used for Matching 2 Faces, Source face and Target face. It matches the
User Image from a Selfie vs User Image in document.

Accura Scan Authentication is used for your customer verification and authentication. Unlock the
True Identity of Your Users with 3D Selfie Technology

Below steps to setup Accura Scan's SDK to your project.

## Note:-

Add `flutter_accurascan_fm_liveness` under dependencies in your pubspec.yaml file.
**Usage**
Import flutter library into file.
`import 'package:flutter_accurascan_fm_liveness/flutter_accurascan_fm_liveness.dart';`

## 1.Setup Android

**Add this permissions into Android’s AndroidManifest.xml file.**

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
```

**Add it in your root build.gradle at the end of repositories.**

```
allprojects {
   repositories {
       google()
       jcenter()
       maven {
           url 'https://jitpack.io'
           credentials { username 'jp_ssguccab6c5ge2l4jitaj92ek2' }
       }    
    }
}
```

**Add it in your app/build.gradle file.**

```
packagingOptions {
   pickFirst 'lib/arm64-v8a/libcrypto.so'
   pickFirst 'lib/arm64-v8a/libssl.so'
   
   pickFirst 'lib/armeabi-v7a/libcrypto.so'
   pickFirst 'lib/armeabi-v7a/libssl.so'
   
   pickFirst 'lib/x86/libcrypto.so'
   pickFirst 'lib/x86/libssl.so'
   
   pickFirst 'lib/x86_64/libcrypto.so'
   pickFirst 'lib/x86_64/libssl.so'
   
}
```

## 2.Setup iOS

1.Install Git LFS using command install `git-lfs`

2.Run `pod install`

**Add this permissions into iOS Info.plist file.**

```
<key>NSCameraUsageDescription</key>
<string>App usage camera for scan documents.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>App usage photos for get document picture.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>App usage photos for save document picture.</string>
```

## 3.Setup Accura Scan licenses into your projects

**accuraface.license**

This license is use for get face match percentages between two face pictures.

**For Android**

```
Create "assets" folder under app/src/main and Add license file in to assets folder.
- accuraface.license // for Accura Scan Face Match
Generate your Accura Scan license from https://accurascan.com/developer/dashboard
```

**For iOS**

```
Place the license in your project's Runner directory, and add the licenses to the target.
```

## 4.Method for liveness check.

   ```
Future<void> startLiveness() async{
 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
 try{
   var accuraConfs = {
     "face_uri":this.faceMatchURL             //Pass an empty string if you only need liveness score else pass the face image path to get a facematch score also.
   };

      await AccuraLiveness.setLivenessFeedbackTextSize(18);
      await AccuraLiveness.setLivenessFeedBackframeMessage("Frame Your Face");
      await AccuraLiveness.setLivenessFeedBackAwayMessage("Move Phone Away");
      await AccuraLiveness.setLivenessFeedBackOpenEyesMessage("Keep Your Eyes Open");
      await AccuraLiveness.setLivenessFeedBackCloserMessage("Move Phone Closer");
      await AccuraLiveness.setLivenessFeedBackCenterMessage("Move Phone Closer");
      await AccuraLiveness.setLivenessFeedbackMultipleFaceMessage("Multiple Face Detected");
      await AccuraLiveness.setLivenessFeedBackFaceSteadymessage("Keep Your Head Straight");
      await AccuraLiveness.setLivenessFeedBackBlurFaceMessage("Blur Detected Over Face");
      await AccuraLiveness.setLivenessFeedBackGlareFaceMessage("Glare Detected");
      await AccuraLiveness.setLivenessBlurPercentage(80);
      await AccuraLiveness.setLivenessGlarePercentage_0(-1);
      await AccuraLiveness.setLivenessGlarePercentage_1(-1);
      await AccuraLiveness.setLivenessFeedBackLowLightMessage("Low light detected");
      await AccuraLiveness.setLivenessfeedbackLowLightTolerence(39);
      await AccuraLiveness.setLivenessURL("You Liveness Url");



      await AccuraLiveness.startLiveness([accuraConfs])
       .then((value) => {
     setState((){
       dynamic result = json.decode(value);
     })
   }).onError((error, stackTrace) => {
   });
 }on PlatformException{}
}
```

## 10.Method for Only Facematch.

### To Open Gallery 1 and 2:-

_For gallery 1_

   ```
  Future<void> openGallery() async{
    try{
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };

      await AccuraOcr.getGallery1([accuraConfs]).then((value) => {
        setState(() {
          _result = json.decode(value);
          facematchURI = _result["Image"];
          if(_result.toString().contains("score")){
            Score = _result["score"];
          }
          print("RESULT:- $_result");
        })
      }).onError((error, stackTrace)=>{});
    } on PlatformException {}
    if(!mounted) return;
  }
```

_For gallery 2_

```
  Future<void> openGallery2() async{
    try{
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };
      await AccuraOcr.getGallery2([accuraConfs]).then((value) => {
        setState(() {
          _result = json.decode(value);
          facematchURI2 = _result["Image"];
          if(_result.toString().contains("score")){
            Score = _result["score"];
          }
          print("RESULT:- $_result");
        })
      }).onError((error, stackTrace)=>{});
    } on PlatformException {}
    if(!mounted) return;
  }
```

### To Open Camera for Facematch 1 and 2:

_For Facematch 1:_

```
  Future<void> openCamera() async{
    try{
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };
      await AccuraFacematch.setFaceMatchFeedbackTextSize(18);
      await AccuraFacematch.setFaceMatchFeedBackframeMessage("Frame Your Face");
      await AccuraFacematch.setFaceMatchFeedBackAwayMessage("Move Phone Away");
      await AccuraFacematch.setFaceMatchFeedBackOpenEyesMessage("Keep Your Eyes Open");
      await AccuraFacematch.setFaceMatchFeedBackCloserMessage("Move Phone Closer");
      await AccuraFacematch.setFaceMatchFeedBackCenterMessage("Move Phone Center");
      await AccuraFacematch.setFaceMatchFeedbackMultipleFaceMessage("Multiple Face Detected");
      await AccuraFacematch.setFaceMatchFeedBackFaceSteadymessage("Keep Your Head Straight");
      await AccuraFacematch.setFaceMatchFeedBackLowLightMessage("Low light detected");
      await AccuraFacematch.setFaceMatchFeedBackBlurFaceMessage("Blur Detected Over Face");
      await AccuraFacematch.setFaceMatchFeedBackGlareFaceMessage("Glare Detected");
      await AccuraFacematch.setFaceMatchBlurPercentage(80);
      await AccuraFacematch.setFaceMatchGlarePercentage_0(-1);
      await AccuraFacematch.setFaceMatchGlarePercentage_1(-1);

      await AccuraFacematch.getCamera1([accuraConfs]).then((value) => {
        setState(() {
          _result = json.decode(value);
          facematchURI = _result["Image"];
          if(_result.toString().contains("score")){
            Score = _result["score"];
          }
          print("RESULT:- $_result");
        })
      });
    } on PlatformException {}
    if(!mounted) return;
  }
```

_For Facematch 2_

```
  Future<void> openCamera2() async{
    try{
      var accuraConfs = {
        "face1": this.facematchURI,
        "face2": this.facematchURI2
      };

      await AccuraFacematch.setFaceMatchFeedbackTextSize(18);
      await AccuraFacematch.setFaceMatchFeedBackframeMessage("Frame Your Face");
      await AccuraFacematch.setFaceMatchFeedBackAwayMessage("Move Phone Away");
      await AccuraFacematch.setFaceMatchFeedBackOpenEyesMessage("Keep Your Eyes Open");
      await AccuraFacematch.setFaceMatchFeedBackCloserMessage("Move Phone Closer");
      await AccuraFacematch.setFaceMatchFeedBackCenterMessage("Move Phone Center");
      await AccuraFacematch.setFaceMatchFeedbackMultipleFaceMessage("Multiple Face Detected");
      await AccuraFacematch.setFaceMatchFeedBackFaceSteadymessage("Keep Your Head Straight");
      await AccuraFacematch.setFaceMatchFeedBackLowLightMessage("Low light detected");
      await AccuraFacematch.setFaceMatchFeedBackBlurFaceMessage("Blur Detected Over Face");
      await AccuraFacematch.setFaceMatchFeedBackGlareFaceMessage("Glare Detected");
      await AccuraFacematch.setFaceMatchBlurPercentage(80);
      await AccuraFacematch.setFaceMatchGlarePercentage_0(-1);
      await AccuraFacematch.setFaceMatchGlarePercentage_1(-1);

      await AccuraFacematch.getCamera2([accuraConfs]).then((value) => {
        setState(() {
          _result = json.decode(value);
          facematchURI2 = _result["Image"];
          if(_result.toString().contains("score")){
            Score = _result["score"];
          }
          print("RESULT:- $_result");
        })
      });
    } on PlatformException {}
    if(!mounted) return;
  }
```

**accuraConfs:** JSON Object

**Face1:** 'uri of face1'

**Face2:** ’uri of face2’

**Success:** JSON Response {

**Image:** URI?,

**score:** String,}

**Error:** String

Contributing See the contributing guide to learn how to contribute to the repository and the
development workflow.

License:
MIT
