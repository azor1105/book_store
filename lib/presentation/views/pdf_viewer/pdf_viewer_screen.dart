import 'dart:io';
import 'package:book_store/data/models/book/book_model.dart';
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
  @override
  void initState() {
    super.initState();
    _pdfViewerKey = GlobalKey();
    _pdfViewerController = PdfViewerController();
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
              key: _pdfViewerKey,
              controller: _pdfViewerController,
              pageLayoutMode: PdfPageLayoutMode.single,
            )
          : SfPdfViewer.file(
              File(widget.bookPath!),
              key: _pdfViewerKey,
              controller: _pdfViewerController,
              pageLayoutMode: PdfPageLayoutMode.single,
            ),
    );
  }
}
