import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/desktop/top_navigation_bar_admin_desktop.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/desktop/top_navigation_bar_scientist_desktop.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/desktop/top_navigation_bar_user_desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../routing/route_names.dart';

// different TopNavigationBar for admin, scientist and user

class TopNavigationBarDesktop extends StatelessWidget {
  const TopNavigationBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
        context); // creating an instance of authProvider

    bool currentRouteIsAdmin = false;
    bool currentRouteIsUser = false;
    bool currentRouteIsScientist = false;

    // checking if an admin, an user or a scientist page is the currentRoute and then set the specific bool value to true
    Navigator.popUntil(context, (currentRoute) {
      if (currentRoute.settings.name == RegristrationScientistRoute ||
          currentRoute.settings.name == RegristrationAdminRoute ||
          currentRoute.settings.name == DashboardRoute ||
          currentRoute.settings.name == UsersAdministrationRoute) {
        currentRouteIsAdmin = true;
      }
      if (currentRoute.settings.name == RegristrationScientistRoute ||
          currentRoute.settings.name == UsersScientistRoute) {
        currentRouteIsScientist = true;
      }
      if (currentRoute.settings.name == InformationRoute ||
          currentRoute.settings.name == NeuigkeitenRoute ||
          currentRoute.settings.name == AuthenticationPageRoute ||
          currentRoute.settings.name == RegristrationUserRoute ||
          currentRoute.settings.name == ForgotPasswordRoute) {
        currentRouteIsUser = true;
      }
      // Return true so popUntil() pops nothing.
      return true;
    });

    final user = FirebaseAuth.instance.currentUser;

    // current user exist
    if (user != null) {
      // print('user is logged in ' + currentUserEmail2);

      // specific bool value for user is true and role is user, then create the user TopNavigationBar for user
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for user displayed
      if (currentRouteIsUser == true &&
          authProvider.status == Status.Unauthenticated) {
        return const TopNavigationBarUserDesktop();
      } else {
        if (authProvider.status == Status.Unauthenticated) {
          return const TopNavigationBarUserDesktop();
        }
      }

      // specific bool value for admin is true and role is admin, then create the user TopNavigationBar for admin
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for admin displayed
      if (currentRouteIsAdmin == true && authProvider.status == Status.Admin) {
        return const TopNavigationBarAdminDesktop();
      } else {
        if (authProvider.status == Status.Admin) {
          return const TopNavigationBarAdminDesktop();
        }
      }

      // specific bool value for scientist is true and role is scientist, then create the user TopNavigationBar for scientist
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for scientist displayed
      print('test1');
      print(authProvider.status);
      if (currentRouteIsScientist == true &&
          authProvider.status == Status.Scientist) {
        print('test2');
        print(authProvider.status);
        return const TopNavigationBarScientistDesktop();
      } else {
        print('test3');
        print(authProvider.status);
        if (authProvider.status == Status.Scientist) {
          return const TopNavigationBarScientistDesktop();
        }
      }

      // no user is logged in - currentUser not exist
    } else {
      print('user not logged in');
      return const TopNavigationBarUserDesktop();
    }
    //default
    print('test4');
    return const TopNavigationBarUserDesktop();
  }
}
