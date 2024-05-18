import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  static const String name = 'calendarioReserva';
  const BookingCalendarDemoApp({super.key});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
        serviceName: 'Servicio Simulado',
        serviceDuration: 1,
        bookingEnd: DateTime(now.year, now.month, now.day, 1),
        bookingStart: DateTime(now.year, now.month, now.day, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula la carga de una nueva reserva
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} ha sido cargada');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    // Implementa la lógica de conversión aquí
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 0));
    DateTime second = now.add(const Duration(minutes: 0));
    DateTime third = now.subtract(const Duration(minutes: 0));
    DateTime fourth = now.subtract(const Duration(minutes: 0));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 0))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 0))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 0))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 0))));
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 0),
          end: DateTime(now.year, now.month, now.day, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            80), // Ajusta la altura del AppBar según sea necesario
        child: Padding(
          padding: const EdgeInsets.only(
              top: 30), // Ajusta el espacio en la parte superior del AppBar
          child: AppBar(
            title: const Text('Reserva tu lugar'),
            centerTitle: true,
            titleSpacing:
                10, // Ajusta el espacio entre el título y los bordes del AppBar
          ),
        ),
      ),
      body: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'desavilitado',
          hideBreakTime: false,
          loadingWidget: const Text('Obteniendo datos...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'es_ES',
          startingDayOfWeek: StartingDayOfWeek.tuesday,
          wholeDayIsBookedWidget:
              const Text('Lo sentimos, todo está reservado para este día'),
          bookingButtonText: 'Reservar'),
    );
  }
}
