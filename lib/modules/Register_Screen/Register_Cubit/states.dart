import '../../../models/Register_Model/register_model.dart';

abstract class ShopRegisterStates {}

class ShopInitialRegisterState extends ShopRegisterStates {}

// Show Password In Register Screen
class ShowPasswordShopRegisterScreen extends ShopRegisterStates{}

//______________________________________States For Api Login_________________________________//

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{

  final RegisterModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorState({required this.error});
}
