part of 'posts_bloc.dart';

abstract class PostsEvent {
  const PostsEvent();
}

class PostsInitialFetchEvent extends PostsEvent {
  const PostsInitialFetchEvent();
}

class PostAddedEvent extends PostsEvent {}
