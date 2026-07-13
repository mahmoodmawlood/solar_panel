import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'code.dart';

class Solar extends StatefulWidget {
  const Solar({super.key});
  @override
  _SolarState createState() => _SolarState();
}

class _SolarState extends State<Solar> {
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _gammaController = TextEditingController();
  final _betaController = TextEditingController();
  final _effController=TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  final _zoneController = TextEditingController();

  double year = 2026; double month = 6; double day = 25; 
  double beta = 25.0; double gamma = 180.0; 
  double eff = 0.2; double lat = 35.467; double lon = 44.392; double zone=3.0;
  City _selectedCity = cityDatabase[0]; // ✅ holds currently selected location
//  double azimuth = 0.0; double alt = 0.0;
int betaOption = 0; // fixed beta value
int calc_type = 1;
int location = 1;  // 1 city location available in menue, 0 not available
  // Variables to store calculation results
List<int>mdays =[31,28,31,30,31,30,31,31,30,31,30,31];
int error = 0;
List<String> prod0 = new List.filled(18,' ');
List<String> prod1 = new List.filled(18,' ');
List<String> prod2 = new List.filled(18,' ');
String _year_init =" ";
String _month_init=" ";
String _day_init=" ";
String _gamma_init=" ";
String _beta_init=" ";
String _eff_init=' ';
String _total = ' ';
String _useful = ' ';

  @override
  void initState() {
    super.initState();
    DateTime _now = DateTime.now();
    year = _now.year.toDouble();
    month = _now.month.toDouble();
    day = _now.day.toDouble();
    _yearController.text = (year.toInt()).toString();
    _monthController.text = (month.toInt()).toString();
    _dayController.text = (day.toInt()).toString();
    _gammaController.text = 180.toString();
    _betaController.text = 25.toString(); // specified temp controller
    _effController.text = 20.toString();
    _zoneController.text = 3.toString();
    _year_init = 'السنة';
    _month_init = 'الشهر'; _gamma_init='الاتجاه(درجة)'; 
    _day_init = 'اليوم'; _beta_init = 'الميل(درجة)'; 
    _eff_init = "الكفاءة %";

      _routine();
  } 
  
void _getlocation(){
  for(int i = 0; i< 15; i++){
    prod1[i] = '';
    prod2[i] = '';
    _total = '';
    _useful = '';
  }
  if(_selectedCity.name == 'غير موجود'){
    location = 0;
    setState((){

    });
  }else{
    location = 1;
    setState((){
      _latController.text = '';
      _lonController.text = '';      
    });
  }
}


  void _getdata(){
    year = double.tryParse(_yearController.text) ?? 0 ;
    month = double.tryParse(_monthController.text) ?? 0;
    day = double.tryParse(_dayController.text) ?? 0;
    gamma = double.tryParse(_gammaController.text) ?? 0;
    eff = double.tryParse(_effController.text) ?? 0;
    eff = eff/100;
    if((year.toInt() %4) == 0 )mdays[1]=29;
    if(betaOption == 0){
      beta = double.tryParse(_betaController.text) ?? 20.0;
      _betaController.text = beta.toStringAsFixed(0);
      setState((){

      });

    } else {
      _betaController.text='  '; 
      setState((){

      });
    }
    if(_selectedCity.name == 'غير موجود'){
      location = 0;
      setState((){

      });
      lat = double.tryParse(_latController.text) ?? -180.0;
      lon = double.tryParse(_lonController.text) ?? -200.0;
      zone = double.tryParse(_zoneController.text) ?? 3.0;
    }else{
      location = 1;
      _latController.text = '';
      _lonController.text = '';
            setState((){

      });

    }
     _routine();  
  }      // end of getdata
/*
void _closeApp(){
  if(Platform.isAndroid){
    SystemNavigator.pop();    // android exit
  } else if(Platform.isIOS)  {
    exit(0);
  }
} */

// BUIL UI 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
/*      appBar: AppBar(title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.greenAccent, // background color for the title box
              borderRadius: BorderRadius.circular(8), // rounded corners
            ),
            child: const Text(
              'حسابات الطاقة للالواح الشمسية - اعداد د. محمود خالد',
              style: TextStyle(
                color: Colors.black, // text color
                fontSize: 12, fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true, // optional
          backgroundColor: Colors.blue, // color of the AppBar itself
        

      ), */ // end of AppBar

