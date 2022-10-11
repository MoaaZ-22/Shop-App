import '../../../models/Login_Model/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopInitialLoginState extends ShopLoginStates {}

// Show Password In Login Screen
class ShowPasswordShopLoginScreen extends ShopLoginStates{}

// Show Password In Register Screen
class ShowPasswordShopRegisterScreen extends ShopLoginStates{}

// Show Password In Register Screen
class ShowConfirmPasswordShopRegister extends ShopLoginStates{}

// OnBoarding Screen Navigate if Is last True
class OnBoardingScreenNavigateTrue extends ShopLoginStates{}

// OnBoarding Screen Cant Navigate if Is last False
class OnBoardingScreenNavigateFalse extends ShopLoginStates{}

//______________________________________States For Api Login_________________________________//

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{

  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState({required this.error});
}
