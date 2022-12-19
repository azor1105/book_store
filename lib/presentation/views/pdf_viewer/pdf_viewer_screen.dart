import 'dart:io';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key, this.bookModel, this.downloadedBookModel});
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final BookModel? bookModel;
  final DownloadedBookModel? downloadedBookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: bookModel?.bookName ?? downloadedBookModel!.bookName,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.black,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: bookModel != null
          ? SfPdfViewer.network(
              bookModel!.bookUrl,
              key: _pdfViewerKey,
              pageLayoutMode: PdfPageLayoutMode.single,
            )
          : SfPdfViewer.file(
              File(downloadedBookModel!.bookPath),
              key: _pdfViewerKey,
              pageLayoutMode: PdfPageLayoutMode.single,
            ),
    );
  }
}
