/*
class MyTabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calorie Counter"),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          //data secara horizontal
          columns: <DataColumn>[
            DataColumn(label: Text("Dessert (100g serving)")),
            DataColumn(label:Text("Calories")),
            DataColumn(label: Text("Fat (g)")),
            DataColumn(label: Text("Protein(g)")),
          ],
          //data secara vertikal
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text("Frozen Yogurt")),
                DataCell(Text("159")),
                DataCell(Text("6.0")),
                DataCell(Text("4.0")),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text("Ice Cream")),
                DataCell(Text("237")),
                DataCell(Text("9.0")),
                DataCell(Text("4.3")),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text("Burger")),
                DataCell(Text("350")),
                DataCell(Text("16.0")),
                DataCell(Text("6.0")),
              ],
            ),
          ]
        ) ,),
    );
  }
}

*/