       body: SingleChildScrollView(
        child: Padding(
         padding: const EdgeInsets.all(2.0),         
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children:[
              const SizedBox(height: 20),
              _boxedText(text:'حساب الطاقةواختيارالميل للالواح الشمسية-أعداد د.محمود خالد', 
                width:350, fill:Colors.blue.withOpacity(0.8)),
              Row(
                children: [
                  _boxedText(text:'أختيار', width:60, fill:Colors.white),
                  Radio<int>(
                    value: 0,  groupValue: betaOption,
                    onChanged: (value) {
                      setState(() {
                        betaOption = value!;
                      });
                    },
                  ),
                  const Text("الميل مثبت"),
                  const SizedBox(width: 10), // Distance between the two options
                  Radio<int>(
                    value: 1,   groupValue: betaOption,
                    onChanged: (value) {
                      setState(() {
                        betaOption = value!;
                      });
                    },
                  ),
                  const Text("حساب افضل ميل"),
                ],
              ),
//          const SizedBox(height: 2),
    Row(
      children: [
          _boxedText(text:'بيانات  الالواح', width:80, fill:Colors.white),
          //_buildInputField(_phiinit, _phiController, 80.0),
          SizedBox(width: 1),
          Expanded(child: _buildInputField(_gamma_init, _gammaController, 0)),//                        Expanded(child: _buildInputField(_prinit, _prController,50.0)),
          SizedBox(width: 1),
          Expanded(child: _buildInputField(_beta_init, _betaController, betaOption)),
          SizedBox(width: 1),
          Expanded(child: _buildInputField(_eff_init, _effController, 0)),//                        Expanded(child: _buildInputField(_prinit, _prController,50.0)),

      ],
    ),  // end of date input rows
    
    SizedBox(height: 3),
    Row(
      children: [
        _boxedText(text:'تاريخ اليوم', width:80, fill:Colors.white),
        Expanded(child: _buildInputField(_year_init, _yearController, 0)),
        SizedBox(width: 1),
        Expanded(child: _buildInputField(_month_init, _monthController, 0)),
        SizedBox(width: 1),
        Expanded(child: _buildInputField(_day_init, _dayController, 0)),        
      ],
    ),  //

    _boxedText(text:'اذا موقعك ليس ضمن القائمة اختر "غير موجود" ثم املأ البيانات تحت', width:325, fill:Colors.white),
    SizedBox(height: 3),
    Row(
      children:[
        Expanded(child: _buildInputField("أدخل خط العرض", _latController, location)),
        SizedBox(width: 1),
        Expanded(child: _buildInputField("أدخل خط الطول", _lonController, location)),
        SizedBox(width: 1),
        Expanded(child: _buildInputField("فرق التوقيت", _zoneController, 0 )),        
      ],
    ),


                //SizedBox(height: 3),
  Row( 
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        onPressed: _getdata,
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
          minimumSize: MaterialStateProperty.all<Size>(const Size(15,25)),
          ),
        child: Text("احسب", 
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
      ), 
      SizedBox(width:40),
      Expanded(child: buildCitySelector()),
      SizedBox(width:1),
//                      _outputBox('M '+_m_wt+' g/mol'),
    ],
  ), 
          _boxedText(text:prod2[14], width:325, fill:Colors.white),

Row(        // Main Central row encompassing two columns
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1),
          _boxedText(text:'الطاقةالمحصودة هذا اليوم', width:150, fill:Colors.yellow.withOpacity(0.7)),
          _prodlist(text0:'اليوم',text1:'الميل', text2:'kWh/m^2', fill:Colors.blue.shade200),
          _prodlist(text0:'هذا',text1:prod1[0], text2:prod2[0],fill:Colors.white),
          SizedBox(height:2),
          _boxedText(text:'الطاقةالمحصودة للأشهر', width:150, fill:Colors.yellow.withOpacity(0.7)),
          _prodlist(text0:'الشهر',text1:'الميل', text2:'kWh/m^2', fill:Colors.blue.shade200),
          _prodlist(text0:prod0[1],text1:prod1[1], text2:prod2[1],fill:Colors.white),
          _prodlist(text0:prod0[2],text1:prod1[2], text2:prod2[2],fill:Colors.white),
          _prodlist(text0:prod0[3],text1:prod1[3], text2:prod2[3],fill:Colors.white),
          _prodlist(text0:prod0[4],text1:prod1[4], text2:prod2[4],fill:Colors.white),
          _prodlist(text0:prod0[5],text1:prod1[5], text2:prod2[5],fill:Colors.white),
          _prodlist(text0:prod0[6],text1:prod1[6], text2:prod2[6],fill:Colors.white),
          _prodlist(text0:prod0[7],text1:prod1[7], text2:prod2[7],fill:Colors.white),
          _prodlist(text0:prod0[8],text1:prod1[8], text2:prod2[8],fill:Colors.white),                        
        ],               //children of left column
    ),                   // end of left column
),                      // end of Expanded

                SizedBox(width:2),      // space between left and right sides

