// A bare file is just a file that exports multiple files. As there will be multiple screens so it will become complicated if we import all of them.
//Instead of which we can use bare file where we will list all the screens and this file will be exporting it based on the need.
//And in the main.dart we have to just import this screen.dart file instead of all the screens which saves lots of time and make the debugging of the code easier.

export 'splash/splash_screen.dart';
