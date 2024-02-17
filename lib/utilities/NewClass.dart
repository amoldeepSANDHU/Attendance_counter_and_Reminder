class NewClass {
  late String name;
  late int minAttendanceRequired;
  late int key;

  late int? counterForTotalNumOfClasses = 0;
  late double? counterForTotalPercentage = 0;
  late int? counterForTotalNumOfClassesAttended = 0;
  late int? counterForTotalNumOfClassesMissed = 0;
  late int? counterForTotalNumOfClassesRequiredToAttended = 0;

  NewClass({
    required this.name,
    this.counterForTotalNumOfClasses,
    this.counterForTotalNumOfClassesAttended,
    this.counterForTotalNumOfClassesMissed,
    this.counterForTotalNumOfClassesRequiredToAttended,
    required this.minAttendanceRequired,
  });

  String getName() {
    return name;
  }

  int getMinAttendance() {
    return minAttendanceRequired;
  }

  void setAttendance(int classes) {
    counterForTotalNumOfClassesAttended = classes;
  }

  int? getAttendance() {
    return counterForTotalNumOfClassesAttended;
  }

  void setClasses(int classes) {
    counterForTotalNumOfClasses = classes;
  }

  int? getClasses() {
    return counterForTotalNumOfClasses;
  }

  void setMissedClasses(int classes) {
    counterForTotalNumOfClassesMissed = classes;
  }

  int? getMissedClasses() {
    return counterForTotalNumOfClassesMissed;
  }

  void setRequiredAttendance(int classes) {
    counterForTotalNumOfClassesRequiredToAttended = classes;
  }

  int? getRequiredAttendance() {
    return counterForTotalNumOfClassesRequiredToAttended;
  }

  void setPercentage(double percentage) {
    counterForTotalPercentage = percentage;
  }

  double? getPercentage() {
    return counterForTotalPercentage;
  }
}
