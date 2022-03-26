part of '../pages.dart';

class AddConsultationSchedule extends StatefulWidget {
  const AddConsultationSchedule({Key? key}) : super(key: key);

  @override
  _AddConsultationScheduleState createState() =>
      _AddConsultationScheduleState();
}

class _AddConsultationScheduleState extends State<AddConsultationSchedule> {
  final List<DaySchedule> _day = [
    DaySchedule(
      'Lundi',
      1,
    ),
    DaySchedule(
      'Mardi',
      2,
    ),
    DaySchedule(
      'Mercredi',
      3,
    ),
    DaySchedule(
      'Jeudi',
      4,
    ),
    DaySchedule(
      'Vendredi',
      5,
    ),
    DaySchedule(
      'Samedi',
      6,
    ),
    DaySchedule(
      'Dimanche',
      7,
    ),
  ];

  DaySchedule? _selectedDay;

  TimeOfDay? _startTime;
  late TimeOfDay _endTime;

  bool _isLoading = false;

  _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      if (pickedTime.hour == 23 && pickedTime.minute >= 29) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You musn't pick time past 23:29, because schedule are automatically added 30min on start time, so if it past 23:29 it will fall on tommorow"),
            duration: Duration(seconds: 7),
            dismissDirection: DismissDirection.horizontal,
          ),
        );
        return;
      }
      setState(() {
        _startTime = pickedTime;
        pickedTime.minute >= 30
            ? _endTime = pickedTime.replacing(
          hour: pickedTime.hour + 1,
          minute: pickedTime.minute - 30,
        )
            : _endTime = pickedTime.replacing(
          hour: pickedTime.hour,
          minute: pickedTime.minute + 30,
        );
      });
    }
  }

  @override
  void initState() {
    _selectedDay = _day.firstWhere((element) => element.intValue == 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Toolbar(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: const Center(
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Ajouter un calendrier de consultation",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.darkerPrimaryColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 18.0),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text("Choisir le jour"),
                                const SizedBox(height: 4.0),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: DropdownButton<DaySchedule>(
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      value: _selectedDay,
                                      items: generateItems(_day),
                                      onChanged: (item) {
                                        setState(() {
                                          _selectedDay = item;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                const Text("Temps"),
                                const SizedBox(height: 4.0),
                                MaterialButton(
                                  color: AppTheme.secondaryColor,
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  onPressed: () async =>
                                      await _selectTime(context),
                                  child: _startTime != null
                                      ? Text(
                                          "${_startTime!.format(context)} - ${_endTime.format(context)}")
                                      : const Text("Choisissez l'heure"),
                                ),


                                const SizedBox(height: 22.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (_isLoading) const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ) else MaterialButton(
                                            onPressed: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              await _addJadwal();
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            child: const Text("Ajouter un horaire"),
                                            color:
                                                AppTheme.lighterSecondaryColor,
                                            textColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<DaySchedule>> generateItems(List<DaySchedule> days) {
    List<DropdownMenuItem<DaySchedule>> items = [];
    for (var day in days) {
      items.add(
        DropdownMenuItem(
          child: Text("${day.day}"),
          value: day,
        ),
      );
    }
    return items;
  }

  _addJadwal() async {
    NumberFormat format = NumberFormat();

    if (_startTime == null ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vous devez remplir toutes les valeurs"),
        ),
      );
      return;
    }

    DateTime now = DateTime.now();

    // Assign TimeOfDay to DateTime
    DateTime startAt = DateTime(
        now.year, now.month, now.day, _startTime!.hour, _startTime!.minute);

    DateTime endAt =
        DateTime(now.year, now.month, now.day, _endTime.hour, _endTime.minute);

    Map<String, dynamic> data = {
      'day_schedule': _selectedDay!.toJson(),
      // Format the value to 00:00 PM, so we can get the data later as TimeOfDay
      'start_at': DateFormat("hh:mm a").format(startAt),
      'end_at': DateFormat("hh:mm a").format(endAt),

    };

    await Provider.of<ConsultationScheduleProvider>(context, listen: false)
        .addConsultationSchedule(
      data,
      Provider.of<DoctorProvider>(context, listen: false).doctor!.uid,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Succès en ajoutant un nouveau calendrier de constulation"),
      ),
    );

    Navigator.of(context).pop();
  }
}
