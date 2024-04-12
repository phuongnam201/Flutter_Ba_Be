import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String test =
      "Chuyến đi sẽ bắt đầu v&agrave;o 08h:30 hoặc 13h:30, l&aacute;i thuyền của ch&uacute;ng t&ocirc;i l&agrave; những người d&acirc;n bản sẽ đ&oacute;n bạn tại điểm hẹn cho chuyến tham quan, kh&aacute;m ph&aacute; hồ Ba Bể bằng thuyền, sau một tiếng kh&aacute;m ph&aacute; hồ Ba Bể, ngược d&ograve;ng s&ocirc;ng Năng bạn sẽ được đưa đến động Pu&ocirc;ng, một hang động với d&ograve;ng s&ocirc;ng ngầm, c&oacute; chiều d&agrave;i 300 m&eacute;t, cao hơn 30 m&eacute;t.&nbsp;<a href=\"http://dulichhobabe.com/vn/gioi-thieu/vuon-quoc-gia-ba-be/he-thong-hang-dong.aspx\">Động Pu&ocirc;ng</a>";

  @override
  void initState() {
    super.initState();
    // Gọi phương thức getSetting() của SettingController
    //Get.find<SettingController>().getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HtmlWidget(test),
    );
  }
}
