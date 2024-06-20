class Autogenerated {
  String? message;
  SettingModel? results;

  Autogenerated({this.message, this.results});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    results = json['results'] != null
        ? new SettingModel.fromJson(json['results'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class SettingModel {
  String? siteTitle;
  String? siteDescription;
  String? siteLogo;
  String? siteAddress;
  String? sitePhone;
  String? siteEmail;
  String? siteMap;
  String? siteWorkTime;
  String? linkIframe;

  SettingModel(
      {this.siteTitle,
      this.siteDescription,
      this.siteLogo,
      this.siteAddress,
      this.sitePhone,
      this.siteEmail,
      this.siteMap,
      this.siteWorkTime,
      this.linkIframe});

  SettingModel.fromJson(Map<String, dynamic> json) {
    siteTitle = json['site_title'];
    siteDescription = json['site_description'];
    siteLogo = json['site_logo'];
    siteAddress = json['site_address'];
    sitePhone = json['site_phone'];
    siteEmail = json['site_email'];
    siteMap = json['site_map'];
    siteWorkTime = json['site_work_time'];
    linkIframe = json['link_iframe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site_title'] = this.siteTitle;
    data['site_description'] = this.siteDescription;
    data['site_logo'] = this.siteLogo;
    data['site_address'] = this.siteAddress;
    data['site_phone'] = this.sitePhone;
    data['site_email'] = this.siteEmail;
    data['site_map'] = this.siteMap;
    data['site_work_time'] = this.siteWorkTime;
    data['link_iframe'] = this.linkIframe;
    return data;
  }
}
