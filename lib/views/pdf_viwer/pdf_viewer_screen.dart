import 'dart:io';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/my_icons.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  final String bookName;

  const PDFViewerPage({
    Key? key,
    required this.bookName,
    required this.file,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              MyIcons.arrowBackIcon,
              color: MyColors.black,
            ),
          ),
        ),
        title: Text(
          widget.bookName,
          style: MyFonts.w400.copyWith(fontSize: 15.sp),
        ),
        actions: pages >= 2
            ? [
                Center(
                    child: Text(
                  text,
                  style: MyFonts.w300.copyWith(
                    fontSize: 14.sp,
                  ),
                )),
                const SizedBox(width: 10),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}
