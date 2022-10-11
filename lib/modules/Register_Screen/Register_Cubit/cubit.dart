// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Register_Screen/Register_Cubit/states.dart';
import '../../../models/Register_Model/register_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopInitialRegisterState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  // Controller For Email In login Screen
  var registerUserNameController = TextEditingController();

  // Controller For Email In login Screen
  var registerEmailController = TextEditingController();

  // Controller For Email In Register Screen
  var registerPasswordController = TextEditingController();

  // Controller For Email In Register Screen
  var registerPhoneController = TextEditingController();

  // Register Show Password
  bool isPasswordShow = true;

  // Function For Show And Hide Password In Register Screen
  void showPasswordRegisterScreen() {
    isPasswordShow = !isPasswordShow;
    emit(ShowPasswordShopRegisterScreen());
  }

  // Validation Function For User Name
  String? userName(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value!.length > 27)
    {
      return 'User name length too much';
    }
    return null;
  }

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
    else if(value.trim().length < 8)
    {
      return 'Password must be at least 8 characters in length';
    }
    return null;

  }

  GlobalKey<FormState> registerFormKey =

  GlobalKey<FormState>(debugLabel: 'Register');

  // Validation Function For Email
  String? phoneValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    return null;
  }


  // // Object From Shop Login Model
  RegisterModel? registerModel;

  // Function For Post Login Data In Apis
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password
  }){

    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'phone':phone,
          'email' : email,
          'password': password
        }).then((value)
    {

      // Object For Modle Fill it With Data From Post Cuz Validation On Api Response
      registerModel = RegisterModel.fromJson(value.data);

      print(registerModel?.message);

      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error: error.toString()));
      print(error.toString());
    });
  }


}
