import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  static const String name = 'calendarioReserva';
  const BookingCalendarDemoApp({super.key});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class ButtonData {
  final int id;
  bool isReserved;

  ButtonData(this.id, this.isReserved);
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  DateTime? selectedDate;
  List<ButtonData> buttonDataList =
      List<ButtonData>.generate(11, (index) => ButtonData(index, false));

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      // Reset the reservations for the new date
      buttonDataList =
          List<ButtonData>.generate(11, (index) => ButtonData(index, false));
    });
  }

  void _reservePosition(int index) {
    setState(() {
      buttonDataList[index].isReserved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2101),
              focusedDay: selectedDate ?? DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: _onDaySelected,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            if (selectedDate != null) ...[
              const SizedBox(height: 10),
              Text(
                "Fecha seleccionada: ${selectedDate!.toLocal()}".split(' ')[0],
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2, // Make buttons rectangular
                  ),
                  itemCount: buttonDataList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: buttonDataList[index].isReserved
                          ? null
                          : () => _reservePosition(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonDataList[index].isReserved
                              ? Colors.red
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "p${buttonDataList[index].id}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: selectedDate != null
          ? FloatingActionButton(
              onPressed: () {
                context.goNamed(Home.name);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Reservas confirmadas!"),
                ));
              },
              tooltip: 'Reservar',
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}

/*
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
    return 'p${hour.toString()}';
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
          pauseSlotText: 'Deshabilitado',
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
}*/
