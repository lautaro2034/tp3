import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:go_router/go_router.dart';

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
        serviceDuration: 60,
        bookingEnd: DateTime(now.year, now.month, now.day, 11),
        bookingStart: DateTime(now.year, now.month, now.day, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking,
      required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simula la carga de una nueva reserva
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} ha sido cargada');

    // Vuelve a la pantalla de inicio
    GoRouter.of(context).go('/home');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    // Genera los rangos de tiempo para las horas de 1 a 10
    for (int i = 0; i <= 10; i++) {
      DateTime start = DateTime(now.year, now.month, now.day, i);
      DateTime end = DateTime(now.year, now.month, now.day, i + 1);
      converted.add(DateTimeRange(start: start, end: end));
    }

    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 1),
          end: DateTime(now.year, now.month, now.day, 1))
    ];
  }

// Función para formatear la hora
  String formatHour(DateTime dateTime) {
    int hour = dateTime.hour;
    // Ajusta la hora si es mayor que 10
    if (hour > 10) {
      hour = hour % 10;
    }
    return 'P${hour.toString()}';
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
          uploadBooking: ({required BookingService newBooking}) =>
              uploadBookingMock(newBooking: newBooking, context: context),
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'desavilitado',
          hideBreakTime: false,
          loadingWidget: const Text('Obteniendo datos...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'es_ES',
          startingDayOfWeek: StartingDayOfWeek.tuesday,
          wholeDayIsBookedWidget:
              const Text('Lo sentimos, todo está reservado para este día'),
          bookingButtonText: 'Reservar',
          // Usa la función formatHour para formatear la hora
          formatDateTime: formatHour),
    );
  }
}