// **********************************************************************************
// ****************   start of the right column  ************************************
Expanded(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,   // align right
        mainAxisAlignment: MainAxisAlignment.start,   // start from top
        children: [
          SizedBox(height: 1),
          _boxedText(text:'الطاقةالمحصودة للأشهر', width:150, fill:Colors.yellow.withOpacity(0.7)),
          _prodlist(text0:'الشهر',text1:'الميل', text2:'kWh/m^2', fill:Colors.blue.shade200),
          _prodlist(text0:prod0[9],text1:prod1[9], text2:prod2[9],fill:Colors.white),
          _prodlist(text0:prod0[10],text1:prod1[10], text2:prod2[10],fill:Colors.white),
          _prodlist(text0:prod0[11],text1:prod1[11], text2:prod2[11],fill:Colors.white),
          _prodlist(text0:prod0[12],text1:prod1[12], text2:prod2[12],fill:Colors.white), 
          _boxedText(text:_total+' المجموع', width:150, fill:Colors.white),
          SizedBox(height: 2),
          _boxedText(text:'الطاقةالمحصودةفي سنة', width:150, fill:Colors.yellow.withOpacity(0.7)),
          _prodlist(text0:'السنة',text1:'الميل', text2:'kWh/m^2', fill:Colors.blue.shade200),
          _prodlist(text0:'هذه',text1:prod1[13], text2:prod2[13],fill:Colors.white),

          SizedBox(height: 2),
          _boxedText(text:'الطاقة المحولة الى كهرباء', width:150, fill:Colors.yellow.withOpacity(0.7)),
          _boxedText(text:_useful + ' kWh/m^2', width:150, fill:Colors.white),
          _boxedText(text:'وحدة لكل متر مربع في سنة', width:150, fill:Colors.white),

                        ],                               // end of children of Right column
                    ),                                   // end of Right side column
                ),                                       // end of second expanded
            ],                                           // end of main Children
        ),                                               // end of Main Row
          ],
          ),  // main main column
      ),                                   // end of Main Padding
      ),
    );                                  // end of Scaffold

  } // end of build Widget


  // Helper function to build Result Boxes
  Widget _buildResultBox( String value, Color fill, double w ) {
    return Container(
      //margin: EdgeInsets.only(right:100),
      //width: double.infinity,
      width: w, //250,  //double.infinity,
      height:26,
      //padding: EdgeInsets.only(1),
      decoration: BoxDecoration(
        color: fill, //grey[100],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        /*  Text(
            title,
            style: TextStyle(fontSize:10),
            textDirection: TextDirection.ltr,
          ),*/
          SizedBox(height: 8),
          Text(value.isNotEmpty ? value : '       ',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

Widget _outputBox(String value) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 25,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(value, textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
             ),
      ),
    ),
  );
}





