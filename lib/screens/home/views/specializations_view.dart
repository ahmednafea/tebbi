import 'package:flutter/material.dart';
import 'package:tebbi/blocs/specialization/specialization_bloc/specialization_bloc.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/models/specialization_data_response_model.dart';
import 'package:tebbi/repositories/specializations_repository.dart';
import 'package:tebbi/screens/home/views/specialization_doctors_view.dart';

class SpecializationsView extends StatefulWidget {
  const SpecializationsView({super.key});

  @override
  State<SpecializationsView> createState() => _SpecializationsViewState();
}

class _SpecializationsViewState extends State<SpecializationsView> {
  bool isLoading = true;
  SpecializationDataResponse? specializationDataResponse;

  @override
  void initState() {
    super.initState();
    SpecializationBloc(SpecializationsRepository())
      ..add(SpecializationStarted())
      ..stream.listen((SpecializationState state) {
        if (state is SpecializationLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is SpecializationSuccess) {
          setState(() {
            isLoading = false;
            specializationDataResponse = state.data;
          });
        } else if (state is SpecializationFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to get Specializations data.'),
            ),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
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
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Text(
                    'Specializations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Specializations list
                Expanded(
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : specializationDataResponse == null
                      ? Center(child: Text("We have an error!"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: specializationDataResponse!.data!.length,
                          itemBuilder: (context, index) {
                            final specialization =
                                specializationDataResponse!.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SpecializationDoctorsView(
                                          specialization: specialization
                                              .toMap(),
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      offset: const Offset(-4, -4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      specialization.name ?? "name",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
