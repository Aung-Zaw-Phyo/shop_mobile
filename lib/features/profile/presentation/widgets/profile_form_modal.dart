import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_event.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_state.dart';
import 'package:shop_mobile/features/profile/presentation/pages/profile_screen.dart';
import 'package:shop_mobile/features/profile/presentation/widgets/image_input.dart';

class ProfileFormModal extends StatefulWidget {
  final ProfileEntity profile;
  const ProfileFormModal({super.key, required this.profile});

  @override
  State<ProfileFormModal> createState() => ProfileFormModalState();
}

class ProfileFormModalState extends State<ProfileFormModal> {
  final _form = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  var enteredName = '';
  var enteredEmail = '';
  File? selectedImage;
  bool isSubmit = false;

  void submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      BlocProvider.of<UpdateProfileBloc>(context).add(UpdateProfile(
        name: enteredName,
        email: enteredEmail,
        image: selectedImage,
      ));
      isSubmit = true;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void showMessage(String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('name'),
                    initialValue: widget.profile.name,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      enteredName = newValue!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const Key('email'),
                    initialValue: widget.profile.email,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.trim().length < 5 ||
                          !value.trim().contains('@')) {
                        return "Please enter your valid email.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ImageInput(onPickImage: (image) {
                    selectedImage = image;
                  }),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                        builder: (context, state) {
                          String buttonContext = 'Update';
                          if (state is UpdateProfileLoading && isSubmit) {
                            buttonContext = 'Loading ...';
                          }
                          if (state is UpdateProfileFailed && isSubmit) {
                            isSubmit = false;
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              error(context, state.errors[0]);
                            });
                          }
                          if (state is UpdateProfileLoaded && isSubmit) {
                            isSubmit = false;
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context)
                                  .pushNamed(ProfileScreen.routeName);
                            });
                          }
                          return Text(
                            buttonContext,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 20,
                                ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