// Helper function to build input boxes for prayer times
  // Helper function to create input fields for
  Widget _buildInputField(String label, TextEditingController controller, int show) {
    return 
      SizedBox(
       
        height: 22,
        
          child: TextField(
          style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
          controller: controller,
          enabled: show == 0,
          decoration: InputDecoration(filled: true, fillColor:
                                                      Colors.lightGreen[200],
          labelText: label,
          labelStyle: TextStyle(fontSize:12, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      
      );
    
  }

      Widget buildCitySelector(){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: DropdownButton<City>(
            value: _selectedCity,
            isExpanded: true,
            underline: SizedBox(), // Removes the default underline
            //icon: Icon(Icons.local_gas_station, color: Colors.blue), // Add a fuel icon
            items: cityDatabase.map((City city) {
              return DropdownMenuItem<City>(
                value: city,
                child: Text(
                  city.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),//w800),
                ),
              );
            }).toList(),
            onChanged: (City? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCity = newValue;
                  _getlocation();
                });
              }
            },
          ),
        );
      }        // end of dropdown widget


// ----------------------------------Calculations Start Here

// Function to calculculate Flame Temp and species
  
Future<void> _routine() async{
  List<SolarStep> solarData = [];

  setState((){
    prod2[14]='انتظر..الحسابات جارية';
    for(int i = 0; i< 14; i++ ){
      prod1[i]='  ';
      prod2[i]='  ';
      _useful = ' ';
      _total = '  ';
    }
  });
  await Future.delayed(Duration(milliseconds: 50));

  List<int>mdays =[31,28,31,30,31,30,31,31,30,31,30,31];
  int error = 0;
  if((year.toInt() %4) == 0 )mdays[1]=29;
  if(_selectedCity.name != 'غير موجود' ){

      lat = _selectedCity.lat;
      lon = _selectedCity.lon;
      zone = _selectedCity.zone;
  }
// check mistaken input 
if(year>2500.0 || year < 1600.0 || month<1.0 || month>12.0 || day<1.0 || day.toInt()>mdays[month.toInt()-1]){
  error = 1;
  prod2[14]= 'خطأ في التاريخ';
  for(int i = 0; i< 14; i++ ){
    prod1[i]='  ';
    prod2[i]='  ';
    _useful = ' ';
  }
  setState((){
  prod2[14]= 'خطأ في التاريخ';
  });
  await Future.delayed(Duration(milliseconds: 2000));
  return;
}
if(beta < 0.0 || beta > 90.0 || gamma<0.0 || gamma>360.0 || eff<0.1 || eff>100.0){
  error = 1;
  prod2[14]= 'خطأ في بيانات الالواح';
  for(int i = 0; i< 14; i++ ){
    prod1[i]='  ';
    prod2[i]='  ';
    _useful = ' ';
  }
  setState((){
    prod2[14]= 'خطأ في بيانات الالواح';
  });
  await Future.delayed(Duration(milliseconds: 2000));
  return;
}
if(lat<-90.0 || lat > 90.0 || lon<-180.0 || lon>180.0 || zone<-12.0 || zone>14.0){
  error = 1;
  prod2[14]= 'خطأ في بيانات الموقع';
  for(int i = 0; i< 14; i++ ){
    prod1[i]='  ';
    prod2[i]='  ';
    _useful = ' ';
  }
  setState((){
    prod2[14]= 'خطأ في بيانات الموقع';
  });
  await Future.delayed(Duration(milliseconds: 2000));
  return;
}

if(error == 0){
  // very important to clear the cash before building it every time
  solarManager.solarData.clear();
  int day_zero = 0; 
  int n_day = 0; 
  double JD = 0.0;
  int lastDay = 365;
  if((year.toInt() %4) == 0 )lastDay=366;
  int j_max = lastDay*96;  // no of year steps through the year
  JD = julian(year.toInt(), 1, 1);
  JD = JD - zone/24.0; // midnight JD
  n_day = 1;
  double azim = 0.0;
  double alt = 0.0;
  double DNI = 0.0;
  double DHI = 0.0;
  double GHI = 0.0; 
  int j1 = 0; 
  int j2 = 0;
  for(int j = 1; j< j_max+1; j++){ 
      JD = JD + 0.25/24.0;
      List<double> R = solar_angles(JD, lat, lon);
      azim = R[0];
      alt = R[1];
      DNI = 0.0;
      DHI = 0.0;
      GHI = 0.0;
      if(alt > 0.0){
        List<double> Rad= solar_irrad(n_day, azim, alt,0.0,0.0);
        DNI =  Rad[0];
        DHI = Rad[1];
        GHI = Rad[2]; 
      }
      int k = 0;
      if(j%96 == 0)k=1;
      n_day = n_day + k;
      solarManager.solarData.add(
         SolarStep(
                  altitude: alt,
                  azimuth: azim,
                  dni: DNI,
                  dhi: DHI,
                  ghi: GHI,
        ),
      );     
  }      // end of for j loop  data for the whole year is calculated
// ******************************************************************
// ******************************************************************

//  prepare for calling DAILY calculation

    prod2[14]='انتظر..الحساب لهذا اليوم';
    n_day = day.toInt();
    for(int i = 0; i< month.toInt()-1; i++){
      n_day += mdays[i];
    }
    int i_beta_1 = 0;
    int i_beta_2 = 90;
    int i_step = 1;
    if(betaOption == 0){
      i_beta_1 = beta.toInt();
      i_beta_2 = beta.toInt();
      i_step = beta.toInt();
    }
 
  double total_energy = 0.0;
  double best_beta = 0.0;
  j1 = n_day*96;
  j2 = j1 + 96;
  List<double>optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, 1);
  best_beta = optimum[0];
  total_energy = optimum[1];
  prod0[0]= day.toStringAsFixed(0);
  prod1[0] = best_beta.toStringAsFixed(0); 
  prod2[0]=total_energy.toStringAsFixed(2);
    await Future.delayed(Duration(milliseconds: 500));
//  one day calculation is done
// ================================================================

// ************* Prepare for calling Monthly Routine *******************
  double months_total = 0.0;

  for(int i_month =1; i_month < 13; i_month++){
    prod2[14]='انتظر..الحساب جاري لشهر $i_month';  
    setState((){

    });    
    await Future.delayed(Duration(milliseconds: 500));

    List<int>mdays =[31,28,31,30,31,30,31,31,30,31,30,31];
    if((year.toInt() %4) == 0 ) {
      mdays[1]=29;
    }

    n_day = 0;
    for(int i = 0; i < i_month - 1; i++){
      n_day += mdays[i];
    }
      j1 = 1 + n_day*96;
      j2 = j1 + mdays[i_month-1]*96;
    if(betaOption == 1){
      i_beta_1 = 0; i_beta_2 = 90; i_step = 10;
      total_energy = 0.0;
      best_beta = 0.0;
      List<double>optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
//    setState((){
      best_beta = optimum[0];
      total_energy = optimum[1];
      prod0[i_month] = i_month.toStringAsFixed(0);
      prod1[i_month] = best_beta.toStringAsFixed(0); 
      prod2[i_month] = total_energy.toStringAsFixed(2);
//    });
    await Future.delayed(Duration(milliseconds: 500));

      i_beta_1 = max(0, best_beta.toInt() - i_step);
      i_beta_2 = min(90, best_beta.toInt() + i_step);
      i_step = 1;
      optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
      best_beta = optimum[0];
      total_energy = optimum[1];

      setState((){
        prod0[i_month]= i_month.toStringAsFixed(0);
        prod1[i_month] = best_beta.toStringAsFixed(0); 
        prod2[i_month]=total_energy.toStringAsFixed(2);
      });
    }else{
      i_beta_1 = beta.toInt(); i_beta_2 = beta.toInt(); i_step = beta.toInt();
      List<double>optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
      best_beta = optimum[0];
      total_energy = optimum[1];
      setState((){
        prod0[i_month] = i_month.toStringAsFixed(0);
        prod1[i_month] = best_beta.toStringAsFixed(0); 
        prod2[i_month] = total_energy.toStringAsFixed(2);
      });
        
      }
      months_total += total_energy;
      _total = months_total.toStringAsFixed(2);
      _useful = (months_total*eff).toStringAsFixed(2);
  }  // next month 
// ==============================================================
// ==============================================================


// *************** Prepare fo calling Annual Routine ********************
    prod2[14]='انتظر..الحساب جاري لهذه السنة';  
    setState((){

    });    
    await Future.delayed(Duration(milliseconds: 500));
    j1 = 1; j2 = j_max;
      if(betaOption == 1){
        i_beta_1 = 0; i_beta_2 = 90; i_step = 10;
        optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
        best_beta = optimum[0];
        total_energy = optimum[1];
        i_beta_1 = max(0, best_beta.toInt() - i_step);
        i_beta_2 = min(90, best_beta.toInt() + i_step);
        i_step = 1;
        optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
        best_beta = optimum[0];
        total_energy = optimum[1];
        prod1[13]=best_beta.toStringAsFixed(0);
        prod2[13]=total_energy.toStringAsFixed(2);
        _useful = (total_energy*eff).toStringAsFixed(2);
      }else{
        i_beta_1 = beta.toInt(); i_beta_2 = beta.toInt(); i_step = beta.toInt();
        optimum = optimize(j1, j2, i_beta_1, i_beta_2, gamma, i_step);
        best_beta = optimum[0];
        total_energy = optimum[1];
        prod1[13]=i_beta_1.toStringAsFixed(0);
        prod2[13]=_total;
      }

// ******************* done ************************************

  }

  setState((){
    prod2[14]='تم اجراء الحسابات';
  });

  } // end of erro if block

}   // ***************** END OF WIDGET BUILD


