class QueryResponse {
  String? resourceId;
  String? sid;
  ServerResponse? serverResponse;
  String? cname;
  String? uid;

  QueryResponse(
      {this.resourceId, this.sid, this.serverResponse, this.cname, this.uid});

  QueryResponse.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'QueryResponse{resourceId: $resourceId, sid: $sid, serverResponse: $serverResponse, cname: $cname, uid: $uid}';
  }
}

class ServerResponse {
  int? status;
  List<ExtensionServiceState>? extensionServiceState;

  ServerResponse({this.status, this.extensionServiceState});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['extensionServiceState'] != null) {
      extensionServiceState = <ExtensionServiceState>[];
      json['extensionServiceState'].forEach((v) {
        extensionServiceState!.add(new ExtensionServiceState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.extensionServiceState != null) {
      data['extensionServiceState'] =
          this.extensionServiceState!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionServiceState {
  Payload? payload;
  String? serviceName;

  ExtensionServiceState({this.payload, this.serviceName});

  ExtensionServiceState.fromJson(Map<String, dynamic> json) {
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    serviceName = json['serviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['serviceName'] = this.serviceName;
    return data;
  }
}

class Payload {
  List<FileList>? fileList;
  bool? onhold;
  String? state;

  Payload({this.fileList, this.onhold, this.state});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['fileList'] != null) {
      fileList = <FileList>[];
      json['fileList'].forEach((v) {
        fileList!.add(new FileList.fromJson(v));
      });
    }
    onhold = json['onhold'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fileList != null) {
      data['fileList'] = this.fileList!.map((v) => v.toJson()).toList();
    }
    data['onhold'] = this.onhold;
    data['state'] = this.state;
    return data;
  }
}

class FileList {
  String? filename;
  int? sliceStartTime;

  FileList({this.filename, this.sliceStartTime});

  FileList.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    sliceStartTime = json['sliceStartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['sliceStartTime'] = this.sliceStartTime;
    return data;
  }
}
