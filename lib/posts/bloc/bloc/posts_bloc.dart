import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/posts/models/post_data_ui_model.dart';
import 'package:todo_bloc/repo/post_repo.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddedEvent>(postAddedEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    var client = http.Client();

    List<PostDataUiModel> posts = await PostRepo.fetchPosts();

    emit(PostFetchingSuccessfulState(posts: posts));

    // try {
    //   var response = await client.get(
    //     Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    //   );

    //   List result = jsonDecode(response.body);

    //   for (int i = 0; i < result.length; i++) {
    //     PostDataUiModel post =
    //         PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);

    //     posts.add(post);
    //   }
    //   print(posts);

    //   emit(PostFetchingSuccessfulState(posts: posts));
    //   // print(response.body);
    // } catch (e) {
    //   emit(PostFetchingErrorState());
    //   log(e.toString());
    // }
  }

  FutureOr<void> postAddedEvent(
      PostAddedEvent event, Emitter<PostsState> emit) async {
    bool success = await PostRepo.addPost();

    print(success);
    if (success) {
      emit(PostAdditionSuccessState());
    } else {
      emit(PostAdditionErrorState());
    }
  }
}
