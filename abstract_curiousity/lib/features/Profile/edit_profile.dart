//

import 'package:abstract_curiousity/features/Profile/bloc/profile_bloc.dart';
import 'package:abstract_curiousity/features/Profile/services/profile_repository.dart';
import 'package:abstract_curiousity/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  final String nameOfuser;
  final String bioOfUser;
  const EditProfile(
      {super.key, required this.nameOfuser, required this.bioOfUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileRepository _profileRepository = ProfileRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController bioEditingController = TextEditingController();

  String _name = "";
  String _bio = '';

  void _onNameChanged(String value) {
    setState(() {
      _name = value;
    });
  }

  void _onBioChanged(String value) {
    setState(() {
      _bio = value;
    });
  }

  void getUserData() async {
    CustomUser? _customUser = await _profileRepository.getCurrentNameAndBio();
    _name = _customUser!.name;
    _bio = _customUser.bio!;
    nameEditingController.text = _name;
    bioEditingController.text = _bio;

    nameEditingController.selection =
        TextSelection.collapsed(offset: nameEditingController.text.length);
    bioEditingController.selection =
        TextSelection.collapsed(offset: bioEditingController.text.length);
  }

  void updateUserData() {
    BlocProvider.of<ProfileBloc>(context).add(
      ProfileDataUpdateRequested(
        name: _name,
        context: context,
        bio: _bio,
        email: _firebaseAuth.currentUser!.email!,
      ),
    );
  }

  @override
  void initState() {
    _name = widget.nameOfuser;
    _bio = widget.bioOfUser;
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              updateUserData();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(
                    pageNumber: 3,
                  ),
                ),
                (route) => false,
              );
              // Navigator.of(context).pop();
            },
            child: const Text(
              "Save",
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1648183185045-7a5592e66e9c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2488&q=80",
                ),
              ),
            ),
            CustomTextField(
              controller: nameEditingController,
              hintText: "Enter your Name",
              onPressed: () {
                _onNameChanged(nameEditingController.text);
              },
              fieldType: "small",
            ),
            // CustomTextField(
            //   controller: userNameeditingController,
            //   hintText: "Enter your UserName",
            //   onPressed: () {
            //     _onUserNameChanged(userNameeditingController.text);
            //   },
            // ),
            CustomTextField(
              controller: bioEditingController,
              hintText: "Enter your Bio",
              onPressed: () {
                _onBioChanged(bioEditingController.text);
              },
              fieldType: "long",
            ),
            const Expanded(
              child: SizedBox(
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    required this.fieldType,
  });
  final String hintText;
  final String fieldType;
  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: TextFormField(
        maxLength: (fieldType == "long") ? 150 : 60,
        onChanged: (value) => onPressed(),
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.4),
          ),
          counterText: (fieldType == "long")
              ? "${controller.text.length.toString()}/150"
              : "",
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
        ),
        cursorColor: Colors.grey[100],
      ),
    );
  }
}
