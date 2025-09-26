import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tebbi/blocs/search/search_bloc/search_bloc.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/models/doctors_data_response_model.dart';
import 'package:tebbi/repositories/doctor_repository.dart';
import 'package:tebbi/screens/home/views/book_appointment_view.dart';

class DoctorsSearchView extends StatefulWidget {
  const DoctorsSearchView({super.key});

  @override
  State<DoctorsSearchView> createState() => _DoctorsSearchViewState();
}

class _DoctorsSearchViewState extends State<DoctorsSearchView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _cardsAnimation;
  bool isLoading = false, isInitial = true;
  DoctorsDataResponse? doctorsDataResponse;
  late SearchBloc _searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _cardsAnimation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    _searchBloc = SearchBloc(DoctorsRepository())
      ..stream.listen((SearchState state) {
        if (state is SearchLoading) {
          setState(() {
            isLoading = true;
            isInitial = false;
          });
        } else if (state is SearchSuccess) {
          setState(() {
            isLoading = false;
            doctorsDataResponse = state.data;
          });
        } else if (state is SearchFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to get search results, try again.'),
            ),
          );
        }
      });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        _searchBloc.add(SearchStarted(value));
      } else {
        setState(() {
          isInitial = true;
          doctorsDataResponse = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
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
                    'Search Doctors',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Search & filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              offset: const Offset(4, 4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.7),
                              offset: const Offset(-4, -4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search by name",
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.primary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onChanged: (value) => _onSearchChanged(value),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Doctors list
                Expanded(
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                      : doctorsDataResponse == null
                      ? Center(
                          child: Text(
                            isInitial
                                ? "Search for Doctors"
                                : "We have an error!",
                          ),
                        )
                      : doctorsDataResponse!.data!.isEmpty
                      ? Text("No doctors found with this name")
                      : AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: doctorsDataResponse!.data!.length,
                              itemBuilder: (context, index) {
                                final doctor =
                                    doctorsDataResponse!.data![index];
                                return Transform.translate(
                                  offset: Offset(0, _cardsAnimation.value),
                                  child: Opacity(
                                    opacity: _controller.value,
                                    child: _buildDoctorCard(doctor.toMap()),
                                  ),
                                );
                              },
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

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: doctor["photo"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (cxt, txt) => Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (cxt, txt, obj) => Image.asset(
                      "assets/images/specialization_icn.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor["specialization"]["name"],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        "${doctor["degree"]}, ${doctor["gender"]}",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "${doctor["city"]["name"]}, ${doctor["city"]["governrate"]["name"]}",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Text("${doctor["start_time"]} - ${doctor["end_time"]}"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Text("${doctor["appoint_price"]} EGP"),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookAppointmentView(doctorId: doctor["id"]),
                    ),
                  );
                },
                child: const Text("Book Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
