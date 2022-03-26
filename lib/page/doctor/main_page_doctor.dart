part of '../pages.dart';


class MainPageDoctor extends StatefulWidget {
  const MainPageDoctor({Key? key}) : super(key: key);
  @override
  _MainPageDoctorState createState() => _MainPageDoctorState();
}

class _MainPageDoctorState extends State<MainPageDoctor> {
  late Size size;
  double height = 0;
  double width = 0;

  late Doctor currentUser;

  @override
  void initState() {

    Provider.of<PatientProvider>(context, listen: false).get7Patient(
        Provider.of<DoctorProvider>(context, listen: false).doctor!.uid!);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    currentUser = Provider.of<DoctorProvider>(context).doctor!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Salut, ${currentUser.name}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 24),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      backgroundImage: currentUser.profileUrl != ""
                          ? NetworkImage(currentUser.profileUrl!)
                          : null,
                      child: currentUser.profileUrl != ""
                          ? null
                          : const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),



                const SizedBox(
                  height: 8,
                ),

                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Manage",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddConsultationSchedule(),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    title: const Text("Ajouter un horaire de consultation"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                          const ListConsultationSchedule(),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.darkerPrimaryColor,
                      child: Icon(Icons.date_range, color: Colors.white),
                    ),
                    title: const Text("Liste des horaires de consultation"),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _patientCard(UserModel item) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  backgroundImage: item.profileUrl != ""
                      ? NetworkImage(item.profileUrl!)
                      : null,
                  child: item.profileUrl != ""
                      ? null
                      : const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${item.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
