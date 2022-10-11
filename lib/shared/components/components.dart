// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/cubit/cubit.dart';
import '../../models/Categories_Model/categories_model.dart';
import '../../models/Favorites_Model/get_favorites_model.dart';
import '../../models/Home_Model/home_model.dart';
import '../../models/Search_Model/search_model.dart';
import '../../modules/Login_Screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import '../styles/colors.dart';
import '../styles/icons.dart';

// Class Model For Onboarding Screen
class BoardingModel {
  final String boardingTitle;
  final String boardingImage;
  final String boardingBody;

  const BoardingModel(
      {required this.boardingTitle,
        required this.boardingImage,
        required this.boardingBody});
}

// Onboarding Build Item
Widget buildOnboardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: SvgPicture.asset(model.boardingImage)),
    const SizedBox(
      height: 30.0,
    ),
    Text(
      model.boardingTitle,
      style: const TextStyle(
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.w800,
          fontSize: 22.0),
    ),
    const SizedBox(height: 15),
    Text(
      model.boardingBody,
      style: const TextStyle(
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.w800,
          fontSize: 13.0),
    ),
    const SizedBox(
      height: 35.0,
    ),
  ],
);

// Flutter Toast Components
Future<bool?> showToast({required String message, required ToastStates state}) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// For Choose Color Of Toast
enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

// Function For Navigate To Other Screens And Cant Return
void pushReplacementNavigate(context, dynamic widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

class ReusableShopLogin extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final Function()? suffixFunc;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;

  const ReusableShopLogin(
      {Key? key,
        required this.hintText,
        this.suffixIcon,
        this.prefixIcon,
        this.suffixFunc,
        this.keyBoardType,
        this.onChanged,
        required this.isPassword,
        this.validator,
        required this.labelText,
        this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isPassword,
        onChanged: onChanged,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIconColor: defaultColor,
          prefixIconColor: defaultColor,
          suffixIcon: suffixIcon != null
              ? IconButton(
              onPressed: suffixFunc,
              icon: Icon(
                suffixIcon,
                color: defaultColor,
                size: 19,
              ))
              : null,
          contentPadding: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
          disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
          border: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        ),
      ),
    );
  }
}

class ReusableShopButton extends StatelessWidget {
  final double buttonRadius;
  final double height;
  final double? elevation;
  final double? leftPadding;
  final double? rightPadding;
  final Color? colorOfButton;
  final String buttonTextOS;
  final VoidCallback buttonFuncOS;
  final TextStyle? textButtonStyleOS;

  const ReusableShopButton(
      {Key? key,
        required this.buttonRadius,
        required this.height,
        this.colorOfButton,
        required this.buttonTextOS,
        required this.buttonFuncOS,
        this.textButtonStyleOS,
        this.elevation, required this.leftPadding, required this.rightPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: leftPadding!, right: rightPadding!),
        width: double.infinity,
        height: height,
        child: MaterialButton(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          onPressed: buttonFuncOS,
          color: colorOfButton,
          child: Text(buttonTextOS, style: textButtonStyleOS),
        ));
  }
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void signOut(context)
{
  CacheHelper.removeUserData(key: 'token').then((value)
  {
    if (value!)
      {
        navigateAndFinish(context , const ShopLoginScreen());
        ShopAppCubit.get(context).currentIndex = 0;
      }
  });
}

Widget circularProIndicator() => Center(
  child:   SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(color: defaultColor, strokeWidth: 6,),
  ),
);

Widget homeProductBuildItem(HomeModel homeModel,CategoriesModel categoriesModel, context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // مهم ركز هنا
        CarouselSlider(
            items: homeModel.data!.banners!
                .map((e) => Image(
                width: double.infinity,
                fit: BoxFit.fill,
                image: NetworkImage('${e.image}')))
                .toList(),
            options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal)),
        const SizedBox(
          height: 6.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 28,color: defaultColor,fontFamily: 'Montserrat'),),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return buildCategoryItem(categoriesModel.data!.data![index]);
                    }, separatorBuilder: (BuildContext context,int index) => const SizedBox(width: 8,),
                    itemCount: categoriesModel.data!.data!.length),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('New Products',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 28,color: defaultColor,fontFamily: 'Montserrat'),),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // معناه ان الشاشه هتبقي مقسومه ل جزئين او صفين من الصور بس
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.63,
            children: List.generate(
                homeModel.data!.products!.length,
                    (index) =>
                    homeProductBuildGridView(homeModel.data!.products![index], context)),
          ),
        )
      ],
    ),
  );
}

