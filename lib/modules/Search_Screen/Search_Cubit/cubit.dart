// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Search_Screen/Search_Cubit/states.dart';
import '../../../models/Search_Model/search_model.dart';
import '../../../shared/components/consts.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit() : super(ShopInitialSearchState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text)
  {
    emit(ShopLoadingSearchDataState());

    DioHelper.postData(url: SEARCH,token: token, data:
    {
    'text' : text,
    })
        .then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchDataState());
      print(searchModel!.data!.data!.length);
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorSearchDataState());
    }
    );
  }
}