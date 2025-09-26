import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/models/appointment_details_data_response_model.dart';
import 'package:tebbi/models/appointment_request_model.dart';
import 'package:tebbi/repositories/appointment_repository.dart';
import 'package:tebbi/screens/home/views/appointment_details_screen.dart';

import '../../../blocs/appointment/add_appointment_bloc/add_appointment_bloc.dart';

class BookAppointmentView extends StatefulWidget {
  final int doctorId;

  const BookAppointmentView({super.key, required this.doctorId});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView>
    with TickerProviderStateMixin {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  // Animation controllers
  late AnimationController _dateController;
  late AnimationController _timeController;
  late AddAppointmentBloc _addAppointmentBloc;
  AppointmentDetailsDataResponseModel? _appointmentDetailsDataResponseModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _dateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _timeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _addAppointmentBloc = AddAppointmentBloc(AppointmentsRepository())
      ..stream.listen((AddAppointmentState state) {
        if (state is AddAppointmentLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is AddAppointmentSuccess) {
          setState(() {
            isLoading = false;
            _appointmentDetailsDataResponseModel = state.data;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Appointment has been booked successfully"),
            ),
          );
        } else if (state is AddAppointmentFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to book your appointment, try again.'),
            ),
          );
        }
      });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    _dateController.forward().then((_) => _dateController.reverse());
    final today = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    _timeController.forward().then((_) => _timeController.reverse());
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  void _submitAppointment() {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
      return;
    }

    final startTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final request = AppointmentRequest(
      doctorId: widget.doctorId,
      startTime: startTime.toIso8601String(),
      notes: _notesController.text,
    );

    _addAppointmentBloc.add(AddAppointmentStarted(appointmentRequest: request));
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  : _appointmentDetailsDataResponseModel != null
                  ? AppointmentDetailsView(
                      appointment: _appointmentDetailsDataResponseModel!.data!,
                    )
                  : Column(
                      children: [
                        // Header
                        Row(
                          children: const [
                            BackButton(color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Book Appointment",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Date picker card with animation
                        _buildAnimatedCard(
                          controller: _dateController,
                          child: ListTile(
                            leading: const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                            ),
                            title: Text(
                              _selectedDate == null
                                  ? "Select Date"
                                  : DateFormat.yMMMMd().format(_selectedDate!),
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: _pickDate,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Time picker card with animation
                        _buildAnimatedCard(
                          controller: _timeController,
                          child: ListTile(
                            leading: const Icon(
                              Icons.access_time,
                              color: AppColors.primary,
                            ),
                            title: Text(
                              _selectedTime == null
                                  ? "Select Time"
                                  : _selectedTime!.format(context),
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: _pickTime,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Notes input card
                        _buildNeumorphicCard(
                          child: TextField(
                            controller: _notesController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: "Notes (optional)",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitAppointment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Book Appointment",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

  Widget _buildAnimatedCard({
    required AnimationController controller,
    required Widget child,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: 1.03,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: _buildNeumorphicCard(child: child),
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
