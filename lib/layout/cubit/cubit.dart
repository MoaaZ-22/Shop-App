// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Home_Screen/home_screen.dart';
import '../../models/Categories_Model/categories_model.dart';
import '../../models/Favorites_Model/favorites_model.dart';
import '../../models/Favorites_Model/get_favorites_model.dart';
import '../../models/Home_Model/home_model.dart';
import '../../models/Update_Model/update_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../modules/Categories_Screen/categories_screen.dart';
import '../../modules/Favorite_Screen/favorite_screen.dart';
import '../../modules/Settings_Screen/settings_screen.dart';
import '../../shared/components/consts.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/styles/icons.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopInitialAppState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // Bottom Nav Bar Items -Home Layout-
  List<BottomNavigationBarItem> bottomNavBarItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
        icon: Icon(IconlyBroken.category), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(IconlyBroken.solid_heart), label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(IconlyBroken.setting), label: 'Settings')
  ];

  List<Widget> shopHomeLayoutScreens =
  [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  Map<int, bool>? favorites = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products!) {
        favorites!.addAll({
          element.id!: element.inFavorites!,
        });
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesDataModel() {
    emit(ShopGetCategoriesLoadingsDataState());

    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(categoriesModel!.data!.data);
      // print(categoriesModel!.data);
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopGetCategoriesErrorState());
      // print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void changeFavorites(int productId) {
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES,
        data:
        {
          'product_id': productId
        },
        token: token)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status!) {
        favorites![productId] = !favorites![productId]!;
      }
      else
        {
          getFavoritesDataModel();
        }
      emit(ShopChangeFavoritesSuccessState(favoritesModel!));
    }).catchError((error) {
      emit(ShopChangeFavoritesErrorState());
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void getFavoritesDataModel() {
    emit(ShopGetFavoritesLoadingState());

    DioHelper.getData(url: GET_FAVORITES, token: token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      // printFullText(getFavoritesModel!.data.toString());
      // print(getFavoritesModel!.data!.data![0]);

      emit(ShopGetFavoritesSuccessState(getFavoritesModel!));
    }).catchError((error) {
      emit(ShopGetFavoritesErrorState());
      print(error.toString());
    });
  }
  // Profile In Setting
  ProfileModel? userModel;
  // Profile In Setting
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: GET_PROFILE, token: token).then((value) {
      userModel = ProfileModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print(error.toString());
    });
  }
  // Profile In Setting
  UpdateModel? updateUserModel;
  // Profile In Setting
  void updateUserData({required String name, required String email, required String phone}) {
    emit(ShopUpdateProfileLoadingState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data:
        {
          'name' : name,
          'email' : email,
          'phone' : phone,
        }
    ).then((value) {
      updateUserModel = UpdateModel.fromJson(value.data);
      print(updateUserModel!.data!.name);
      emit(ShopUpdateProfileSuccessState(updateUserModel!));
    }).catchError((error) {
      emit(ShopUpdateProfileErrorState());
      print(error.toString());
    });
  }
}
