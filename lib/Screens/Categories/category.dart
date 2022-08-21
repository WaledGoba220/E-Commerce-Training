// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce_training/Screens/category_details/category_details.dart';
import 'package:e_commerce_training/cubit/cubit.dart';
import 'package:e_commerce_training/cubit/state.dart';
import 'package:e_commerce_training/model/category/category_model.dart';
import 'package:e_commerce_training/shared/componnetns/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => CatList(
              MainCubit.get(context).categoriesModel.data.data[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: MainCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget CatList(DataModel model, context) => InkWell(
        onTap: () {
          MainCubit.get(context).getCategoriesDetailData(model.id);
          navigateTo(context, CategoryProductsScreen(model.name));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                model.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
        ),
      );
}
