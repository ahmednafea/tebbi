import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tebbi/configs/app_colors.dart';

import '../../../models/appointment_details_data_response_model.dart';

class AppointmentDetailsView extends StatelessWidget {
  final AppointmentData appointment;

  const AppointmentDetailsView({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctor = appointment.doctor;
    final patient = appointment.patient;

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
                Row(
                  children: const [
                    BackButton(color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Appointment Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      // Doctor Info Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: doctor?.photo ?? "",
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

                          title: Text(
                            doctor?.name ?? "Doctor Name",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${doctor?.specialization?.name ?? ""} | ${doctor?.degree ?? ""}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Patient Info Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          title: Text(patient?.name ?? "Patient Name"),
                          subtitle: Text(patient?.email ?? ""),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Appointment Date/Time Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: const Icon(
                            Icons.calendar_today,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            appointment.appointmentTime != null
                                ? appointment.appointmentTime!
                                : "Not specified",
                          ),
                          subtitle: Text(
                            appointment.appointmentEndTime != null
                                ? "Ends: ${appointment.appointmentEndTime}"
                                : "",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Appointment Status Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            "Status: ${appointment.status?.toUpperCase() ?? "UNKNOWN"}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Notes Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: const Icon(
                            Icons.notes,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            appointment.notes?.isNotEmpty == true
                                ? appointment.notes!
                                : "No notes provided",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Price Card
                      _buildNeumorphicCard(
                        child: ListTile(
                          leading: const Icon(
                            Icons.attach_money,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            "${appointment.appointmentPrice ?? 0} EGP",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeumorphicCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.7),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}
