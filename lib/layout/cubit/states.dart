// ignore_for_file: prefer_typing_uninitialized_variables
import '../../models/Favorites_Model/favorites_model.dart';
import '../../models/Favorites_Model/get_favorites_model.dart';
import '../../models/Update_Model/update_model.dart';
import '../../models/User_Model/user_model.dart';

abstract class ShopAppStates {}

class ShopInitialAppState extends ShopAppStates {}

// Change Index NavigationBar
class ShopBottomNavState extends ShopAppStates{}


// ********************************** Get Home Data From Home Model  *****************************************
class ShopLoadingHomeDataState extends ShopAppStates{}

class ShopSuccessHomeDataState extends ShopAppStates{}

class ShopErrorHomeDataState extends ShopAppStates{}
// ********************************** Get Categories Data From Home Model  *****************************************
class ShopGetCategoriesLoadingsDataState extends ShopAppStates{}

class ShopGetCategoriesSuccessState extends ShopAppStates{}

class ShopGetCategoriesErrorState extends ShopAppStates{}
// ********************************** Change Favorites States  *****************************************************
class ShopChangeFavoritesState extends ShopAppStates{}

class ShopChangeFavoritesSuccessState extends ShopAppStates{
   final FavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopAppStates{}
// ********************************** Get Favorites States In Favorites Screen **************************************************
class ShopGetFavoritesLoadingState extends ShopAppStates{}

class ShopGetFavoritesSuccessState extends ShopAppStates{
  final GetFavoritesModel getFavoritesModel;

  ShopGetFavoritesSuccessState(this.getFavoritesModel);
}

class ShopGetFavoritesErrorState extends ShopAppStates{}

// ********************************** Get User Data States In Settings Screen *****************************************************
class ShopLoadingUserDataState extends ShopAppStates{}

class ShopSuccessUserDataState extends ShopAppStates{

  final ProfileModel profileModel;

  ShopSuccessUserDataState(this.profileModel);

}

class ShopErrorUserDataState extends ShopAppStates{}
// ********************************** UPDATE User Data States In Settings Screen *************************************************
class ShopUpdateProfileLoadingState extends ShopAppStates{}

class ShopUpdateProfileSuccessState extends ShopAppStates{

  final UpdateModel updateUserModel;

  ShopUpdateProfileSuccessState(this.updateUserModel);

}

class ShopUpdateProfileErrorState extends ShopAppStates{}