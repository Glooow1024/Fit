import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'record.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AllRecordItemModel model = Provider.of<AllRecordItemModel>(context);
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
                    print("save!!!!");
                    print(model);
                    print(model.records[0].idx);
                    print(model.records[0].id);
                    print(model.records[0].weights);
                    print(model.records[0].counts);
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
          ActionItem(0, 100), //"平板哑铃卧推"
          ActionItem(1, 101), //"上斜哑铃卧推"
          ActionItem(2, 102), //"平板哑铃卧推"
          ActionItem(3, 103), //"上斜哑铃卧推"
          ActionItem(4, 104), //"平板哑铃卧推"
          ActionItem(5, 105), //"上斜哑铃卧推"
        ],
      ),
    );
  }
}

// 单条动作项目
class ActionItem extends StatelessWidget {
  final int actionIdx;
  final int actionId;
  ActionItem(this.actionIdx, this.actionId);

  @override
  Widget build(BuildContext context) {
    String actionName = ""; //TODO:
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
              actionName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                //backgroundColor: Color(0xffcccccc),
              ),
            ),
          ),
          DataRecord(actionIdx: this.actionIdx, actionId: this.actionId),
        ],
      ),
    );
  }
}

// 重量与次数记录
class DataRecord extends StatefulWidget {
  final int actionIdx;
  final int actionId;
  DataRecord({required this.actionIdx, required this.actionId});

  @override
  _DataRecordState createState() =>
      _DataRecordState(this.actionIdx, this.actionId);
}

class _DataRecordState extends State<DataRecord> {
  // 初始值
  final int actionIdx;
  final int actionId;
  late RecordItem record;
  _DataRecordState(this.actionIdx, this.actionId);

  @override
  void initState() {
    super.initState();
    record = RecordItem(actionIdx, actionId, [0, 0, 0, 0], [0, 0, 0, 0]);
  }

  @override
  Widget build(BuildContext context) {
    AllRecordItemModel model =
        Provider.of<AllRecordItemModel>(context, listen: false);
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
                  hintText: '0',
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
                onChanged: (value) {
                  record.weights[0] = int.parse(value);
                  model.add(record);
                },
                /*onChanged: (value) {
                  setState(() {
                    _weights[0] = int.parse(value);
                  });
                },*/
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
                  hintText: '0',
                ),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.weights[1] = int.parse(value);
                  model.add(record);
                },
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
                  hintText: '0',
                ),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.weights[2] = int.parse(value);
                  model.add(record);
                },
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
                  hintText: '0',
                ),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.weights[3] = int.parse(value);
                  model.add(record);
                },
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
                decoration: InputDecoration(hintText: '0'),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.counts[0] = int.parse(value);
                  model.add(record);
                },
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
                decoration: InputDecoration(hintText: '0'),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.counts[1] = int.parse(value);
                  model.add(record);
                },
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
                decoration: InputDecoration(hintText: '0'),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.counts[2] = int.parse(value);
                  model.add(record);
                },
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
                decoration: InputDecoration(hintText: '0'),
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  record.counts[3] = int.parse(value);
                  model.add(record);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
