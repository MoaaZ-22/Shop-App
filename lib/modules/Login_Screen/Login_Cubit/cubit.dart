// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Login_Screen/Login_Cubit/states.dart';

import '../../../models/Login_Model/shop_login_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../login_screen.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super(ShopInitialLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  // Onboarding Screen Controller
  var boardController = PageController();

  // Boolean For Boarding Screen
  bool isLast = false;

  // Controller For Email In login Screen
  var loginEmailController = TextEditingController();

  // Controller For Email In Register Screen
  var loginPasswordController = TextEditingController();

  // Login Show Password
  bool isTrue = true;



  // Validation Function For Email
  String? emailValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
    {
      return 'Please enter a valid email address';
    }
    return null;

  }

  // Validation Function For Email
  String? passwordValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value.trim().length < 6)
    {
      return 'Password must be at least 8 characters in length';
    }
    return null;

  }


  // Function For Show And Hide Password In Login Screen
  void showPasswordLoginScreen()
  {
    isTrue = !isTrue;
    emit(ShowPasswordShopLoginScreen());
  }

  // List Of All Model
  List<BoardingModel> boarding =
  [
    const BoardingModel(boardingTitle: 'We Make it much easier for u!', boardingImage: 'assets/images/Online.svg', boardingBody: 'Save your efforts,book and visit all you want from your place'),
    const BoardingModel(boardingTitle: 'You can see places differently', boardingImage: 'assets/images/images.svg', boardingBody: 'Show places with more reality and you can add your review'),
    const BoardingModel(boardingTitle: 'Enjoy with Event Section', boardingImage: 'assets/images/Events.svg', boardingBody: 'Browse our latest event and select Which one will you attend?'),
  ];


  // // Object From Shop Login Model
  ShopLoginModel? shopLoginModel;

  // Function For Post Login Data In Apis
  void userLogin({required String email, required String password}){

    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email' : email,
          'password': password
        }).then((value)
    {

      // Object For Modle Fill it With Data From Post Cuz Validation On Api Response
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      // print(ShopLoginModel?.message);
      // print(ShopLoginModel?.token);

      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error)
    {
      emit(ShopLoginErrorState(error: error.toString()));
      print(error.toString());
    });
  }


  // // Method For Save In cache To Skip OnBoarding Screen When User Open
  void submit(BuildContext context)
  {
    CacheHelper.saveData(key: 'Onboarding', value: true).then((value) =>
    {
      pushReplacementNavigate(context, const ShopLoginScreen())
    }
    );

  }


}