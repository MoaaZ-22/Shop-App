import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {return BlocConsumer<ShopAppCubit, ShopAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
            builder: (context) {
              return homeProductBuildItem(ShopAppCubit.get(context).homeModel!, ShopAppCubit.get(context).categoriesModel!,context);
            },
            fallback: (context) => circularProIndicator());
      },
      listener: (context, state) {
        if(state is ShopChangeFavoritesSuccessState)
          {
            if(!state.model.status!)
              {
                showToast(message: state.model.message!, state: ToastStates.error);
              }
          }
      },
    );}
}


