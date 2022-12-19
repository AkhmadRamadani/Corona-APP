// @dart=2.9
import 'package:Corner/Utils/String.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tanya Jawab"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    AppConstants.Soal_1,
    <Entry>[Entry(AppConstants.Jawaban_1)],
  ),
  Entry(
    AppConstants.Soal_2,
    <Entry>[Entry(AppConstants.Jawaban_2)],
  ),
  Entry(
    AppConstants.Soal_3,
    <Entry>[Entry(AppConstants.Jawaban_3)],
  ),
  Entry(
    AppConstants.Soal_4,
    <Entry>[Entry(AppConstants.Jawaban_4)],
  ),
  Entry(
    AppConstants.Soal_5,
    <Entry>[Entry(AppConstants.Jawaban_5)],
  ),
  Entry(
    AppConstants.Soal_6,
    <Entry>[Entry(AppConstants.Jawaban_6)],
  ),
  Entry(
    AppConstants.Soal_7,
    <Entry>[Entry(AppConstants.Jawaban_7)],
  ),

  Entry(
    AppConstants.Soal_8,
    <Entry>[Entry(AppConstants.Jawaban_8)],
  ),

  Entry(
    AppConstants.Soal_9,
    <Entry>[Entry(AppConstants.Jawaban_9)],
  ),

  Entry(
    AppConstants.Soal_10,
    <Entry>[Entry(AppConstants.Jawaban_10)],
  ),

  // Entry('Chapter B',
  //   <Entry>[
  //     Entry('Section B0'),
  //     Entry('Section B1'),
  //   ],
  // ),
  // Entry('Chapter C',
  //   <Entry>[
  //     Entry('Section C0'),
  //     Entry('Section C1'),
  //     Entry('Section C2',
  //       <Entry>[
  //         Entry('Item C2.0'),
  //         Entry('Item C2.1'),
  //         Entry('Item C2.2'),
  //         Entry('Item C2.3'),
  //       ],
  //     ),
  //   ],
  // ),
];
