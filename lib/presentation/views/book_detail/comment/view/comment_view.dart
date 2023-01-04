import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/comment_repository.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/views/book_detail/comment/cubit/comment_cubit.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/comment_input.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/message_item.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key, required this.userDocId, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController msgController = TextEditingController();
    final CommentRepository commentRepository =
        CommentRepository(firestore: context.read<FirebaseFirestore>());
    return BlocProvider(
      create: (context) => CommentCubit(commentRepository: commentRepository)
        ..getComments(bookId: bookId),
      child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height * 0.85,
            child: state.status == Status.loading
                ? Column(
                    children: [
                      closeItem(),
                      const Spacer(),
                      const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      const Spacer(),
                    ],
                  )
                : Column(
                    children: [
                      closeItem(),
                      Expanded(
                        child: state.userComments.isEmpty
                            ? const NoBookItem()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                itemBuilder: (context, index) => MessageItem(
                                  showUserName: index == 0
                                      ? true
                                      : state.userComments[index - 1]
                                              .commentModel.userDocId !=
                                          state.userComments[index].commentModel
                                              .userDocId,
                                  userComment: state.userComments[index],
                                  isUser: state.userComments[index].userModel
                                          .docId ==
                                      userDocId,
                                ),
                                itemCount: state.userComments.length,
                              ),
                      ),
                      CommentInput(
                        msgController: msgController,
                        onSend: () {
                          if (msgController.text != '') {
                            commentRepository.addComment(
                              commentModel: CommentModel(
                                createdAt: DateTime.now().toString(),
                                id: '',
                                message: msgController.text.trim(),
                                userDocId: userDocId,
                              ),
                              bookId: bookId,
                            );
                            msgController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  final String userDocId;
  final String bookId;

  Widget closeItem() => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Row(
          children: [
            const Spacer(),
            Container(
              width: 50.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: ColorConst.c979797,
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
