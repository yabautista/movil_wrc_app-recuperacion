import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movil_wrc_app/providers/calendar_provider.dart';
import 'package:movil_wrc_app/widgets/tile_calendar.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarProv = ref.watch(getCalendar);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Calendar"),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
            child: calendarProv.when(
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (_, error) =>
                    const Text("Error al conectar con la Base"),
                data: (calendarData) {
                  return Column(
                    children: calendarData.content.map((calendario) {
                      return TileCalendar(
                          imgUrlLocation: calendario.images.first.url,
                          imgUrlFlagCountry: calendario.country.flag.first.url,
                          nameRally: calendario.title,
                          nameCountry: calendario.country.name,
                          startDate: calendario.startDate,
                          endDate: calendario.endDate);
                    }).toList(),
                  );
                })),
      ),
    );
  }
}
