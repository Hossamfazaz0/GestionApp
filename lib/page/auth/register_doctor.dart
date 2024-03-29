part of '../pages.dart';

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({Key? key}) : super(key: key);

  @override
  _RegisterDoctorPageState createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  bool _isLoading = false;

  int? _radioValue = 0;

  String _genderValue = 'Male';

  String? selectedSpecialist = "Generalist";
  List<String> specialist = [
    "Generalist",
    "Pediatre",
    "Dentist",
    "Ophtalmologue",
    "Opticien",
  "cardioloque",
    "chiregien",
    "Psychologue",
    "Gynecologue",
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Size size;
  double height = 0;
  double width = 0;

  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtAddress = TextEditingController();
  final TextEditingController _txtPhoneNumber = TextEditingController();

  final FocusNode _fnName = FocusNode();
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnPassword = FocusNode();
  final FocusNode _fnAddress = FocusNode();
  final FocusNode _fnPhoneNumber = FocusNode();

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;
    });
    switch (_radioValue) {
      case 0:
        _genderValue = 'Male';
        break;
      case 1:
        _genderValue = 'Female';
        break;
    }
  }

  List<DropdownMenuItem> generateItems(List<String> spesialis) {
    List<DropdownMenuItem> items = [];
    for (var item in spesialis) {
      items.add(
        DropdownMenuItem(
          child: Text(item),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _txtName.dispose();
    _txtEmail.dispose();
    _txtPassword.dispose();
    _txtAddress.dispose();
    _txtPhoneNumber.dispose();

    _fnName.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();
    _fnAddress.dispose();
    _fnPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/user-registration.png",
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: AppTheme.darkerPrimaryColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          "Register Doctor",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: DefaultTextStyle(
                            style: const TextStyle(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Nom et prénom",
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _txtName,
                                  focusNode: _fnName,
                                  maxLength: 30,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'Nom et prénom',
                                    errorStyle: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'You must fill this field';
                                    }

                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_fnEmail);
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "E-mail",
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _txtEmail,
                                  focusNode: _fnEmail,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'example@gmail.com',
                                    errorStyle: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Vous devez remplir ce champ';
                                    }

                                    if (!EmailValidator.validate(value)) {
                                      return 'Le courriel est invalide';
                                    }

                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_fnPassword);
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Mot de passe",
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  focusNode: _fnPassword,
                                  controller: _txtPassword,
                                  maxLength: 16,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'Mot de passe',
                                    errorStyle: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Vous devez remplir ce champ';
                                    }

                                    if (value.length <= 6) {
                                      return 'Le mot de passe doit comporter plus de 6 caractères';
                                    }

                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_fnPhoneNumber);
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Phone Number",
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  focusNode: _fnPhoneNumber,
                                  controller: _txtPhoneNumber,
                                  maxLength: 16,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'Phone Number',
                                    errorStyle: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Vous devez remplir ce champ';
                                    }

                                    if (value.length < 10 ||
                                        value.length > 16) {
                                      return 'Doit plus de 10 et moins de 16';
                                    }

                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_fnAddress);
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Adresse",
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  focusNode: _fnAddress,
                                  controller: _txtAddress,
                                  keyboardType: TextInputType.streetAddress,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    counterText: "",
                                    fillColor: Colors.white,
                                    hintText: 'Adresse',
                                    errorStyle: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Sexe",
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.white),
                                    ),
                                    const Text(
                                      'Mâle',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Radio(
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.white),
                                    ),
                                    const Text(
                                      'Femelle',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Choisissez un spécialiste",
                                ),
                                const SizedBox(height: 4),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      value: selectedSpecialist,
                                      items: generateItems(specialist),
                                      onChanged: (dynamic item) {
                                        setState(() {
                                          selectedSpecialist = item;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : SizedBox(
                                height: height / 18,
                                width: width / 2.5,
                                child: MaterialButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await _register();

                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      return;
                                    }
                                  },
                                  child: const Text("S'inscrire"),
                                  color: AppTheme.secondaryColor,
                                  textColor: Colors.black,
                                  disabledColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 32)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _register() async {
    // Checking if all form validator are valid
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (_genderValue == "") {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must choose gender"),
        ),
      );
      return;
    }

    if (selectedSpecialist == "") {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must choose specialist"),
        ),
      );
      return;
    }

    try {
      // Creating new user
      final dataAuth =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _txtEmail.text,
        password: _txtPassword.text,
      );

      // Doctor Data from Form Field
      Map<String, dynamic> data = {
        'doc_id': dataAuth.user!.uid,
        'name': _txtName.text,
        'email': _txtEmail.text,
        'phone_number': _txtPhoneNumber.text,
        'address': _txtAddress.text,
        'gender': _genderValue,
        'specialist': selectedSpecialist,
        'is_busy': false,
        'profile_url': "",
      };

      // Set doctor data to Firestore, as you can see we using the uid created from FirebaseAuth
      // So the FirebaseAuth.instance.currentUser.uid are matching with this documentId
      // It'll be easier to grab the document, as the ID are matching
      await FirebaseFirestore.instance.doc('doctor/${dataAuth.user!.uid}').set(
            data,
            SetOptions(merge: true),
          );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inscription réussie, redirection..."),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("une erreur est produite"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }
}
