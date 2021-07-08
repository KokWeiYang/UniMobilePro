import 'package:countmee/model/user.dart';
import 'package:countmee/view/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:countmee/notice/editMark.dart';
import 'package:countmee/notice/DataReader.dart';
export 'package:countmee/notice/draw.dart';

class DrawList extends StatefulWidget {
  final User user;
  DrawList(
      {Key key, @required this.notes, @required this.filterNotes, this.user})
      : super(key: key);
  final List<Map> notes;
  final ValueChanged<String> filterNotes;

  @override
  _DrawListState createState() => new _DrawListState();
}

class _DrawListState extends State<DrawList> {
  List<Map> _marks = [];
  // int _notesLength = 0;

  @override
  void initState() {
    super.initState();
    updateMarks(1);
  }

  @override
  Widget build(BuildContext context) {
    // _notesLength = widget.notes.length;
    _marks.forEach((Map mark) {
      mark['noteNum'] = 0;
    });
    widget.notes.forEach((Map note) {
      _marks.forEach((Map mark) {
        if (mark['id'] == note['markId']) {
          mark['noteNum']++;
        }
      });
    });

    final tiles = <Widget>[
      new ListTile(
          title:  new Text('My Notice', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          leading: new Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pop(
                context, MaterialPageRoute(builder: (content) => MainScreen()));
          },),
      new ListTile(
          title: new Text('Notice', style: TextStyle(fontSize: 18),),
          
          leading: new Icon(Icons.rate_review),
          onTap: () {
            widget.filterNotes('all');
            Navigator.of(context).pop();
          },),
      new ListTile(
        title: new Text('Manage Mark', style: TextStyle(fontSize: 18),),
        leading: new Icon(Icons.bookmark),
        onTap: _editMark,
      ),
    ];

    tiles.addAll(_buildMarks(_marks, context));

    final divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return new ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: divided,
    );
  }

  List<Widget> _buildMarks(List<Map> marks, BuildContext context) {
    return marks.map((Map mark) {
      return new ListTile(
          title: new Chip(
            label: new Text(mark['name']),
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Text(mark['noteNum'].toString())),
          ),
          onTap: () {
            widget.filterNotes(mark['name'] + '-' + mark['id']);
            Navigator.of(context).pop();
          },
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0));
    }).toList();
  }

  void updateMarks(int flag) {
    getMarks().then((List<Map> marks) {
      setState(() {
        _marks = marks.map((Map mark) {
          final Map<dynamic, dynamic> markItem = {
            'name': mark['name'],
            'id': mark['id'],
            'noteNum': 0
          };
          return markItem;
        }).toList();
      });
    });
  }

  void _editMark() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new EditMark(updateMarks: updateMarks);
        },
      ),
    );
  }
}
