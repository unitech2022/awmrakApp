import 'dart:io';

import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../widgets/Buttons.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/text_widget.dart';

class EditMyProfileScreen extends StatefulWidget {
  @override
  State<EditMyProfileScreen> createState() => _EditMyProfileScreenState();
}

class _EditMyProfileScreenState extends State<EditMyProfileScreen> {




  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  File? _file;
  String image="";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        _nameController.text=HomeCubit.get(context).userModel.fullName!;

        _phoneController.text=HomeCubit.get(context).userModel.userName!;


        if (state is PickedImage) {
          _file = state.imagePath;
          HomeCubit.get(context).uploadImage(_file);
        }

        if(state is UploadImageSuccess){
          image = state.imageUpload;
          print("image$image");
        }



        // if(state is UpdateProfileLoad){
        //
        //
        //    Future.delayed(const Duration(seconds: 1),(){
        //      _dialog.show(
        //
        //          width: 100,
        //          height: 100,
        //          message: '', type: SimpleFontelicoProgressDialogType.bullets);
        //    });
        //
        // }
        if(state is UpdateProfileSuccess){


         Future.delayed(Duration.zero,(){
           HelperFunction.slt.notifyUser(context: context,message: state.meassge,color: homeColor);

         });

        }

        return  Scaffold(
                appBar: AppBar(
                  elevation: 0,

                  automaticallyImplyLeading: true,
                  leading: IconButton(onPressed: () {
                    pop(context);

                  }, icon: const Icon(Icons.arrow_back,color:  Colors.white,),

                  ),
                  title: const Text(
                    "تعديل بياناتى",
                    style: TextStyle(color:  Colors.white, fontFamily: "pnuR"),
                  ),
                ),
                body:HomeCubit.get(context).loadUserDetails
                    ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: homeColor,
                  ),
                ):SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    shape: BoxShape.circle),
                                child: _file != null
                                    ?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:  Image.file(_file!, height: 90,
                                    fit: BoxFit.cover,
                                    width: 90,),
                                )


                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: HomeCubit.get(context).userModel.imageUrl != null? baseurlImage +
                                              HomeCubit.get(context).userModel.imageUrl!:"notFound",
                                          height: 90,
                                          fit: BoxFit.cover,
                                          width: 90,
                                          placeholder: (context, url) =>
                                              const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: CircularProgressIndicator(
                                              color: homeColor,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    HelperFunction.slt.showSheet(
                                        context, _selectImage(context));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: homeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            CustomText(
                                family: "pnuB",
                                size: 15,
                                text: "الاسم",
                                textColor: Colors.black,
                                weight: FontWeight.w300,
                                align: TextAlign.center),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormField(
                          headingText: "Email",
                          hintText: "الاسم",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: _nameController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),


                        const SizedBox(
                          height: 20,
                        ),



                        Row(
                          children: const [
                            CustomText(
                                family: "pnuB",
                                size: 15,
                                text: "رقم المحمول",
                                textColor: Colors.black,
                                weight: FontWeight.w300,
                                align: TextAlign.center),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormField(
                          headingText: "Password",
                          maxLines: 1,
                          enable: false,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          hintText: "رقم المحمول",
                          obsecureText: false,
                          suffixIcon: SizedBox(),
                          controller: _phoneController,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        HomeCubit.get(context).loadUpdate?const SizedBox(
                       height: 60,width: 60,
                       child: Center(
                         child: CircularProgressIndicator(
                           strokeWidth: 3,
                           color: homeColor,
                         ),
                       ),
                     )  : CustomButton3(
                            text: "حفظ البيانات",
                            fontFamily: "PNUB",
                            onPress: () {
                             if(image==""){

                               HomeCubit.get(context).updateProfile(
                                 image: "${HomeCubit.get(context).userModel.imageUrl}",
                                 phone: _phoneController.text,
                                 name: _nameController.text
                               ).then((value) {
                                 HomeCubit.get(context).getUserDetails();
                               });
                             }else{
                               HomeCubit.get(context).updateProfile(
                                   image: image,
                                   phone: _phoneController.text,
                                   name: _nameController.text
                               ).then((value){
                                 HomeCubit.get(context).getUserDetails();
                               } );
                             }
                            },
                            redius: 10,
                            color: homeColor,
                            textColor: Colors.white,
                            fontSize: 18,
                            height: 60),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  _selectImage(context) => Container(
        height: 280,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.5),
                  color: const Color(0xFFDCDCDF),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 147,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        pop(context);
                        HomeCubit.get(context)
                            .getImage(context, ImageSource.gallery);
                        // printFunction(image);
                        // AuthProvider.getInItRead(context).updateProfile(context,key: "ImageUrl",value:image);
                      },
                      child: Container(
                        height: 147,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_library_outlined,
                              size: 30,
                              color: homeColor,
                            ),
                            const SizedBox(height: 10),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "اخترصورة",
                                fontFamliy: "pnuL",
                                fontSize: 18,
                                color: textColor.withOpacity(.5))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        pop(context);
                        HomeCubit.get(context)
                            .getImage(context, ImageSource.camera);
                        // String image = await HelperFunction.slt.getImage(
                        //
                        //     context,
                        //    );
                        // AuthProvider.getInItRead(context).updateProfile(context,key: "ImageUrl",value:image);
                        // emitMessage(image+"大"+"0");
                      },
                      child: Container(
                        height: 147,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call,
                              size: 30,
                              color: homeColor,
                            ),
                            const SizedBox(height: 10),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "استخدام الكاميرا",
                                fontFamliy: "pnuL",
                                fontSize: 18,
                                color: textColor.withOpacity(.5))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  updateImageDialog(context) {
    var _image;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            final picker = ImagePicker();
            Future getImage() async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              setState(() {
                if (pickedFile != null) {
                  _image = File(pickedFile.path);
                } else {
                  print('No image selected.');
                }
              });
            }

            return Container(
              color: Colors.white,
              height: 310 + MediaQuery.of(context).viewInsets.bottom,
              padding: const EdgeInsets.all(30),
              child: ListView(
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: _image != null
                        ? Container(
                            height: 120,
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 120),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 120),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/images/file-upload.png",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Buttons(
                      onPressed: () async {
                        if (_image != null) {
                          // String imageUrl =
                          //     await AuthProvider.getInItRead(context)
                          //         .uploadImage(_image, "user",
                          //             currentUser.user.id, context);
                          // AuthProvider.getInItRead(context).updateProfile(
                          //     context,
                          //     key: "ImageUrl",
                          //     value: imageUrl);
                        }
                      },
                      title: "حفظ وتعديل",
                      radius: 10,
                      height: 60,
                      bgColor: homeColor,
                      horizontalMargin: 30,
                      width: double.infinity)
                ],
              ),
            );
          });
        });
  }
}
