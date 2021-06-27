import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/blocs/auth/auth_bloc.dart';
import 'package:instagram_clone/config/custom_router.dart';
import 'package:instagram_clone/enums/enums.dart';
import 'package:instagram_clone/repositories/repositories.dart';
import 'package:instagram_clone/screens/create_post/cubit/create_post_cubit.dart';
import 'package:instagram_clone/screens/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/screens/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/screens/screens.dart';
import 'package:instagram_clone/screens/search/cubit/search_cubit.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, intialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[intialRoute](context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGeneratedNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            postRepository: context.read<PostRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(FeedFetchPosts()),
          child: FeedScreen(),
        );
        break;
      case BottomNavItem.search:
        return BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(userRepository: context.read<UserRepository>()),
          child: SearchScreen(),
        );
        break;
      case BottomNavItem.create:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
            postRepository: context.read<PostRepository>(),
            storageRepository: context.read<StorageRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
          child: CreatePostScreen(),
        );
        break;
      case BottomNavItem.notifications:
        return NotificationsScreen();
        break;
      case BottomNavItem.profile:
        return BlocProvider(
          create: (_) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              postRepository: context.read<PostRepository>(),
              authBloc: context.read<AuthBloc>())
            ..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user.uid),
            ),
          child: ProfileScreen(),
        );
        break;
      default:
        return Scaffold();
    }
  }
}
