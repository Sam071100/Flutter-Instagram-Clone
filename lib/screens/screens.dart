// A bare file is just a file that exports multiple files. As there will be multiple screens so it will become complicated if we import all of them.
//Instead of which we can use bare file where we will list all the screens and this file will be exporting it based on the need.
//And in the main.dart we have to just import this screen.dart file instead of all the screens which saves lots of time and make the debugging of the code easier.

export 'splash/splash_screen.dart';
export 'login/login_screen.dart';
export 'nav/nav_screen.dart';
export 'signup/signup_screen.dart';
export 'feed/feed_screen.dart';
export 'search/search_screen.dart';
export 'create_post/create_post_screen.dart';
export 'notifications/notifications_screen.dart';
export 'profile/profile_screen.dart';
export 'edit_profile/edit_profile_screen.dart';
export 'comments/comments_screen.dart';
