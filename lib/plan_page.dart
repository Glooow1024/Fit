import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: AllActionItem(),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 20) / 2,
              height: 50,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.cyan.shade500;
                      return Colors.cyan.shade500;
                    },
                  ),
                ),
                child: Text(
                  "添 加",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print("test");
                },
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 20) / 2,
              height: 50,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ElevatedButton(
                  child: Text(
                    "保 存",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print("test");
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

class AllActionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: Color(0xffcccccc),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            alignment: Alignment.centerLeft,
            child: Text(
              "热身",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                //backgroundColor: Color(0xffcccccc),
              ),
            ),
          ),
          ActionItem("平板哑铃卧推"),
          ActionItem("上斜哑铃卧推"),
          ActionItem("平板哑铃卧推"),
          ActionItem("上斜哑铃卧推"),
          ActionItem("平板哑铃卧推"),
          ActionItem("上斜哑铃卧推"),
        ],
      ),
    );
  }
}

// 单条动作项目
class ActionItem extends StatelessWidget {
  final String actionName;
  ActionItem(this.actionName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: Color(0xffcccccc),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              this.actionName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                //backgroundColor: Color(0xffcccccc),
              ),
            ),
          ),
          DataRecord(),
        ],
      ),
    );
  }
}

// 重量与次数记录
class DataRecord extends StatefulWidget {
  @override
  _DataRecordState createState() => _DataRecordState();
}

class _DataRecordState extends State<DataRecord> {
  // 初始值
  final int _actionName;
  _DataRecordState(this._actionName);
  List _weights = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List _counts = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "重量：",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                  /*border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color(0xff555555)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color(0xff555555)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color(0xff555555)),
                  ),*/
                ),
                style: TextStyle(fontSize: 20),
                controller: _weights[0],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _weights[1],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _weights[2],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _weights[3],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "次数：",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(hintText: '10'),
                style: TextStyle(fontSize: 20),
                controller: _counts[0],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _counts[1],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _counts[2],
              ),
            ),
            Container(
              width: 60,
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: '10',
                ),
                style: TextStyle(fontSize: 20),
                controller: _counts[3],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
