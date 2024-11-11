class AcquireResponse {
  String? cname;
  String? uid;
  String? resourceId;

  AcquireResponse({this.cname, this.uid, this.resourceId});

  AcquireResponse.fromJson(Map<String, dynamic> json) {
    cname = json['cname'];
    uid = json['uid'];
    resourceId = json['resourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cname'] = this.cname;
    data['uid'] = this.uid;
    data['resourceId'] = this.resourceId;
    return data;
  }
}
