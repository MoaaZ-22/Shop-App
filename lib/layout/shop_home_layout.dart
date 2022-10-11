import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/Search_Screen/search_screen.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/icons.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopHomeLayout extends StatelessWidget {
  const ShopHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener:(context, state) {} ,
        builder: (context, state)
        {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(

              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                children: 
                [
                  Text('Salla',style: TextStyle(color: defaultColor,fontSize: 25,fontFamily: 'JosefinSans',fontWeight: FontWeight.w700),),
                  const SizedBox(width: 5,),
                  Icon(IconlyBroken.buy,color: defaultColor,size: 30,)
                ],
              ),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                }, icon: const Icon(IconlyBroken.search,size: 22,),color: defaultColor,)
              ],
            ),
            body: cubit.shopHomeLayoutScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeCurrentIndex(index);
              },
            ),
          );
        },
    );
  }
}