Widget homeProductBuildGridView(ProductsM model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                height: 200,

                width: double.infinity,
                image: NetworkImage(model.image!)),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.all(5),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 8.0, color: Colors.white),
                ),
              )
          ],
        ),
        const SizedBox(height: 3,),
        Padding(
          padding: const EdgeInsets.only(left: 13.0,right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 1.3),
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  Text(
                    '${model.price!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: defaultColor, fontSize: 14.0, height: 1.3),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.oldPrice != 0)
                    Text(
                      '${model.oldPrice!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          height: 1.3,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),

                  IconButton(
                      onPressed: ()
                      {
                        // print(model.id);
                        ShopAppCubit.get(context).changeFavorites(model.id!);
                      },
                      padding: const EdgeInsets.only(left: 18),
                      icon:  CircleAvatar(
                        backgroundColor: ShopAppCubit.get(context).favorites![model.id]! ? defaultColor :Colors.grey, // defaultColor
                        radius: 15.0,
                        child: const Icon(IconlyBroken.heart,color: Colors.white,size: 19.0,)
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

//Build Cat Item In Home Screen
Widget buildCategoryItem(DataModel dataModel) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          image: NetworkImage(dataModel.image!)),
      Container(
        width: 100,
        color: Colors.green.withOpacity(0.8),
        child: Text(
          dataModel.name!,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
      )
    ],
  );
}

// Build Cat Item In Category Screen
Widget buildCatItemScreen(DataModel dataModel) {
  return Padding(padding: const EdgeInsets.only(left: 10,right: 20,top: 20,bottom: 20),
    child: Row(children:
    [
      Image(
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
          image: NetworkImage(dataModel.image!)),
      const SizedBox(width: 15,),
      Text(dataModel.name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: defaultColor,fontFamily: 'Montserrat'),),
      const Spacer(),
      IconButton(
        icon: Icon(IconlyBroken.arrow_right_2,color: defaultColor,size: 25,),
        onPressed: () {  },
      )

    ],),);
}


Widget defaultTextFormFiled
    ({
  TextEditingController? controller,
  TextInputType? textInputType,
  String? Function(String?)? validator,
  String? textLabel,
  String? hintLabel,
  IconData? prefixIcon,
})
{
  return TextFormField
    (
    controller: controller,
    keyboardType: textInputType,
    validator: validator,

    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(26),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        border: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        label: Text(textLabel!,),
        hintText: hintLabel,
        prefixIcon: Icon(prefixIcon,color: defaultColor,)

    ),
  );
}

void navigateTo(context, dynamic widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

Widget searchTextFormFiled
    ({
  TextEditingController? controller,
  TextInputType? textInputType,
  String? Function(String?)? validator,
  String? textLabel,
  String? hintLabel,
  IconData? prefixIcon,
  void Function(String)? onSubmitted,
})
{
  return TextFormField
    (
    controller: controller,
    keyboardType: textInputType,
    validator: validator,
    onFieldSubmitted: onSubmitted,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(26),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        border: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor,width: 2)),
        label: Text(textLabel!,),
        hintText: hintLabel,
        prefixIcon: Icon(prefixIcon,color: defaultColor,)

    ),
  );
}

// Favorites List In Favorites Screen And Search items In Search Screen

Widget buildFavItem(FavoritesData favoritesData, context, {bool isOldPrice = true})
{
  return Container(
    padding: const EdgeInsets.all(14),
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  height: 200,
                  width: double.infinity,
                  image: NetworkImage(favoritesData.product!.image!)),
              if (favoritesData.product!.discount != 0 && isOldPrice)
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.red.withOpacity(0.8),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 3,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 13.0,right: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(favoritesData.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      favoritesData.product!.price!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: defaultColor, fontSize: 14.0, height: 1.3),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (favoritesData.product!.oldPrice != 0)
                    Text(
                      favoritesData.product!.oldPrice!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          height: 1.3,
                          decoration: TextDecoration.lineThrough),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          print(favoritesData.product!.id!);
                          ShopAppCubit.get(context).changeFavorites(favoritesData.product!.id!);
                        },
                        padding: const EdgeInsets.only(left: 18),
                        icon: CircleAvatar(
                            backgroundColor: ShopAppCubit.get(context).favorites![favoritesData.product!.id]! ? defaultColor : Colors.grey, // defaultColor
                            radius: 15.0,
                            child: const Icon(IconlyBroken.heart,color: Colors.white,size: 19.0,)
                        ))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildSearchItem(SearchProduct searchProduct, context, {bool isOldPrice = true})
{
  return Container(
    padding: const EdgeInsets.all(14),
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  height: 200,
                  width: double.infinity,
                  image: NetworkImage(searchProduct.image!)),
              if (searchProduct.discount != 0 && isOldPrice == true)
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.red.withOpacity(0.8),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 3,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 13.0,right: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(searchProduct.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      searchProduct.price!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: defaultColor, fontSize: 14.0, height: 1.3),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (searchProduct.oldPrice != 0 && isOldPrice == false)
                      Text(
                        searchProduct.oldPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            height: 1.3,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          print(searchProduct.id!);
                          ShopAppCubit.get(context).changeFavorites(searchProduct.id!);
                        },
                        padding: const EdgeInsets.only(left: 18),
                        icon: CircleAvatar(
                            backgroundColor: ShopAppCubit.get(context).favorites![searchProduct.id]! ? defaultColor : Colors.grey, // defaultColor
                            radius: 15.0,
                            child: const Icon(IconlyBroken.heart,color: Colors.white,size: 19.0,)
                        ))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}