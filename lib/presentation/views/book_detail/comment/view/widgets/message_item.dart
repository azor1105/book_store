import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/views/book_detail/comment/cubit/comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.userComment,
    required this.isUser,
    required this.showUserName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            !isUser ? photoItem() : const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Stack(
                children: [
                  Align(
                    alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: isUser ? 7.w : 0,
                        left: !isUser ? 7.w : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.jm().format(
                              DateTime.parse(
                                  userComment.commentModel.createdAt),
                            ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isUser && showUserName)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.h),
                                    child: Text(
                                      userComment.userModel.fullName,
                                      style: PoppinsFont.w600.copyWith(
                                        fontSize: 15.sp,
                                        color: isUser
                                            ? ColorConst.white
                                            : ColorConst.blackWithOpacity087,
                                      ),
                                    ),
                                  ),
                                Text(
                                  userComment.commentModel.message,
                                  maxLines: 100,
                                  style: PoppinsFont.w400.copyWith(
                                    fontSize: 15.sp,
                                    color: isUser
                                        ? ColorConst.white
                                        : ColorConst.blackWithOpacity087,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isUser ? photoItem() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  final UserCommentModel userComment;
  final bool isUser;
  final bool showUserName;

  Widget photoItem() => userComment.userModel.photoUrl != ''
      ? CircleAvatar(
          radius: 15.r,
          backgroundImage: NetworkImage(userComment.userModel.photoUrl),
          backgroundColor: Colors.transparent,
        )
      : Image.asset(
          MyIcons.profileDefaultImg,
          height: 30.h,
        );
}
