import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double tinggi = 170;
  final TextEditingController berat = TextEditingController();

  double? bmi;
  String kategori = "-";
  Color warna = Colors.grey;

  void hitungBMI() {
    if (berat.text.isEmpty) return;

    final bb = double.tryParse(berat.text);
    if (bb == null) return;

    double meter = tinggi / 100;
    double hasil = bb / (meter * meter);

    setState(() {
      bmi = hasil;

      if (hasil < 18.5) {
        kategori = "Kurus";
        warna = Colors.orange;
      } else if (hasil < 25) {
        kategori = "Normal";
        warna = Colors.green;
      } else if (hasil < 30) {
        kategori = "Kelebihan Berat";
        warna = Colors.deepOrange;
      } else {
        kategori = "Obesitas";
        warna = Colors.red;
      }
    });
  }

  void reset() {
    setState(() {
      tinggi = 170;
      berat.clear();
      bmi = null;
      kategori = "-";
      warna = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF5B9BFF), Color(0xFF2563EB)],
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.favorite,
                    color: Colors.white, size: 55),
                const SizedBox(height: 10),
                const Text(
                  "BMI CALCULATOR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  bmi == null ? "--" : bmi!.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  kategori,
                  style: const TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Text("Tinggi Badan",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "${tinggi.toInt()} cm",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: tinggi,
                    min: 100,
                    max: 220,
                    divisions: 120,
                    onChanged: (v) => setState(() => tinggi = v),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Text("Berat Badan (kg)",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: TextField(
                controller: berat,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.monitor_weight),
                  hintText: "Masukkan berat badan",
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: hitungBMI,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              fixedSize: const Size(double.infinity, 55),
            ),
            child: const Text(
              "Hitung BMI",
              style: TextStyle(fontSize: 18),
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: reset,
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text("Reset"),
          ),

          const SizedBox(height: 22),

          if (bmi != null)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: warna.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: warna),
              ),
              child: Column(
                children: [
                  const Text(
                    "HASIL BMI",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmi!.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    kategori,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
