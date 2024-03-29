import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


import 'package:telekonsul/models/doctor/doctor.dart';
import 'package:telekonsul/models/consultation_schedule/consultation_schedule.dart';

import 'package:telekonsul/models/user/user.dart';


import 'package:telekonsul/provider/doctor_provider.dart';
import 'package:telekonsul/provider/consultation_schedule_provider.dart';
import 'package:telekonsul/provider/user_provider.dart';


import 'package:telekonsul/utils/app_theme.dart';
import 'package:telekonsul/utils/numeric_text_formatter.dart';
import 'package:telekonsul/utils/status_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:telekonsul/utils/toolbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/patient_provider.dart';

part 'auth/login.dart';
part 'auth/register.dart';
part 'auth/register_doctor.dart';
part 'user/main_page.dart';
part 'doctor/list_doctor_specialist.dart';


part 'patient/list_patient.dart';


part 'doctor/main_page_doctor.dart';
part 'landing/landing_page.dart';

part 'user/profile_user.dart';
part 'doctor/bottom_navbar_doctor.dart';
part 'user/bottom_navbar_user.dart';
part 'doctor/doctor_profile.dart';
part 'consultation/add_consultation_schedule.dart';
part 'consultation/list_consultation_schedule.dart';
part 'consultation/consultation_schedule_detail.dart';
part 'consultation/consultation_detail.dart';


part 'doctor/edit_doctor_profile.dart';
