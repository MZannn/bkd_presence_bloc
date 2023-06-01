class UserModel {
  int code;
  String status;
  String message;
  Data data;

  UserModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  User user;
  List<Presence>? presences;

  Data({
    required this.user,
    this.presences,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        presences: json["presences"] == null
            ? []
            : List<Presence>.from(
                json["presences"]!.map(
                  (x) => Presence.fromJson(
                    x,
                  ),
                ),
              ),
      );
}

class Presence {
  int? id;
  String? nip;
  String? officeId;
  String? attendanceClock;
  String? attendanceClockOut;
  String? presenceDate;
  String? attendanceEntryStatus;
  String? attendanceExitStatus;
  String? entryPosition;
  String? entryDistance;
  String? exitPosition;
  String? exitDistance;

  Presence({
    this.id,
    this.nip,
    this.officeId,
    this.attendanceClock,
    this.attendanceClockOut,
    this.presenceDate,
    this.attendanceEntryStatus,
    this.attendanceExitStatus,
    this.entryPosition,
    this.entryDistance,
    this.exitPosition,
    this.exitDistance,
  });

  factory Presence.fromJson(Map<String, dynamic> json) => Presence(
        id: json["id"],
        nip: json["nip"],
        officeId: json["office_id"],
        attendanceClock: json["attendance_clock"],
        attendanceClockOut: json["attendance_clock_out"],
        presenceDate: json["presence_date"],
        attendanceEntryStatus: json["attendance_entry_status"],
        attendanceExitStatus: json["attendance_exit_status"],
        entryPosition: json["entry_position"],
        entryDistance: json["entry_distance"],
        exitPosition: json["exit_position"],
        exitDistance: json["exit_distance"],
      );
}

class User {
  String nip;
  String name;
  String position;
  String phoneNumber;
  dynamic profilePhotoPath;
  String deviceId;
  String officeId;
  Office office;

  User({
    required this.nip,
    required this.name,
    required this.position,
    required this.phoneNumber,
    this.profilePhotoPath,
    required this.deviceId,
    required this.officeId,
    required this.office,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nip: json["nip"],
        name: json["name"],
        position: json["position"],
        phoneNumber: json["phone_number"],
        profilePhotoPath: json["profile_photo_path"],
        deviceId: json["device_id"],
        officeId: json["office_id"],
        office: Office.fromJson(json["office"]),
      );
}

class Office {
  int id;
  String name;
  String address;
  double latitude;
  double longitude;
  double radius;
  String startWork;
  String startBreak;
  String lateTolerance;
  String endWork;

  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.startWork,
    required this.startBreak,
    required this.lateTolerance,
    required this.endWork,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        radius: double.parse(json["radius"]),
        startWork: json["start_work"],
        startBreak: json["start_break"],
        lateTolerance: json["late_tolerance"],
        endWork: json["end_work"],
      );
}
