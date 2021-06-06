import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/enums/enums.dart';
import 'package:instagram_clone/screens/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:instagram_clone/screens/nav/widgets/widgets.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  // we want the Nav screen to slide over the splash screen so instead of using material page route we have to use the Page Route builder in order to make the screen appear on top of the splash screen
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavBarCubit>(
        create: (_) => BottomNavBarCubit(),
        child: NavScreen(),
      ),
    );
  }

  final Map<BottomNavItem, IconData> items = const {
    BottomNavItem.feed: Icons.home,
    BottomNavItem.search: Icons.search,
    BottomNavItem.create: Icons.add,
    BottomNavItem.notifications: Icons.favorite_border,
    BottomNavItem.profile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
            body: Text('Nav Screen'),
            bottomNavigationBar: BottomNavBar(
              items: items,
              // to store the selecteditems using cubit
              selectedItem: state.selectedItem,
              onTap: (index) {
                final selectedItem = BottomNavItem.values[index];
                context
                    .read<BottomNavBarCubit>()
                    .updateSelectedItem(selectedItem);
              },
            ),
          );
        },
      ),
    );
  }
}
