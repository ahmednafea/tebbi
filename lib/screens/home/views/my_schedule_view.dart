import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/blocs/appointment/appointment_bloc/appointment_bloc.dart';
import 'package:tebbi/models/appointments_data_response_model.dart';
import 'package:tebbi/repositories/appointment_repository.dart';

class MyScheduleView extends StatefulWidget {
  const MyScheduleView({super.key});

  @override
  State<MyScheduleView> createState() => _MyScheduleViewState();
}

class _MyScheduleViewState extends State<MyScheduleView>
    with SingleTickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late AnimationController _controller;
  late Animation<double> _cardsAnimation;

  bool isLoading = true;
  AppointmentDataResponse? appointmentDataResponse;

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

    // Load appointments from bloc/repo
    AppointmentBloc(AppointmentsRepository())
      ..add(AppointmentStarted())
      ..stream.listen((state) {
        if (state is AppointmentLoading) {
          setState(() => isLoading = true);
        } else if (state is AppointmentSuccess) {
          setState(() {
            isLoading = false;
            appointmentDataResponse = state.data;
          });
        } else if (state is AppointmentFailure) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get appointments data.')),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointments = appointmentDataResponse?.data ?? [];

    final Map<String, List<AppointmentData>> groupedAppointments = {};
    for (var appointment in appointments) {
      if (appointment.appointmentTime == null) continue;

      DateTime dateTime = DateFormat(
        "EEEE, MMMM d, yyyy h:mm a",
      ).parse(appointment.appointmentTime!);
      String dateKey = DateFormat("yyyy-MM-dd").format(dateTime);
      groupedAppointments.putIfAbsent(dateKey, () => []).add(appointment);
    }

    final selectedAppointments =
        groupedAppointments[DateFormat(
          "yyyy-MM-dd",
        ).format(_selectedDay ?? _focusedDay)] ??
        [];

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
            child: Column(
              children: [
                // Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Text(
                    'My Schedule',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Calendar
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },

                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  eventLoader: (day) {
                    String dateKey = DateFormat("yyyy-MM-dd").format(day);
                    return groupedAppointments[dateKey] ?? [];
                  },
                ),
                const SizedBox(height: 16),
                // Appointments List
                Expanded(
                  child: selectedAppointments.isEmpty
                      ? const Center(child: Text("No appointments scheduled."))
                      : AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: selectedAppointments.length,
                              itemBuilder: (context, index) {
                                final appointment = selectedAppointments[index];
                                return Transform.translate(
                                  offset: Offset(0, _cardsAnimation.value),
                                  child: Opacity(
                                    opacity: _controller.value,
                                    child: _buildAppointmentCard(
                                      appointment,
                                      Theme.of(context).colorScheme,
                                    ),
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

  Widget _buildAppointmentCard(
    AppointmentData appointment,
    ColorScheme colorScheme,
  ) {
    final doctor = appointment.doctor!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
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
                    imageUrl: appointment.doctor?.photo ?? "",
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
                        doctor.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor.specialization?.name ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(appointment.status?.toUpperCase() ?? ''),
                  backgroundColor: appointment.status == "pending"
                      ? Colors.orange[100]
                      : Colors.green[100],
                  labelStyle: TextStyle(
                    color: appointment.status == "pending"
                        ? Colors.orange[800]
                        : Colors.green[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${appointment.appointmentTime} - ${appointment.appointmentEndTime}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${doctor.city?.name}, ${doctor.city?.governrate?.name}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "${appointment.appointmentPrice} EGP",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
