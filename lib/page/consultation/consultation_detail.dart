part of '../pages.dart';

class ConsultationDetail extends StatefulWidget {
  final DataDoctor dataDoctor;
  const ConsultationDetail({Key? key, required this.dataDoctor})
      : super(key: key);

  @override
  _ConsultationDetailState createState() => _ConsultationDetailState();
}

class _ConsultationDetailState extends State<ConsultationDetail> {
  DataDoctor get dataDoctor => widget.dataDoctor;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Toolbar(),
                const SizedBox(height: 8),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.4,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  child: Stack(
                    children: [
                      Image.asset('assets/img3.jpg'),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.grey,
                          backgroundImage: dataDoctor.doctor.profileUrl != ""
                              ? NetworkImage(dataDoctor.doctor.profileUrl!)
                              : null,
                          child: dataDoctor.doctor.profileUrl != ""
                              ? null
                              : const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 86,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "${dataDoctor.doctor.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text("${dataDoctor.doctor.specialist}"),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Disponible le:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Container(
                            child: dataDoctor.consultationSchedule
                                .where((element) =>
                            element.daySchedule!.intValue ==
                                DateTime
                                    .now()
                                    .weekday)
                                .map(
                                  (e) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.secondaryColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e.startAt!.format(context)} - ${e
                                            .endAt!.format(context)}",
                                        style:
                                        const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                            )
                                .first,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Adresse:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListTile(
                        leading: Image.asset('assets/img3.jpg'),
                        title: Text("${dataDoctor.doctor.address}"),
                      ),
                      const Text(
                        "Numero de Telephone:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListTile(
                        leading: Image.asset('assets/img3.jpg'),
                        title: Text("${dataDoctor.doctor.phoneNumber}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );

  }

}
