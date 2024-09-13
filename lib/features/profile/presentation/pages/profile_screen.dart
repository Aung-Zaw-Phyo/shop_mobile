import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:shop_mobile/features/profile/presentation/widgets/profile_form_modal.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(const GetProfile());
    super.initState();
  }

  void editProfileForm(ProfileEntity profile) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (ctx) => ProfileFormModal(profile: profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, ProductsScreen.routeName);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileFailed) {
              return Center(
                child: Text(state.errors[0]),
              );
            }

            if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(state.profile.image),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.profile.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        state.profile.email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          editProfileForm(state.profile);
                        },
                        child: const Text('Edit Profile'),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
