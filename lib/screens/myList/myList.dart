import 'package:flutter/material.dart';
import 'package:okuyan_muhendis/models/testBook.dart';
import 'package:okuyan_muhendis/screens/Search/Search.dart';
import 'package:okuyan_muhendis/screens/adviceOfTeacher/adviceOfTeacher.dart';
import 'package:okuyan_muhendis/screens/bookAnalysis/bookAnalysisTest.dart';
import 'package:okuyan_muhendis/screens/home/home.dart';
import 'package:okuyan_muhendis/services/jsonServices.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int _currentIndex = 2;
  List<TestBook> books = List();
  List<TestBook> filteredBooks = List();

  @override
  void initState() {
    super.initState();
    JsonServices.getBooks().then((booksFromServer) {
      setState(() {
        books = booksFromServer;
        filteredBooks = books;
        var recomBook = [];
        for (var filteredBook in filteredBooks) {
          if (filteredBook.bookRecomTeacher != "") {}
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Listem'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                    title:
                        Text(filteredBooks?.elementAt(index)?.bookName ?? ""),
                    subtitle:
                        Text(filteredBooks?.elementAt(index)?.bookAuthor ?? ""),
                    leading: Image(
                      alignment: Alignment.topRight,
                      image: NetworkImage(
                          filteredBooks?.elementAt(index)?.bookPhoto ?? ""),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookAnalysisTest(index)));
                    });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Anasayfa'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Arama'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Listem'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text('Tavsiyeler'),
              backgroundColor: Colors.blue)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            } else if (_currentIndex == 1) {
              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            } else if (_currentIndex == 3) {
              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => AdviceOfTeacher(),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
