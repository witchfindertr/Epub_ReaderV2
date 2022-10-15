import 'dart:convert';
import 'dart:typed_data';
import 'package:t1t1/view_model/home_view_model.dart';
import 'package:epub_view/epub_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context
        .select((HomeViewModel homeViewModel) => homeViewModel.isLoading);
    List<EpubBook> epubListBook = context.read<HomeViewModel>().epubListBook;
    return !isLoading
        ? GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return _ItemBody(index: index);
            },
            itemCount: epubListBook.length,
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.green,
          ));
  }
}

class _ItemBody extends StatefulWidget {
  const _ItemBody({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<_ItemBody> createState() => _ItemBodyState();
}

class _ItemBodyState extends State<_ItemBody> {
  List<EpubByteContentFile>? epubByteContentFile;
  List? images;

  @override
  void initState() {
    super.initState();

    epubByteContentFile = context
        .read<HomeViewModel>()
        .epubListBook[widget.index]
        .Content
        ?.Images
        ?.values
        .toList();
    images = epubByteContentFile?.map((e) => e.Content).toList();
  }

  Future<void> openEpub() async {
    EpubViewer.setConfig(

        themeColor: Colors.green,
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.HORIZONTAL,
        allowSharing: true,
        );

    // EpubViewer.locatorStream.listen((locator) {
    //   print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
    // });
  // EpubViewer.open('/storage/emulated/0/Download/1.epub');
    await EpubViewer.openAsset(
      context.read<HomeViewModel>().epubsPath[widget.index].toString(),
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openEpub();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54,
            image: images == null
                ? null
                : DecorationImage(
                    fit: BoxFit.fill,
                    image: MemoryImage(Uint8List.fromList(
                        images?.length == 1 ? images![0] : images![1])))),
      ),
    );
  }
}
