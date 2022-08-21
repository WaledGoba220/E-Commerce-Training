// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce_training/cubit/cubit.dart';
import 'package:e_commerce_training/cubit/state.dart';
import 'package:e_commerce_training/shared/componnetns/components.dart';
import 'package:e_commerce_training/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.add_shopping_cart_sharp),
              title: Text("E_Commerce"),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Search,
                    color: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {
                    logOut(context);
                  },
                  icon: Icon(IconBroken.Logout),
                )
              ],
            ),
            body: cubit.pages[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 50.0,
              onTap: (index) {
                cubit.ChangeNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Category,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Bag,
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
