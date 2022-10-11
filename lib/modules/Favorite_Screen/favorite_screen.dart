// ignore_for_file: sized_box_for_whitespace, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null && cubit.getFavoritesModel!.data != null ,
            builder: (context) {
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {return buildFavItem(cubit.getFavoritesModel!.data!.data![index], context);},
                  separatorBuilder: (BuildContext context, int index) => myDivider(),
                  itemCount: cubit.getFavoritesModel!.data!.data!.length);
            },
            fallback: (context) => Center(child: Text('No Favorites Item...',style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',color: defaultColor),),));
      },
      listener: (context, state) {

      },
    );
  }
}


