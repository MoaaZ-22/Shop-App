// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/consts.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../Register_Screen/register_screen.dart';
import 'Login_Cubit/cubit.dart';
import 'Login_Cubit/states.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);
  @override
  State<ShopLoginScreen> createState() =>
      _ShopLoginScreenState();
}
class _ShopLoginScreenState extends State<ShopLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener:(context, state) {
          if(state is ShopLoginSuccessState)
          {
            if (state.shopLoginModel.message == 'تم تسجيل الدخول بنجاح' || state.shopLoginModel.message == 'Login done successfully')
            {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data?.token);
              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data?.token).then((value) =>
              {
                // token = state.shopLoginModel.data?.token,
                token = CacheHelper.getDataIntoShPre(key: 'token'),
                pushReplacementNavigate(context, const ShopHomeLayout())
              }
              );
            }
            else
            {
              showToast(
                  message: state.shopLoginModel.message!,
                  state:ToastStates.error);
            }
          }
        } ,
        builder: (context, state)
        {
          // Login Screen Form
          GlobalKey<FormState> loginFormKey =  GlobalKey<FormState>(debugLabel: 'Login');
          ShopLoginCubit  cubit = ShopLoginCubit.get(context);
          return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll){
                      overScroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child:
                      Form(
                        key: loginFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('LOGIN',style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, fontFamily: 'Montserrat',color: defaultColor)),
                                  const SizedBox(height: 10,),
                                  const Text('Login now to browse our hot offers',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Montserrat',color: Colors.grey)),
                                  const SizedBox(height: 40,)
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(color: Colors.white),
                              child: Center(
                                child: NotificationListener<OverscrollIndicatorNotification>(
                                  onNotification: (overScroll){
                                    overScroll.disallowIndicator();
                                    return true;
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children:  [
                                      ReusableShopLogin(
                                        controller: cubit.loginEmailController,
                                        labelText: 'Email Address',
                                        hintText: 'Enter Your Email Address',
                                        prefixIcon: const Icon(Icons.email_outlined),
                                        isPassword: false,
                                        keyBoardType: TextInputType.emailAddress,
                                        validator: (value) => cubit.emailValidation(value),
                                      ),
                                      const SizedBox(height: 20,),
                                      ReusableShopLogin(
                                        controller: cubit.loginPasswordController,
                                        isPassword: cubit.isTrue,
                                        prefixIcon: const Icon(Icons.password_sharp),
                                        suffixIcon: Icons.visibility_off_outlined,
                                        suffixFunc: (){cubit.showPasswordLoginScreen();},
                                        labelText: 'Password',
                                        hintText: 'Enter Your Password',
                                        keyBoardType: TextInputType.visiblePassword,
                                        validator: (value) => cubit.passwordValidation(value),
                                      ),
                                      const SizedBox(height: 5,),
                                      // Text ========>>>>>>>>>>>>>> Forget Password?
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30),
                                        child: InkWell(
                                            onTap: (){
                                              // for make sure its works
                                              if (kDebugMode) {
                                                print('its Clickable too');
                                              }
                                            },
                                            child: Text('Forget Password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: defaultColor),)),
                                      ),
                                      const SizedBox(height: 35,),

                                      // Button
                                      ConditionalBuilder(
                                        condition: state is! ShopLoginLoadingState,
                                        builder: (BuildContext context) => ReusableShopButton(
                                          buttonRadius:8,
                                          leftPadding: 20,
                                          rightPadding: 20,
                                          elevation: 3,
                                          textButtonStyleOS:const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Montserrat'
                                          ),
                                          colorOfButton: defaultColor,
                                          height: 55,
                                          buttonTextOS: 'SIGN IN',
                                          buttonFuncOS: (){
                                            if (loginFormKey.currentState!.validate())
                                            {
                                              cubit.userLogin(email: cubit.loginEmailController.text, password: cubit.loginPasswordController.text);
                                            }
                                          },
                                        ),
                                        fallback: (BuildContext context) => SizedBox(
                                          height: 55,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(color: defaultColor,strokeWidth: 5),),
                                        ),

                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(fontSize: 14, color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          //done
                                          InkWell(

                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: defaultColor),
                                            ),
                                            onTap: () {
                                              // Navigate to Register Screen
                                              navigateTo(context, const ShopRegisterScreen());
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 120,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
