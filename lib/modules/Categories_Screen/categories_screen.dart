import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
            builder: (context) {
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCatItemScreen(ShopAppCubit.get(context).categoriesModel!.data!.data![index]);
                  },
                  separatorBuilder: (BuildContext context, int index) => myDivider(),
                  itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data!.length);
            },
            fallback: (context) => circularProIndicator());
      },
      listener: (context, state) {},
    );
  }
}
