class StopRequest {
  String? cname;
  String? uid;
  ClientRequestStop? clientRequest;

  StopRequest({this.cname, this.uid, this.clientRequest});

  StopRequest.fromJson(Map<String, dynamic> json) {
    cname = json['cname'];
    uid = json['uid'];
    clientRequest = json['clientRequest'] != null
        ? new ClientRequestStop.fromJson(json['clientRequest'])
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

class ClientRequestStop {
  bool? asyncStop;

  ClientRequestStop({this.asyncStop});

  ClientRequestStop.fromJson(Map<String, dynamic> json) {
    asyncStop = json['async_stop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['async_stop'] = this.asyncStop;
    return data;
  }
}
