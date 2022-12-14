// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_training/Screens/category_details/category_details.dart';
import 'package:e_commerce_training/Screens/product_detalis/product_details.dart';
import 'package:e_commerce_training/cubit/cubit.dart';
import 'package:e_commerce_training/cubit/state.dart';
import 'package:e_commerce_training/model/category/category_model.dart';
import 'package:e_commerce_training/model/home/home_model.dart';
import 'package:e_commerce_training/shared/componnetns/components.dart';
import 'package:e_commerce_training/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessStates) {
          if (state.model.status) {
            ShowToast(
              text: state.model.message,
              state: ToastStates.SUCCESS,
            );
          } else {
            ShowToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: MainCubit.get(context).homeModel != null &&
              MainCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              MainCubit.get(context).homeModel,
              MainCubit.get(context).categoriesModel,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: CarouselSlider(
                items: model.data.banners
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage('${e.image}'),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 140.0,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(start: 10.0, top: 10),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoriesItem(
                          categoriesModel.data.data[index], context),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 2,
                    children: List.generate(
                      model.data.products.length,
                      (index) =>
                          GridProducts(model.data.products[index], context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget CategoriesItem(DataModel model, context) => InkWell(
        onTap: () {
          MainCubit.get(context).getCategoriesDetailData(model.id);
          navigateTo(context, CategoryProductsScreen(model.name));
        },
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CircleAvatar(
                  backgroundColor: DColor,
                  radius: 36,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    child: Image(
                      image: NetworkImage(model.image),
                      height: 50.0,
                      width: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(model.name),
          ],
        ),
      );

  Widget GridProducts(ProductModel model, context) => InkWell(
        onTap: () {
          //MainCubit.get(context).getProductData(model.id).then((value)=> navigateTo(context, ProductDetailsScreen(product: model,)));
          MainCubit.get(context)
              .getProductData(model.id)
              .then((value) => navigateTo(context, ProductDetailsScreen()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    color: Colors.red,
                    child: Text(
                      'OFFERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          MainCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          MainCubit.get(context).favorites[model.id]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: MainCubit.get(context).favorites[model.id]
                              ? Colors.red
                              : Colors.grey,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