// *************************** class for output design ********************
class _prodlist extends StatelessWidget {
   final String text0;
   final String text1;
   final String text2;
   final Color fill; // = Colors.blue;
const _prodlist({required this.text0, required this.text1, required this.text2, 
        required this.fill,super.key});
//  const _prodlist({required this.text1, required this.text2, this.fill,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        children: [
          DecoratedBox( decoration:
            BoxDecoration(color: fill, border:Border.all(color:Colors.blue),
                          borderRadius:BorderRadius.circular(8),
            ),
            child: SizedBox(width:35, height:20, 
              child: Align(alignment: Alignment.center,
                child:Text(text0, 
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                ),
            ),
          ),
          SizedBox(width: 2),
          DecoratedBox( decoration:
            BoxDecoration(color: fill, border:Border.all(color:Colors.blue),
                          borderRadius:BorderRadius.circular(8),
            ),
            child: SizedBox(width:35, height:20, 
              child: Align(alignment: Alignment.center,
                child:Text(text1, 
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                ),
            ),
          ),

          SizedBox(width: 2),
          DecoratedBox(decoration:
            BoxDecoration(color: fill, border:Border.all(color:Colors.blue),
                          borderRadius:BorderRadius.circular(8),
            ),
            child: SizedBox(width:75, height:20, 
              child: Align(alignment: Alignment.center,
                child:Text(text2, 
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                ),
            ),
          ),
          
        ],
      ),
    );
  }
}
// ****************** output text inside a box *************************
class _boxedText extends StatelessWidget {
   final String text;
   final double width;
   final Color fill;
const _boxedText({required this.text, required this. width, required this.fill, super.key});
//  const _prodlist({required this.text1, required this.text2, this.fill,super.key});

  @override
  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.only(bottom: 1),
//      children:[
 return DecoratedBox( decoration:
            BoxDecoration(color: fill, border:Border.all(color:Colors.blue),
                          borderRadius:BorderRadius.circular(8),
            ),
            child: SizedBox(width:width, height:22, 
              child: Align(alignment: Alignment.center,
                child:Text(text, 
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                ),
            ),
          );
//        ],
//    );    
  }
}