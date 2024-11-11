class StopResponse {
  String? resourceId;
  String? sid;
  ServerResponse? serverResponse;
  String? cname;
  String? uid;

  StopResponse(
      {this.resourceId, this.sid, this.serverResponse, this.cname, this.uid});

  StopResponse.fromJson(Map<String, dynamic> json) {
    resourceId = json['resourceId'];
    sid = json['sid'];
    serverResponse = json['serverResponse'] != null
        ? new ServerResponse.fromJson(json['serverResponse'])
        : null;
    cname = json['cname'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceId'] = this.resourceId;
    data['sid'] = this.sid;
    if (this.serverResponse != null) {
      data['serverResponse'] = this.serverResponse!.toJson();
    }
    data['cname'] = this.cname;
    data['uid'] = this.uid;
    return data;
  }
}

class ServerResponse {
  List<ExtensionServiceState>? extensionServiceState;

  ServerResponse({this.extensionServiceState});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    if (json['extensionServiceState'] != null) {
      extensionServiceState = <ExtensionServiceState>[];
      json['extensionServiceState'].forEach((v) {
        extensionServiceState!.add(new ExtensionServiceState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extensionServiceState != null) {
      data['extensionServiceState'] =
          this.extensionServiceState!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionServiceState {
  Playload? playload;
  String? serviceName;

  ExtensionServiceState({this.playload, this.serviceName});

  ExtensionServiceState.fromJson(Map<String, dynamic> json) {
    playload = json['playload'] != null
        ? new Playload.fromJson(json['playload'])
        : null;
    serviceName = json['serviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playload != null) {
      data['playload'] = this.playload!.toJson();
    }
    data['serviceName'] = this.serviceName;
    return data;
  }
}

class Playload {
  String? uploadingStatus;

  Playload({this.uploadingStatus});

  Playload.fromJson(Map<String, dynamic> json) {
    uploadingStatus = json['uploadingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadingStatus'] = this.uploadingStatus;
    return data;
  }
}
