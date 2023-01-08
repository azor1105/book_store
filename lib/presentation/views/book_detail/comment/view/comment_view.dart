import 'dart:math';
import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/comment_repository.dart';
import 'package:book_store/presentation/views/book_detail/comment/cubit/comment_cubit.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/comment_input.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/comment_shimmer_item.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/message_item.dart';
import 'package:book_store/presentation/views/book_detail/comment/view/widgets/no_comment_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/close_item.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key, required this.userDocId, required this.bookId});
  @override
  State<CommentView> createState() => _CommentViewState();

  final String userDocId;
  final String bookId;
}

class _CommentViewState extends State<CommentView> {
  late final TextEditingController msgController;
  final CommentRepository commentRepository =
      CommentRepository(firestore: FirebaseFirestore.instance);

  @override
  void initState() {
    msgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    return BlocProvider(
      create: (context) => CommentCubit(commentRepository: commentRepository)
        ..getComments(bookId: widget.bookId),
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
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          children: List.generate(
                            9,
                            (index) => CommentShimmerItem(
                                width: random.nextInt(90) + 80,
                                isUser: index % 4 == 0),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      closeItem(),
                      Expanded(
                        child: state.userComments.isEmpty
                            ? const NoCommentItem()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                itemBuilder: (context, index) {
                                  return MessageItem(
                                    showDate: index == 0 ||
                                        state.userComments[index].commentModel
                                                .createdAt
                                                .difference(state
                                                    .userComments[index - 1]
                                                    .commentModel
                                                    .createdAt)
                                                .inDays >
                                            0,
                                    showUserName: index == 0
                                        ? true
                                        : state.userComments[index - 1]
                                                .commentModel.userDocId !=
                                            state.userComments[index]
                                                .commentModel.userDocId,
                                    userComment: state.userComments[index],
                                    isUser: state.userComments[index].userModel
                                            .docId ==
                                        widget.userDocId,
                                  );
                                },
                                itemCount: state.userComments.length,
                              ),
                      ),
                      CommentInput(
                        msgController: msgController,
                        onSend: () {
                          if (msgController.text != '') {
                            commentRepository.addComment(
                              commentModel: CommentModel(
                                createdAt: DateTime.now(),
                                id: '',
                                message: msgController.text.trim(),
                                userDocId: widget.userDocId,
                              ),
                              bookId: widget.bookId,
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
}
