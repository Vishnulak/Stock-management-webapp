import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PharmacyDashboard(),
    );
  }
}

class PharmacyDashboard extends StatefulWidget {
  @override
  _PharmacyDashboardState createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    DashboardPage(),
    StockMonitoringPage(),
    AutoStockBookingPage(),
    SalesAndProfitPage(),
    ExpiryManagementPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar
          Container(
            width: 80,
            color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(icon: Icon(Icons.dashboard), onPressed: () => _onItemTapped(0)),
                    IconButton(icon: Icon(Icons.inventory), onPressed: () => _onItemTapped(1)),
                    IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => _onItemTapped(2)),
                    IconButton(icon: Icon(Icons.show_chart), onPressed: () => _onItemTapped(3)),
                    IconButton(icon: Icon(Icons.timer), onPressed: () => _onItemTapped(4)),
                  ],
                ),
                IconButton(icon: Icon(Icons.logout), onPressed: () {}),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

// 1. Dashboard Page
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/stock.jpg',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardCard(
              title: "Total Stock",
              value: "1250",
              color: Colors.green[300]!,
            ),
            DashboardCard(
              title: "Stock Running Out",
              value: "10",
              color: Colors.orange[300]!,
            ),
            DashboardCard(
              title: "Expiring Soon",
              value: "8",
              color: Colors.red[300]!,
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  DashboardCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

// 2. Stock Monitoring Page
class StockMonitoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Stock Monitoring",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        // Incoming and Outgoing Stocks
        StockTable(),
      ],
    );
  }
}

class StockTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Medicine')),
          DataColumn(label: Text('Added')),
          DataColumn(label: Text('Removed')),
          DataColumn(label: Text('Remaining')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Paracetamol')),
            DataCell(Text('50 Units (29 Dec)')),
            DataCell(Text('30 Units (30 Dec)')),
            DataCell(Text('20 Units')),
          ]),
          DataRow(cells: [
            DataCell(Text('Ibuprofen')),
            DataCell(Text('100 Units (27 Dec)')),
            DataCell(Text('40 Units (28 Dec)')),
            DataCell(Text('60 Units')),
          ]),
        ],
      ),
    );
  }
}

// 3. Auto-Stock Booking Page
class AutoStockBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Auto Stock Booking",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        // Running Out Stocks and Booked Stocks
        StockStatusSection(),
      ],
    );
  }
}

class StockStatusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockCard(title: "Running Out Stocks", details: "Paracetamol, Ibuprofen"),
        StockCard(title: "Booked Stocks", details: "Aspirin (50 Units, 31 Dec)"),
      ],
    );
  }
}

class StockCard extends StatelessWidget {
  final String title;
  final String details;

  StockCard({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            Text(details, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}

// 4. Sales and Profit Page
class SalesAndProfitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sales and Profit",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Expanded(
          child: LineChart(LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 10),
                  FlSpot(1, 50),
                  FlSpot(2, 100),
                  FlSpot(3, 200),
                ],
                isCurved: true,
                color: Colors.blue,
              ),
            ],
          )),
        ),
        SizedBox(height: 16),
        Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.star, color: Colors.orange),
            title: Text("Most Sold Product: Paracetamol"),
            subtitle: Text("Region: New York"),
          ),
        ),
      ],
    );
  }
}

// 5. Expiry Management Page
class ExpiryManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> medicines = [
      {"name": "Paracetamol", "expiry": "2024-01-05"},
      {"name": "Ibuprofen", "expiry": "2024-01-10"},
      {"name": "Amoxicillin", "expiry": "2024-01-15"},
      {"name": "Ciprofloxacin", "expiry": "2024-01-20"},
      {"name": "Doxycycline", "expiry": "2024-01-25"},
      {"name": "Metformin", "expiry": "2024-02-01"},
      {"name": "Atorvastatin", "expiry": "2024-02-05"},
      {"name": "Omeprazole", "expiry": "2024-02-10"},
      {"name": "Simvastatin", "expiry": "2024-02-15"},
      {"name": "Levothyroxine", "expiry": "2024-02-20"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry Management",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              String name = medicines[index]['name']!;
              String expiry = medicines[index]['expiry']!;
              DateTime expiryDate = DateTime.parse(expiry);
              bool isExpiringSoon = expiryDate.difference(DateTime.now()).inDays <= 7;

              return Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.warning, color: isExpiringSoon ? Colors.red : Colors.green),
                  title: Text(name),
                  subtitle: Text("Expiry Date: $expiry"),
                  trailing: isExpiringSoon
                      ? Text("Expiring Soon!", style: TextStyle(color: Colors.red))
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

