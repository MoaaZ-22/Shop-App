import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icons.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? nameController = TextEditingController();
    TextEditingController? emailController = TextEditingController();
    TextEditingController? phoneController = TextEditingController();
    return BlocConsumer<ShopAppCubit, ShopAppStates>
      (builder: (context, state)
    {

      var profileModel = ShopAppCubit.get(context).userModel!;
      GlobalKey<FormState> settingFormKey =  GlobalKey<FormState>(debugLabel: 'SettingUpdate');


      nameController.text = profileModel.data!.name!;
      emailController.text = profileModel.data!.email!;
      phoneController.text = profileModel.data!.phone!;

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 8.0,right: 8.0),
          child: Form(
            key: settingFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                defaultTextFormFiled
                  (
                    controller: nameController,
                    prefixIcon: IconlyBroken.profile,
                    textInputType: TextInputType.name,
                    textLabel: 'Name',
                    hintLabel: nameController.text,
                ),
                const SizedBox(height: 20,),
                defaultTextFormFiled
                  (
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    textInputType: TextInputType.emailAddress,
                    textLabel: 'Email',
                    hintLabel: emailController.text,
                ),
                const SizedBox(height: 20,),
                defaultTextFormFiled
                  (
                    controller: phoneController,
                    prefixIcon: IconlyBroken.call,
                    textInputType: TextInputType.name,
                    textLabel: 'Phone',
                    hintLabel: phoneController.text,
                ),
                const SizedBox(height: 20,),
                ReusableShopButton(
                  leftPadding: 0,
                  rightPadding: 0,
                  buttonRadius:6,
                  elevation: 3,
                  textButtonStyleOS:const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Montserrat'
                  ),
                  colorOfButton: defaultColor,
                  height: 55,
                  buttonTextOS: 'UPDATE',
                  buttonFuncOS: (){
                    if (settingFormKey.currentState!.validate())
                      {
                        ShopAppCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                      }
                  },
                ),
                const SizedBox(height: 15,),
                ReusableShopButton(
                  leftPadding: 0,
                  rightPadding: 0,
                  buttonRadius:6,
                  elevation: 3,
                  textButtonStyleOS:const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Montserrat'
                  ),
                  colorOfButton: defaultColor,
                  height: 55,
                  buttonTextOS: 'SIGN OUT',
                  buttonFuncOS: (){
                    signOut(context);
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
        listener: (context, state)
        {
          if (state is ShopUpdateProfileSuccessState)
            {
              ShopAppCubit.get(context).getUserData();
            }
          else if (state is ShopUpdateProfileErrorState)
            {
              showToast(message: ShopAppCubit.get(context).updateUserModel!.message!, state: ToastStates.error);
            }
        }
    );
  }
}

