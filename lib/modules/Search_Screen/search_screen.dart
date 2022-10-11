// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icons.dart';
import 'Search_Cubit/cubit.dart';
import 'Search_Cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => ShopSearchCubit(),
        child: BlocConsumer<ShopSearchCubit, ShopSearchStates>
          (
          builder: (context, state)
          {
            TextEditingController? searchController = TextEditingController();
            GlobalKey<FormState> searchFormKey =  GlobalKey<FormState>(debugLabel: 'SearchKey');
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: defaultColor,
              ),
              body: Form(
                key: searchFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      searchTextFormFiled
                        (textLabel: 'Search', hintLabel: 'Search', textInputType: TextInputType.text, prefixIcon: IconlyBroken.search, controller: searchController,
                        validator: (value)
                          {
                            if(value!.isEmpty)
                              {
                                return 'Enter Text To Search';
                              }
                            return '';
                          },
                        onSubmitted: (String text)
                          {
                            ShopSearchCubit.get(context).search(text);
                            print('$text *********************');
                          }
                      ),
                      const SizedBox(height: 10,),
                      if(state is ShopLoadingSearchDataState)
                        LinearProgressIndicator(color: defaultColor),
                      const SizedBox(height: 10,),
                      if(state is ShopSuccessSearchDataState)
                      Expanded(
                        child: ListView.separated(
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {return buildSearchItem(ShopSearchCubit.get(context).searchModel!.data!.data![index], context);},
                            separatorBuilder: (BuildContext context, int index) => myDivider(),
                            itemCount: ShopSearchCubit.get(context).searchModel!.data!.data!.length),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state){},
        ),
    );
  }
}
