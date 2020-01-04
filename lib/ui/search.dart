import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate {
  final places = [
    'Adyanpara Falls, near Nilambur',
    'Aruvikkuzhi, near Maramon, Kozhencherry in Pathanamthitta District',
    'Aruvikkuzhi, near Pallickathode, Kottayam District',
    'Athirappilly Falls 80 ft (24 m)',
    'Charpa Falls',
    'Cheeyappara Falls, near Adimali',
    'Chethalayam Falls, in Wayanad',
    'Alappuzha Lighthouse, Alappuzha',
    'Anjengo lighthouse, Thiruvananthapuram',
    'Azhikode Lighthouse, Thrissur',
    'Beypore Lighthouse, Kozhikode',
    'Chetwai Lighthouse, Thrissur',
    'Kasargode Lighthouse, Kasargode',
    'Kozhikkode Lighthouse, Kozhikode (Defunct)',
    'Tangasseri Lighthouse, Kollam',
    'Vizhinjam Lighthouse, Thiruvananthapuram'
  ];

  final recentPlaces = [
    'Azhikode Lighthouse, Thrissur',
    'Alappuzha Lighthouse, Alappuzha',
    'Tangasseri Lighthouse, Kollam',
  ];

  int recentselection = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for the app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return query.isNotEmpty? Center(
          child: Container(
        width: 300,
        height: 300,
        child: Card(
          elevation: 3,
          child: Center(child: Text('title')),
        ),
      ),
    )
    : Center(
          child: Container(
        width: 300,
        height: 300,
        child: Card(
          elevation: 3,
          child: Center(child: Text(recentPlaces[recentselection])),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone search for something

    final suggessionList = query.isEmpty
        ? recentPlaces
        : places.where((p) => p.toLowerCase().startsWith(query)).toList();

    return (suggessionList.length > 0)? ListView.builder(
      
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          recentselection =  query.isEmpty? index: 0;
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggessionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggessionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey)
              )
            ]
          ),
          
          
        ),
        
      ),
      itemCount: suggessionList.length,
    )
    :
    Center(
      child: Text('No Data'),
    );
  }
}
