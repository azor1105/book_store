import 'package:book_store/cubits/comment/comment_cubit.dart';
import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/comment_repository.dart';
import 'package:book_store/presentation/views/book_detail/comment/widgets/comment_input.dart';
import 'package:book_store/presentation/views/book_detail/comment/widgets/message_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(5.sp),
                          itemBuilder: (context, index) => MessageItem(
                            comment: state.comments[index],
                            isUser:
                                state.comments[index].userDocId == userDocId,
                          ),
                          itemCount: state.comments.length,
                        ),
                      ),
                      CommentInput(
                        msgController: msgController,
                        onSend: () {
                          if (msgController.text != '') {
                            commentRepository.addComment(
                              CommentModel(
                                createdAt: DateTime.now().toString(),
                                id: '',
                                message: msgController.text.trim(),
                                userDocId: userDocId,
                                bookId: bookId,
                              ),
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
}
