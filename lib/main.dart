// ignore_for_file: deprecated_member_use, avoid_print,

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/consts.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_home_layout.dart';
import 'modules/Login_Screen/Login_Cubit/cubit.dart';
import 'modules/Login_Screen/login_screen.dart';
import 'modules/Onboarding_Screen/onboarding_Screen.dart';
import 'modules/Register_Screen/Register_Cubit/cubit.dart';

main()
async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  // bool to Check If User See onBoarding
  bool? onBoarding = CacheHelper.getDataIntoShPre(key: 'Onboarding');
  print('$token **************************************');
  // Widget To Put The Selected Widget That Will Show
  late Widget widget;
  if(onBoarding != null)
  {
    if(token != null) {
      widget = const ShopHomeLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  }
  else
  {
    widget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(() {runApp(ShopApp(startWidget: widget,));}, blocObserver: ShopBlocObserver(),);

}

class ShopApp extends StatelessWidget {
  final Widget startWidget;
  const ShopApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopAppCubit()..getHomeData()..getCategoriesDataModel()..getFavoritesDataModel()..getUserData(),),
        BlocProvider(create: (BuildContext context) => ShopLoginCubit(),),
        BlocProvider(create: (BuildContext context) => ShopRegisterCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: darkTheme,
      ),
    );
  }
}
