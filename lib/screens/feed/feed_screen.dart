import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/widgets/widgets.dart';

import 'bloc/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';
  const FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  ScrollController _scrollController;

  // To create the Listener
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange &&
            context.read<FeedBloc>().state.status != FeedStatus.paginating) {
          context.read<FeedBloc>().add(FeedPaginatePosts());
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state.status == FeedStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        } else if (state.status == FeedStatus.paginating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(seconds: 1),
              content: const Text(
                'Fetching More Posts, Please Wait...!',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Instagram',
              // textAlign: TextAlign.center,
            ),
            actions: [
              if (state.posts.isEmpty && state.status == FeedStatus.loaded)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () =>
                      context.read<FeedBloc>().add(FeedFetchPosts()),
                ),
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(FeedState state) {
    switch (state.status) {
      case FeedStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
        break;
      default:
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(FeedFetchPosts());
            return true;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = state.posts[index];
              return PostView(post: post, isLiked: false);
            },
          ),
        );
    }
  }
}
