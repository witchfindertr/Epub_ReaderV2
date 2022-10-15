// @dart=2.9

import 'package:t1t1/view_model/home_view_model.dart';
import 'package:t1t1/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

void main() {
  final app = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ],
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // convert app to english to fit with folioreader not work with arabic device
    // go to vocsy_epub_viewer plugin in android folder to set config channel add this code below to fit with arabic devices
    // Resources res = context.getResources();
    // DisplayMetrics dm = res.getDisplayMetrics();
    // android.content.res.Configuration conf = res.getConfiguration();
    // conf.setLocale(new Locale("en")); // API 17+ only.
    // res.updateConfiguration(conf, dm);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      supportedLocales: [const Locale('en')],
      home: const HomeView(),
    );
  }
}

//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:vocsy_epub_viewer/epub_viewer.dart';
// // import 'package:permission_handler/permission_handler.dart';
//
// void main() async {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool loading = false;
//   Dio dio = new Dio();
//   String filePath = "assets/4.epub";
//
//   @override
//   void initState() {
//     super.initState();
//     // download();
//   }
//
//   download() async {
//     if (Platform.isAndroid || Platform.isIOS) {
//       print('download');
//       await downloadFile();
//     } else {
//       loading = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: loading
//               ? CircularProgressIndicator()
//               : FlatButton(
//                   onPressed: () async {
//                     Directory appDocDir =
//                         await getApplicationDocumentsDirectory();
//                     print('$appDocDir');
//
//                     String iosBookPath = '${appDocDir.path}/chair.epub';
//                     print(iosBookPath);
//                     String androidBookPath = 'file:///android_asset/3.epub';
//                     EpubViewer.setConfig(
//                       themeColor: Colors.red,
//                       // identifier: "iosBook",
//                       scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
//                       allowSharing: true,
//                       nightMode: true,
//                     );
//
//                     // get current locator
//                     EpubViewer.locatorStream.listen((locator) {
//                       print(
//                           'LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
//                     });
//
//                     EpubViewer.openAsset(
//                       filePath,
//
//                     );
//
//                     // await EpubViewer.openAsset(
//                     //   'assets/4.epub',
//                     //   lastLocation: EpubLocator.fromJson({
//                     //     "bookId": "2239",
//                     //     "href": "/OEBPS/ch06.xhtml",
//                     //     "created": 1539934158390,
//                     //     "locations": {
//                     //       "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
//                     //     }
//                     //   }),
//                     // );
//                   },
//                   child: Container(
//                     child: Text('open epub'),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
//
//   Future downloadFile() async {
//     print('download1');
//     await startDownload();
//     // if (await Permission.storage.isGranted) {
//     //   await Permission.storage.request();
//     //   await startDownload();
//     // } else {
//     //   await startDownload();
//     // }
//   }
//
//   startDownload() async {
//     Directory? appDocDir = Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationDocumentsDirectory();
//
//     String path = appDocDir!.path + '/chair.epub';
//     File file = File(path);
// //    await file.delete();
//
//     if (!File(path).existsSync()) {
//       await file.create();
//       await dio.download(
//         'https://github.com/FolioReader/FolioReaderKit/raw/master/Example/'
//         'Shared/Sample%20eBooks/The%20Silver%20Chair.epub',
//         path,
//         deleteOnError: true,
//         onReceiveProgress: (receivedBytes, totalBytes) {
//           print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
//           //Check if download is complete and close the alert dialog
//           if (receivedBytes == totalBytes) {
//             loading = false;
//             setState(() {
//               //   filePath = path;
//             });
//           }
//         },
//       );
//     } else {
//       loading = false;
//       setState(() {
//         //    filePath = path;
//       });
//     }
//   }
// }
