
class DeviceInfo {

  String? device;
  String? osVersion;
  String? appVersion;
  String? serial;
  String? regId;

  DeviceInfo();

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    this.device = json['device'];
    this.osVersion = json['os_version'];
    this.appVersion = json['app_version'];
    this.serial = json['serial'];
    this.regId = json['regid'];
  }

  Map<String, String?> toJson() => {
    'device': device,
    'os_version': osVersion,
    'app_version': appVersion,
    'serial': serial,
    'regid': regId,
  };

}