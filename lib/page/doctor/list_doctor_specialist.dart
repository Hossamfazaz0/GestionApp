part of '../pages.dart';

class ListDoctorSpecialist extends StatefulWidget {
  final String specialist;
  const ListDoctorSpecialist({Key? key, required this.specialist})
      : super(key: key);

  @override
  _ListDoctorSpecialistState createState() => _ListDoctorSpecialistState();
}

class _ListDoctorSpecialistState extends State<ListDoctorSpecialist> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  final List<DataDoctor> _searchResult = [];

  bool _isEmpty = false;

  @override
  void initState() {
    Provider.of<DoctorProvider>(context, listen: false).getDoctorSpecialist(
      widget.specialist,
      Provider.of<UserProvider>(context, listen: false).user!.uid,
    );
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoctorProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.listSpecialistDoctor.isEmpty) {
            return const Center(
              child: Text("Il n'y a pas de médecin disponible aujourd'hui"),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Toolbar(),
                const SizedBox(height: 16.0),
                Text(
                  "List ${widget.specialist}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            _focusNode.unfocus();
                            _searchResult.clear();
                            _isEmpty = false;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: "Rechercher un médecin",
                  ),
                  onChanged: (query) {
                    if (query.isEmpty || query == "") {
                      setState(() {
                        _searchResult.clear();
                        _isEmpty = false;
                      });
                      return;
                    }

                    _searchResult.clear();
                    for (var element in value.listSpecialistDoctor) {
                      if (element.doctor.name!.contains(query)) {
                        setState(() {
                          _searchResult.add(element);
                          _isEmpty = false;
                          return;
                        });
                      }
                    }

                    if (_searchResult.isEmpty) {
                      setState(() {
                        _isEmpty = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8.0),
                _isEmpty
                    ? const Center(
                  child: Text("Rien n'est trouvee"),
                )
                    : Expanded(
                  child: _searchResult.isNotEmpty &&
                      _controller.text.isNotEmpty
                      ? ListView.builder(
                    itemBuilder: (context, index) {
                      final item =
                      _searchResult.toSet().toList()[index];

                      return doctorCard(item);
                    },
                    itemCount: _searchResult.toSet().length,
                    shrinkWrap: true,
                  )
                      : ListView.builder(
                    itemCount: value.listSpecialistDoctor.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item =
                      value.listSpecialistDoctor[index];

                      return doctorCard(item);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  doctorCard(DataDoctor item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 8),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 8,
            ),
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey,
              backgroundImage: item.doctor.profileUrl != ""
                  ? NetworkImage(item.doctor.profileUrl!)
                  : null,
              child: item.doctor.profileUrl != ""
                  ? null
                  : const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.doctor.name}",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${item.doctor.specialist}",
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  item.doctor.isBusy!
                      ? Container(
                    height: 25,
                    width: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.warningColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Consulting",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  )
                      : item.isBooked
                      ? Container(
                    height: 25,
                    width: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.dangerColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Deja Vu",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                  )
                      : Container(
                    height: 25,
                    width: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.primaryColor,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ConsultationDetail(
                              dataDoctor: item,
                            ),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          "Voir",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
