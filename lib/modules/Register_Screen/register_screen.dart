import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/consts.dart';
import '../../shared/styles/colors.dart';
import '../Login_Screen/login_screen.dart';
import 'Register_Cubit/cubit.dart';
import 'Register_Cubit/states.dart';



class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: ( context, state) {
          if (state is ShopRegisterSuccessState)
          {
            token = state.registerModel.data?.token!;
            navigateAndFinish(context, const ShopHomeLayout());
          }
        },
        builder: ( context, state) {
          // Register Screen Form
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
                      child: Form(
                        key: cubit.registerFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Register',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: defaultColor)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text('Register now to browse our hot offer',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                            Center(
                                child:Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.04,
                                      ),
                                      ReusableShopLogin(
                                        controller: cubit.registerUserNameController,
                                        labelText: 'User Name',
                                        hintText: 'Enter Your Name',
                                        prefixIcon: Icon(Icons.person,color: defaultColor,),
                                        isPassword: false,
                                        keyBoardType: TextInputType.name,
                                        validator: (value) => cubit.userName(value),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ReusableShopLogin(
                                        controller: cubit.registerEmailController,
                                        labelText: 'Email Address',
                                        hintText: 'Enter Your Email Address',
                                        prefixIcon: Icon(Icons.email_outlined,color: defaultColor,),
                                        isPassword: false,
                                        keyBoardType: TextInputType.emailAddress,
                                        validator: (value) =>
                                            cubit.emailValidation(value),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ReusableShopLogin(
                                        controller: cubit.registerPasswordController,
                                        labelText: "Password",
                                        hintText: 'Enter Your Password',
                                        prefixIcon: Icon(Icons.password_sharp,color: defaultColor,),
                                        suffixIcon: Icons.visibility_off_outlined,
                                        suffixFunc: () {
                                          cubit.showPasswordRegisterScreen();
                                        },
                                        isPassword: cubit.isPasswordShow,
                                        keyBoardType: TextInputType.visiblePassword,
                                        validator: (value) =>
                                            cubit.passwordValidation(value),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ReusableShopLogin(
                                        controller: cubit.registerPhoneController,
                                        labelText: 'Phone',
                                        hintText: 'Enter Your Phone',
                                        prefixIcon: Icon(Icons.phone,color: defaultColor,),
                                        isPassword: false,
                                        keyBoardType: TextInputType.phone,
                                        validator: (value) =>
                                            cubit.passwordValidation(value),
                                      ),

                                      const SizedBox(
                                        height: 40,
                                      ),
                                      // Button
                                      ConditionalBuilder(
                                        condition: state is! ShopRegisterLoadingState,
                                        builder: (BuildContext context) =>
                                            ReusableShopButton(
                                              buttonRadius: 8,
                                              textButtonStyleOS: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Montserrat'),
                                              colorOfButton: defaultColor,
                                              height: 55,
                                              buttonTextOS: 'SIGN UP',
                                              buttonFuncOS: () {
                                                if(cubit.registerFormKey.currentState!.validate())
                                                {
                                                  cubit.userRegister(name: cubit.registerUserNameController.text, email: cubit.registerEmailController.text, password: cubit.registerPasswordController.text, phone: cubit.registerPhoneController.text);
                                                }
                                              }, leftPadding: 20.0, rightPadding: 20.0,
                                            ),
                                        fallback: (BuildContext context) => SizedBox(
                                          height: 55,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                color: defaultColor, strokeWidth: 5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Already have an account',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          //done
                                          InkWell(
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: defaultColor),
                                            ),
                                            onTap: () {
                                              // Navigate to Register Screen
                                              pushReplacementNavigate(context,
                                                  const ShopLoginScreen());
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
