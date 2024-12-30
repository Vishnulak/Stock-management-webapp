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
    StockManagementPage(),
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



class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pharmacy Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Title
            Text(
              "DASHBOARD",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),

            // Overview Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewCard(
                  title: "Total Stock",
                  value: "1,200",
                  subtitle: "Items in Inventory",
                  icon: Icons.inventory_2,
                  color: Colors.blueGrey[100]!,
                ),
                _buildOverviewCard(
                  title: "Low Stock",
                  value: "25",
                  subtitle: "Items Below Threshold",
                  icon: Icons.warning_amber_rounded,
                  color: Colors.red[100]!,
                ),
                _buildOverviewCard(
                  title: "Expiring Soon",
                  value: "15",
                  subtitle: "Items Approaching Expiry",
                  icon: Icons.schedule,
                  color: Colors.orange[100]!,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Expiring Soon Section
            Text(
              "Expiring Soon",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(3, (index) {
                  return ListTile(
                    leading: Icon(Icons.medical_services_outlined,
                        color: Colors.orange),
                    title: Text("Medicine ${index + 1}"),
                    subtitle: Text("Expiry Date: 2024-01-${10 + index}"),
                    trailing: Text(
                      "Qty: ${30 - index * 5}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),

            // Recent Activities Section
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text("Stock Updated"),
                    subtitle: Text("Today, 10:00 AM"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.error_outline, color: Colors.red),
                    title: Text("Low Stock Alert"),
                    subtitle: Text("Yesterday, 5:45 PM"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.add_shopping_cart,
                        color: Colors.blueGrey),
                    title: Text("New Order Placed"),
                    subtitle: Text("Yesterday, 3:30 PM"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickAction(
                  label: "Add Stock",
                  icon: Icons.add_box_outlined,
                  color: Colors.green[100]!,
                ),
                _buildQuickAction(
                  label: "View Orders",
                  icon: Icons.list_alt,
                  color: Colors.blueGrey[100]!,
                ),
                _buildQuickAction(
                  label: "Settings",
                  icon: Icons.settings,
                  color: Colors.grey[300]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Overview Card Builder
  Widget _buildOverviewCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blueGrey[800]),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Actions Button Builder
  Widget _buildQuickAction({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: Colors.blueGrey[800]),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.blueGrey[800]),
            ),
          ],
        ),
      ),
    );
  }
}



class StockManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    // Sample data for stock management
    List<Map<String, dynamic>> stockData = [
      {
        "medicineId": "M001",
        "medicineName": "Pain Reliever",
        "stockIncoming": 50,
        "stockOutgoing": 30,
        "totalSale": 1500,
      },
      {
        "medicineId": "M002",
        "medicineName": "Cough Syrup",
        "stockIncoming": 70,
        "stockOutgoing": 40,
        "totalSale": 2000,
      },
      {
        "medicineId": "M003",
        "medicineName": "Antibiotic",
        "stockIncoming": 60,
        "stockOutgoing": 50,
        "totalSale": 2500,
      },
      {
        "medicineId": "M004",
        "medicineName": "Vitamin C",
        "stockIncoming": 100,
        "stockOutgoing": 90,
        "totalSale": 4500,
      },
      {
        "medicineId": "M005",
        "medicineName": "Insulin",
        "stockIncoming": 40,
        "stockOutgoing": 20,
        "totalSale": 1000,
      },
      {
        "medicineId": "M006",
        "medicineName": "Allergy Relief",
        "stockIncoming": 80,
        "stockOutgoing": 60,
        "totalSale": 3000,
      },
      {
        "medicineId": "M007",
        "medicineName": "Pain Relief",
        "stockIncoming": 30,
        "stockOutgoing": 10,
        "totalSale": 500,
      },
      {
        "medicineId": "M008",
        "medicineName": "Fever Medicine",
        "stockIncoming": 90,
        "stockOutgoing": 80,
        "totalSale": 4000,
      },
      {
        "medicineId": "M009",
        "medicineName": "Antacid",
        "stockIncoming": 110,
        "stockOutgoing": 100,
        "totalSale": 5000,
      },
      {
        "medicineId": "M010",
        "medicineName": "Cold Medicine",
        "stockIncoming": 50,
        "stockOutgoing": 30,
        "totalSale": 1500,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Management"),
        backgroundColor: Colors.green,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
            // Stock Table Header
            Text(
            "Stock Management Details",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),

          // Stock Table
          _buildStockTable(stockData, constraints.maxWidth),
          ],
          ),
          ),
          );
        },
      ),
    );
  }

  // Method to build the stock table
  Widget _buildStockTable(List<Map<String, dynamic>> stockData, double screenWidth) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DataTable(
        columnSpacing: screenWidth * 0.05, // Adjust spacing dynamically
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green[100]!),
        columns: const [
          DataColumn(label: Expanded(child: Text('Medicine ID'))),
          DataColumn(label: Expanded(child: Text('Medicine Name'))),
          DataColumn(label: Expanded(child: Text('Stock Incoming'))),
          DataColumn(label: Expanded(child: Text('Stock Outgoing'))),
          DataColumn(label: Expanded(child: Text('Total Sale'))),
        ],
        rows: stockData.map((stock) {
          return DataRow(cells: [
            DataCell(Text(stock["medicineId"]!)),
            DataCell(Text(stock["medicineName"]!)),
            DataCell(Text(stock["stockIncoming"].toString())),
            DataCell(Text(stock["stockOutgoing"].toString())),
            DataCell(Text("\$${stock["totalSale"]}")),
          ]);
        }).toList(),
      ),
    );
  }
}







class AutoStockBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> bookings = List.generate(
      10,
          (index) => {"medicine": "Medicine ${index + 1}", "units": "50 Units"},
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Updated Header Section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Auto Stock Booking",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.local_pharmacy, size: 28, color: Colors.white),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Decorative Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.local_pharmacy, size: 50, color: Colors.white),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Easily monitor and book stock for medicines that are running low.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text("Book Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                  label: Text("Refresh"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt),
                  label: Text("Filter"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Stock Table with Full Width
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width, // Full width
                child: DataTable(
                  headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue[100]!),
                  columns: const [
                    DataColumn(label: Text('Medicine')),
                    DataColumn(label: Text('Booked Units')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: bookings.map((booking) {
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          Icon(Icons.medical_services, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(booking["medicine"]!),
                        ],
                      )),
                      DataCell(Text(booking["units"]!)),
                      DataCell(Chip(
                        label: Text(
                          "Confirmed",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),

          // Footer Note
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tip: Use the filter button to sort medicines by priority.",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class SalesAndProfitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Updated Header Section
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sales and Profit",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.bar_chart, size: 28, color: Colors.white),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Graph Section
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        'Med ${value.toInt() + 1}',
                        style: TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(10, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: (index + 1) * 10.0,
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),

        SizedBox(height: 16),

        // Table Section
        Expanded(
          child: ListView(
            children: [
              DataTable(
                headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                columns: [
                  DataColumn(label: Text('Medicine')),
                  DataColumn(label: Text('Profit (\$)')),
                ],
                rows: List.generate(10, (index) {
                  return DataRow(cells: [
                    DataCell(Text("Medicine ${index + 1}")),
                    DataCell(Text("₹${(index + 1) * 100}")),

                  ]);
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class ExpiryManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> expiries = List.generate(
      10,
          (index) => {
        "medicine": "Medicine ${index + 1}",
        "expiryDate": "2024-12-${10 + index}",
        "status": index % 2 == 0 ? "Expired" : "Expiring Soon",
      },
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Updated Header Section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expiry Management",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.warning, size: 28, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Information Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Card 1
                _buildFeatureCard(
                  color: Colors.teal[500]!,
                  icon: Icons.warning,
                  title: "Expired Medicines",
                  description: "Monitor expired medicines instantly.",
                ),
                // Card 2
                _buildFeatureCard(
                  color: Colors.teal[300]!,
                  icon: Icons.access_time,
                  title: "Expiring Soon",
                  description: "Track medicines about to expire.",
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Expiry Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width, // Full width
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green[100]!),
                  columns: const [
                    DataColumn(label: Text('Medicine')),
                    DataColumn(label: Text('Expiry Date')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: expiries.map((expiry) {
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          Icon(Icons.medical_services, color: Colors.red),
                          SizedBox(width: 8),
                          Text(expiry["medicine"]!),
                        ],
                      )),
                      DataCell(Text(expiry["expiryDate"]!)),
                      DataCell(Chip(
                        label: Text(
                          expiry["status"]!,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: expiry["status"] == "Expired"
                            ? Colors.blue[900]
                            : Colors.blue[200],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),

          // Footer Note
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tip: Use the filter button to focus on medicines requiring urgent attention.",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Feature Card Builder Method Restored
  Widget _buildFeatureCard({
    required Color color,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
