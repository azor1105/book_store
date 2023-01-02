import 'dart:io';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/saved_page_hive/models/saved_page_model.dart';
import 'package:book_store/data/service/hive/saved_page_hive/saved_page_hive.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    super.key,
    required this.bookModel,
    this.bookPath,
  });
  final BookModel bookModel;
  final String? bookPath;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late GlobalKey<SfPdfViewerState> _pdfViewerKey;
  late PdfViewerController _pdfViewerController;
  SavedPageModel? _savedPageModel;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerKey = GlobalKey();
    _pdfViewerController = PdfViewerController();
    _savedPageModel = SavedPageHive.getPage(bookId: widget.bookModel.id);
  }

  @override
  void dispose() {
    if (_savedPageModel == null) {
      SavedPageHive.addPage(
        SavedPageModel(bookId: widget.bookModel.id, page: page),
      );
    } else {
      _savedPageModel!.page = page;
      SavedPageHive.addPage(_savedPageModel!);
    }
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: widget.bookModel.bookName,
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
      body: widget.bookPath == null
          ? SfPdfViewer.network(
              widget.bookModel.bookUrl,
              onDocumentLoaded: (details) {
                if (_savedPageModel != null) {
                  _pdfViewerController.jumpToPage(_savedPageModel!.page);
                }
              },
              key: _pdfViewerKey,
              controller: _pdfViewerController,
              pageLayoutMode: PdfPageLayoutMode.single,
              onPageChanged: (details) {
                page = details.newPageNumber;
              },
            )
          : SfPdfViewer.file(
              File(widget.bookPath!),
              onDocumentLoaded: (details) {
                if (_savedPageModel != null) {
                  _pdfViewerController.jumpToPage(_savedPageModel!.page);
                }
              },
              key: _pdfViewerKey,
              controller: _pdfViewerController,
              pageLayoutMode: PdfPageLayoutMode.single,
              onPageChanged: (details) {
                page = details.newPageNumber;
              },
            ),
    );
  }
}
