import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.comment,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Stack(
        children: [
          Align(
            alignment: isUser ? Alignment.topRight : Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                right: isUser ? 16.w : 0,
                left: !isUser ? 16.w : 0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.jm().format(DateTime.parse(comment.createdAt)),
                      style: PoppinsFont.w400.copyWith(
                        fontSize: 14.sp,
                        color: ColorConst.blackWithOpacity063,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: !isUser
                              ? ColorConst.cE5E5E5
                              : ColorConst.c8875FF),
                      child: Text(
                        comment.message,
                        style: PoppinsFont.w600.copyWith(
                          fontSize: 16.sp,
                          color: isUser
                              ? ColorConst.white
                              : ColorConst.blackWithOpacity087,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final CommentModel comment;
  final bool isUser;
}
