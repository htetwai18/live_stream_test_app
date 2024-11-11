class AcquireRequest {
  String? cname;
  String? uid;
  ClientRequestAcquire? clientRequest;

  AcquireRequest({this.cname, this.uid, this.clientRequest});

  AcquireRequest.fromJson(Map<String, dynamic> json) {
    cname = json['cname'];
    uid = json['uid'];
    clientRequest = json['clientRequest'] != null
        ? new ClientRequestAcquire.fromJson(json['clientRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cname'] = this.cname;
    data['uid'] = this.uid;
    if (this.clientRequest != null) {
      data['clientRequest'] = this.clientRequest!.toJson();
    }
    return data;
  }
}

class ClientRequestAcquire {
  int? scene;
  int? resourceExpiredHour;

  ClientRequestAcquire({this.scene, this.resourceExpiredHour});

  ClientRequestAcquire.fromJson(Map<String, dynamic> json) {
    scene = json['scene'];
    resourceExpiredHour = json['resourceExpiredHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scene'] = this.scene;
    data['resourceExpiredHour'] = this.resourceExpiredHour;
    return data;
  }
}
