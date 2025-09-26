import 'package:flutter/material.dart';
import 'package:tebbi/blocs/authentication/logout_bloc/logout_bloc.dart';
import 'package:tebbi/blocs/user/user_profile_bloc/user_profile_bloc.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/models/profile_data_response_model.dart';
import 'package:tebbi/repositories/authentication_repository.dart';
import 'package:tebbi/repositories/user_repository.dart';
import 'package:tebbi/screens/authentication/auth_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _avatarAnimation;
  late Animation<double> _cardsAnimation;
  late final LogoutBloc _logoutBloc;
  bool isLoading = true;
  ProfileDataResponse? profileDataResponse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _avatarAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _cardsAnimation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _logoutBloc = LogoutBloc(AuthenticationRepository())
      ..stream.listen((LogoutState state) {
        if (state is LogoutLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is LogoutSuccess) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have Logged out successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthScreen()),
          );
        } else if (state is LogoutFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Logout, try again.')),
          );
        }
      });
    UserProfileBloc(UserRepository())
      ..add(UserProfileStarted())
      ..stream.listen((UserProfileState state) {
        if (state is UserProfileLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is UserProfileSuccess) {
          setState(() {
            isLoading = false;
            profileDataResponse = state.data;
          });
        } else if (state is UserProfileFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get user profile data.')),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _logout() {
    _logoutBloc.add(LogoutStarted());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.8),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : profileDataResponse == null
                  ? Center(child: Text("We have an error!"))
                  : Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ScaleTransition(
                          scale: _avatarAnimation,
                          child: CircleAvatar(
                            radius: 50, // smaller than before
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: colorScheme.primary.withValues(
                                alpha: 0.2,
                              ),
                              child: Icon(
                                profileDataResponse?.data?.first.gender ==
                                        "male"
                                    ? Icons.person
                                    : Icons.person_outline,
                                size: 50, // smaller icon
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12), // Reduced spacing
                        Text(
                          profileDataResponse?.data?.first.name ?? "Name",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 30), // Reduced from 40
                        // Animated Cards
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return ListView(
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, _cardsAnimation.value),
                                    child: Opacity(
                                      opacity: _controller.value,
                                      child: _buildInfoTile(
                                        Icons.badge,
                                        "ID",
                                        profileDataResponse!.data!.first.id
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, _cardsAnimation.value),
                                    child: Opacity(
                                      opacity: _controller.value,
                                      child: _buildInfoTile(
                                        Icons.email,
                                        "Email",
                                        profileDataResponse
                                                ?.data
                                                ?.first
                                                .email ??
                                            "Email",
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, _cardsAnimation.value),
                                    child: Opacity(
                                      opacity: _controller.value,
                                      child: _buildInfoTile(
                                        Icons.phone,
                                        "Phone",
                                        profileDataResponse
                                                ?.data
                                                ?.first
                                                .phone ??
                                            "Phone",
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, _cardsAnimation.value),
                                    child: Opacity(
                                      opacity: _controller.value,
                                      child: _buildInfoTile(
                                        profileDataResponse
                                                    ?.data
                                                    ?.first
                                                    .gender ==
                                                "male"
                                            ? Icons.male
                                            : Icons.female,
                                        "Gender",
                                        profileDataResponse
                                                ?.data
                                                ?.first
                                                .gender ??
                                            "female",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // Logout Button
                                  GestureDetector(
                                    onTap: _logout,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.redAccent.withValues(
                                              alpha: 0.4,
                                            ),
                                            offset: const Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-4, -4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
