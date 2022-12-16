import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:book_store/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key, required this.bookModel});
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bookModel.bookName,
          style: MyFonts.w400.copyWith(fontSize: 15.sp),
        ),
        backgroundColor: MyColors.white,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              MyIcons.arrowBackIcon,
              color: MyColors.black,
              height: 15.h,
            ),
          ),
        ),
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
      body: SfPdfViewer.network(
        bookModel.bookPdfPath,
        key: _pdfViewerKey,
        pageLayoutMode: PdfPageLayoutMode.single,
      ),
    );
  }
}
