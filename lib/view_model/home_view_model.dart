import 'dart:convert';
import 'dart:typed_data';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<List<int>> epubListUnit = [];
  late EpubController epubReaderController;
  List<EpubBook> epubListBook = [];
  List epubsPath = [];

  loadData() async {
    isLoading = true;
    var assets = await rootBundle.loadString('AssetManifest.json');

    Map allPaths = json.decode(assets);
    epubsPath =
        allPaths.keys.where((element) => element.endsWith(".epub")).toList();
    for (int i = 0; i < epubsPath.length; i++) {
      ByteData audioByteData = await rootBundle.load(epubsPath[i]);
      final Uint8List unit8List = audioByteData.buffer.asUint8List(
          audioByteData.offsetInBytes, audioByteData.lengthInBytes);
      final unitInt = unit8List.cast<int>();
      epubListUnit.add(unitInt);
      epubListBook.add(await EpubReader.readBook(unitInt));
    }

    isLoading = false;
    notifyListeners();
  }
}
