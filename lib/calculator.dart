import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());
  final TextEditingController obtainedMarksController =
  TextEditingController();
  final TextEditingController percentageController =
  TextEditingController();
  String gpa = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: controllers[i],
                      decoration: InputDecoration(
                        labelText: getSubjectName(i),
                        icon: getSubjectIcon(i),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: calculateGPA,
                      icon: Icon(Icons.calculate),
                      label: Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: clearFields,
                      icon: Icon(Icons.clear),
                      label: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ReadOnlyTextField(
                  controller: obtainedMarksController,
                  labelText: 'Obtained Marks',
                ),
                SizedBox(height: 8),
                ReadOnlyTextField(
                  controller: percentageController,
                  labelText: 'Percentage',
                ),
                SizedBox(height: 8),
                Text(
                  'GPA: $gpa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getSubjectName(int index) {
    switch (index) {
      case 0:
        return 'English';
      case 1:
        return 'Urdu';
      case 2:
        return 'Maths';
      case 3:
        return 'Science';
      case 4:
        return 'Islamiat';
      default:
        return '';
    }
  }

  Icon getSubjectIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.book);
      case 1:
        return Icon(Icons.book);
      case 2:
        return Icon(Icons.calculate);
      case 3:
        return Icon(Icons.science);
      case 4:
        return Icon(Icons.book);
      default:
        return Icon(Icons.assignment);
    }
  }

  void calculateGPA() {
    int totalMarks = controllers
        .where((controller) => controller.text.isNotEmpty)
        .map((controller) => int.parse(controller.text))
        .fold(0, (sum, marks) => sum + marks);

    double percentage = (totalMarks * 100) / 500;

    String calculatedGPA = calculateGPAFromPercentage(percentage);

    setState(() {
      obtainedMarksController.text = totalMarks.toString();
      percentageController.text = '${percentage.toStringAsFixed(2)}%';
      gpa = calculatedGPA;
    });
  }

  void clearFields() {
    setState(() {
      for (var controller in controllers) {
        controller.clear();
      }
      obtainedMarksController.clear();
      percentageController.clear();
      gpa = '';
    });
  }

  String calculateGPAFromPercentage(double percentage) {
    if (percentage >= 80) {
      return 'A1';
    } else if (percentage >= 70) {
      return 'A';
    } else if (percentage >= 60) {
      return 'B';
    } else if (percentage >= 40) {
      return 'C';
    } else {
      return 'Fail';
    }
  }
}

class ReadOnlyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const ReadOnlyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(Icons.assignment_turned_in),
      ),
      readOnly: true,
    );
  }
}
