import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/viewModel/Profile/cubit.dart';

import '../../viewModel/Profile/states.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMobile = TextEditingController();
  @override
  void dispose() {
    controllerDate.dispose();
    controllerMobile.dispose();
    controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfo(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text("Edit Your Porfile"),
          centerTitle: true,
        ),
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            return ListView(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                          radius: 70,
                          // backgroundImage: !context.read<ProfileCubit>().isPick ?AssetImage(""): NetworkImage(url),
                          child: !context.read<ProfileCubit>().isPick
                              ? CircularProfileAvatar(
                                  radius: 50,
                                  "https://www.tu-ilmenau.de/unionline/fileadmin/_processed_/0/0/csm_Person_Yury_Prof_Foto_AnLI_Footgrafie__2_.JPG_94f12fbf25.jpg")
                              : CircularProfileAvatar(
                                  '',
                                  child: Image.file(
                                    File(context
                                        .read<ProfileCubit>()
                                        .image!
                                        .path),
                                  ),
                                  radius: 50,
                                )),
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: IconButton(
                            onPressed: () {
                              //open The camera
                              context.read<ProfileCubit>().imagePick();
                            },
                            icon: const Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: TextField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Name"),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: TextField(
                      controller: controllerMobile,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Mobile"),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: TextField(
                      controller: controllerDate,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Date of Birth"),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          onPressed: () {
                            context.read<ProfileCubit>().UploadImage(
                                Name: controllerName.text,
                                phone: controllerMobile.text.trim(),
                                date: controllerDate.text);
                          },
                          child: const Text(
                            "Save ",
                            style: TextStyle(fontSize: 20),
                          ))),
                )
              ],
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
