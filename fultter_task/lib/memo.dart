import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProviderがあるみたい
    return ChangeNotifierProvider(
      create: (context) => MemoModel(),
      child: MaterialApp(
        title: 'Memo Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MemoPage(),
      ),
    );
  }
}

// メモページ
class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoModel = Provider.of<MemoModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        backgroundColor: Colors.orange,
        leading: IconButton( 
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: memoModel.memoList.length,
              itemBuilder: (context, index) {
                final memo = memoModel.memoList[index];
                return ListTile(
                  title: Text(memo),
                  trailing: IconButton( //削除ボタン
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      memoModel.removeMemo(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: memoModel.textController,
                    decoration: const InputDecoration(
                      labelText: 'New Memo',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    memoModel.addMemo();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// メモの管理
class MemoModel extends ChangeNotifier {
  final List<String> _memoList = [];
  final TextEditingController _textController = TextEditingController();

  // メモリスト取得
  List<String> get memoList => _memoList;
  TextEditingController get textController => _textController;

  // メモを追加
  void addMemo() {
    if (_textController.text.isNotEmpty) {
      _memoList.add(_textController.text);
      _textController.clear();
      notifyListeners();
    }
  }

  // メモを削除
  void removeMemo(int index) {
    _memoList.removeAt(index);
    notifyListeners();
  }
}
