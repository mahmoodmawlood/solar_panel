import 'dart:math';
//import 'Solar.dart';
class City {
  final String name;
  final double lat, lon, zone;
  City({this.name=' ', this.lat=0,  this.lon=0, this.zone=0});
}

final List<City> cityDatabase = [
  City(name:"كركوك", lat:35.467 , lon:44.392 , zone:3.0 
  ),
  City(name:"يايجي", lat:35.44  , lon:44.23 , zone:3.0 
  ),
  City(name:"تازة", lat:35.3  , lon:44.33 , zone:3.0 
  ),
  City(name:"داقوق", lat:35.17  , lon:44.44 , zone:3.0 
  ),
  City(name:"دبس", lat:35.67 , lon:44.08, zone:3.0 
  ),
  City(name:"التون كوبري", lat:35.76 , lon:44.14 , zone:3.0 
  ),  
  City(name:"حويجة", lat:35.33 , lon:43.77 , zone:3.0 
  ),
  City(name:"سليمانية", lat:35.577 , lon:45.434 , zone:3.0 
  ),
  City(name:"جمجمال", lat:35.53 , lon:44.82 , zone:3.0 
  ),
  City(name:"كلار", lat:34.63 , lon:45.33, zone:3.0 
  ),
  City(name:"اربيل", lat:36.19 , lon:44.0 , zone:3.0 
  ),
  City(name:"قوش تبة", lat:36.0 , lon:44.04 , zone:3.0 
  ),
  City(name:"مخمور", lat:35.78  , lon:43.58 , zone:3.0 
  ),
  City(name:"شقلاوة", lat:36.41  , lon:44.32 , zone:3.0 
  ),
  City(name:"كوي سنجق", lat:36.08  , lon:44.63 , zone:3.0 
  ),
  City(name:"موصل", lat:36.353  , lon:43.148 , zone:3.0 
  ),
  City(name:"اسكي كلك", lat:36.27  , lon:43.63 , zone:3.0 
  ),
  City(name:"قيارة", lat:35.8  , lon:43.3 , zone:3.0 
  ),
  City(name:"سنجار", lat:36.32  , lon:41.87 , zone:3.0 
  ),
  City(name:"ربيعة", lat:36.8  , lon:42.1 , zone:3.0 
  ),
  City(name:"تلعفر", lat:36.37  , lon:42.44 , zone:3.0 
  ),
  City(name:"دهوك", lat:36.864  , lon:42.99 , zone:3.0 
  ),
  City(name:"زاخو", lat:37.15  , lon:42.68 , zone:3.0 
  ),
  City(name:"عمادية", lat:37.1  , lon:43.5 , zone:3.0 
  ),
  City(name:"حلبجة", lat:35.18  , lon:46.0 , zone:3.0 
  ),
  City(name:"بعقوبة", lat:33.75  , lon:44.6 , zone:3.0 
  ),
  City(name:"خالص", lat:33.84  , lon:44.53 , zone:3.0 
  ),
  City(name:"خانقين", lat:34.35  , lon:45.39 , zone:3.0 
  ),
  City(name:"تكريت", lat:34.6  , lon:43.68 , zone:3.0 
  ),
  City(name:"شرقاط", lat:35.5  , lon:43.2 , zone:3.0 
  ),
  City(name:"طوزخورماتو", lat:34.89  , lon:44.63 , zone:3.0 
  ),
  City(name:"سامراء", lat:34.2  , lon:43.87 , zone:3.0 
  ),
  City(name:"بيجي", lat:35.0  , lon:43.5 , zone:3.0 
  ),
  City(name:"بغداد", lat:33.3  , lon:44.39 , zone:3.0 
  ),
  City(name:"رمادي", lat:33.44  , lon:43.27 , zone:3.0 
  ),
  City(name:"حديثة", lat:34.13  , lon:42.39 , zone:3.0 
  ),
  City(name:"هيت", lat:33.64  , lon:42.83 , zone:3.0 
  ),
  City(name:"فلوجة", lat:33.35  , lon:43.78 , zone:3.0 
  ),
  City(name:"عنة", lat:34.37  , lon:42.0 , zone:3.0 
  ),
  City(name:"رطبة", lat:33.04  , lon:40.29 , zone:3.0 
  ),
  City(name:"حلة", lat:32.48  , lon:44.42 , zone:3.0 
  ),
  City(name:"نجف", lat:32.02  , lon:44.32 , zone:3.0 
  ),
  City(name:"كربلاء", lat:32.6  , lon:44.02 , zone:3.0 
  ),
  City(name:"كوت", lat:32.52  , lon:45.82 , zone:3.0 
  ),
  City(name:"عمارة", lat:31.85  , lon:47.15 , zone:3.0 
  ),
  City(name:"ناصرية", lat:31.04  , lon:46.26 , zone:3.0 
  ),
  City(name:"سماوة", lat:31.32  , lon:45.28 , zone:3.0 
  ),
  City(name:"بصرة", lat:30.55  , lon:47.75 , zone:3.0 
  ),
  City(name:"غير موجود", lat: 0.0 , lon: 0.0 , zone:3.0 
  ),
];


// function definition solar_angles, returns azimuth and altitude
// arguments are julian date JD, latitude, and longitude
List<double> solar_angles(double JD, double lat, double lon) {
	double T = (JD - 2451545.00)/36525.0;
	double lo = 280.466460 + 36000.769830*T + 0.00030320*T*T;
	lo = reduce(lo);
	double G = 357.529110 + 35999.050290*T - 0.00015370*T*T;
	double C = (1.9146020 - 0.0048170*T - 0.0000140*T*T)*sind(G) +
	    (0.0199930 - 0.0001010*T)*sind(2.0*G) + 0.0002890*sind(3.0*G);
	double lambda = lo + C;
	double Om = 125.040 - 1934.1360*T; 
	lambda = lambda - 0.005690 - 0.004780*sind(Om);

	double THO = 280.460618370 + 360.985647366290*(JD-2451545.00) + 
		0.0003879330*T*T - T*T*T/38710000.00;
	THO = reduce(THO);
	double U = T/100.0;
	double EPS = 21.4480 + U*(-4680.930 + U*(-1.550 + U*(1999.250 + U*(-51.380 + 
				U*(-249.670 + U*(-39.050 + U*(7.120 + U*(27.87 + 
				U*(5.790 + U*2.450)))))))));		// THIS IS SECONDS' PART
	EPS = EPS + 23.0*3600.0 + 26.0*60.0;			// EPSO IN SECONDS
	EPS  = EPS /3600.0;	// EPS IN DEG

	lambda = reduce(lambda);
	double alfa = atan2d(cosd(EPS)*sind(lambda), cosd(lambda));
	alfa = reduce(alfa);
	double H = THO + lon - alfa;
	double delta = asind(sind(EPS) * sind(lambda));
	double azimuth = atan2d(sind(H),(cosd(H)*sind(lat) - tand(delta)*cosd(lat)));
	azimuth = azimuth + 180.0;
	double altitude  = asind(sind(lat)*sind(delta)+cosd(lat)*cosd(delta)*cosd(H));

  return [azimuth, altitude]; 
}
// =====================================================
double julian(int year, int month, int day) {
  int iy = year; int m = month; int d = day;
  if(m < 3) {
    iy -= 1;
    m += 12;
  }
  int ia = (iy/100.0).floor();
  int ib = 2 - ia + (ia/4.0).floor();
  if(iy < 0) {ib = 0;}
  double jd = (365.25*(iy + 4716)).toInt() + (30.6001*(m + 1)).toInt() + d + ib - 1524.5;
  return jd;
}
// *********************************************************



List<double>optimize(int j1, int j2, int i_beta_1, int i_beta_2,
           double gamma, int istep){
  double e1 = 0.0; double e2 = 0.0;
  double sum = 0.0;
  double RHO = 0.2;
  double total_energy = 0.0;
  double best_beta = 0.0;
  double beta = 0.0;
//print('j1 $j1 j2 $j2');
 for(int i = i_beta_1; i < i_beta_2+1; i++){
        beta = i.toDouble();
        sum = 0.0;
        e1 = 0.0;
        e2 = 0.0;
        for(int j = j1; j< j2; j++){
//            data = solarData[j];
            double alt = solarManager.solarData[j-1].altitude;
            double dni = solarManager.solarData[j-1].dni;
            double ghi = solarManager.solarData[j-1].ghi;
            double azim = solarManager.solarData[j-1].azimuth;
            double dhi = solarManager.solarData[j-1].dhi;
            e1 = e2;
            e2 = 0.0;
            if(alt > 0.0){
              	double COSTHETA = sind(alt)*cosd(beta) + cosd(alt)*sind(beta)* 
			          cosd(azim - gamma);
//!	dircet beam on the panel  Gb     
	          double Gb = dni * COSTHETA;	
	          Gb = max(Gb , 0.0);
            double Gd = dhi *(1.0 + cosd(beta))/2.0;
//! AND GROUND REFLECTED IRRAD Gr
	          double Gr = ghi*RHO*(1.0 - cosd(beta))/2.0;
//! FINAL TOTAL PANEL IRRAD Gt
	          e2 = Gb + Gd + Gr;

        }
            sum += 0.25*(e1 + e2)/2.0;
        }       // end of day hours
        if(sum > total_energy){
            best_beta = beta;
            total_energy = sum;
        }
  }
          total_energy = total_energy/1000;
          return[best_beta, total_energy];
}

// =========================E==================================

// ======================Solar Radiation Routine===============================
List<double> solar_irrad(int N_DAY, double AZIMUTH, double ALTITUDE, double BETA,
  double GAMMA){
  double UO = 0.3; double W = 1.5; double TAU = 0.1; double RHO = 0.2;
//!  Extraterrestrial Irradiance
	double B=360.0*(N_DAY - 1)/365.0;	//! degrees
	double E0=1.000110 + 0.0342210*cosd(B) + 0.001280*sind(B) + 0.0007190*cosd(2*B) + 
		0.0000770*sind(2*B);
	double I0 = 1367.0 * E0;	//! (W/M2)
//!   relative air mass M
	double ZENITH = 90.00 - ALTITUDE;  //! degrees
	double DENOM = cosd(ZENITH) + 0.150*pow((93.8850 - ZENITH),(-1.253));
	double M = 1.00/DENOM;
//!  atmospheric pressure effect assume P local 0.985 atm
	double MA = 0.985*M;
//!  Rayleigh Transmittance TR
	double TR = exp(-0.09030*pow(MA,0.84)*(1.0 + MA - pow(MA,1.01)));
//!  Ozone Transmittance TO
	double XO = UO*M;
	double TO=1.00-0.16110*XO*pow((1.00 + 139.480*XO),(-0.3035))-0.0027150*XO/ 
		(1.00 + 0.0440*XO + 0.00030*XO*XO);
//!  Water Vapor Transmittance TW
	double XW = W*M;
	DENOM = pow((1.0 + 79.034*XW),0.6828) + 6.3850*XW;
	double TW = 1.00 - 2.4959*XW/DENOM;
//!  Aerosol Transmittance assumed TA = 0.9  for tau = 0.0764 long expression
	double TA = exp(-0.0764*pow(M,0.873)*(1.00 + M - pow(M,0.708)));
//!  Mixed Gas Transmittance   (TG = 0.99)
	double TG = exp(-0.0119*pow(MA,0.25));
//!  Bird combined Transmittance, the principal result
	double DNI = 0.96620*I0*TR*TO*TG*TW*TA;	//! NORMAL IRRADIANCE
	double COSTHETA = sind(ALTITUDE)*cosd(BETA) + cosd(ALTITUDE)*sind(BETA)* 
			cosd(AZIMUTH - GAMMA);
//!	dircet beam on the panel  Gb     
	double Gb = DNI * COSTHETA;	
	Gb = max(Gb , 0.0);
//!  	direct horizontal irrad BHI
	double BHI = DNI*sind(ALTITUDE);
//!  	diffuse horizontal irrad DHI
	double FF = TO*TG*TW*(0.3950*(1.0-TR) + 0.590*(1.0 - pow(TA,0.75)))/
              (1.0- M + pow(M,1.02));
	double DHI = 0.9662*I0*sind(ALTITUDE)*FF;
//!  	global horizontal irrad  GHI
  double RHO_S = 0.0685 + 0.153*(1.0 - TA);
	double GHI = (BHI + DHI)/(1.0 - RHO*RHO_S);
//! NOW CALCULATE DIFFUSE PANEL IRRAD Gd
	double Gd = DHI *(1.0 + cosd(BETA))/2.0;
//! AND GROUND REFLECTED IRRAD Gr
	double Gr = GHI*RHO*(1.0 - cosd(BETA))/2.0;
//! FINAL TOTAL PANEL IRRAD Gt
	double TOTAL_IRRAD = Gb + Gd + Gr;
  
  return [DNI, DHI, GHI];
}

// =====================================================
double sind(double x){
  return sin(x*pi/180.0);
}
double cosd(double x){
  return cos(x*pi/180.0);
}
double tand(double x){
    return tan(x*pi/180.0);
}
double atan2d(double x, double y){
    return atan2(x, y)*180.0/pi;
}
double asind(double x){
    return asin(x)*180.0/pi;
}
double acosd(double x){
    return acos(x)*180.0/pi;
}

double reduce(double x){
  do  {
    if(x >= 0.0 && x<= 360.0){return x;}
    if(x < 0.0) { x += 360.0;}
    if(x > 360.0){x -= 360.0;}
  } while (true);
}
// *****************data manager class *********************
class SolarStep {
  final double altitude;
  final double azimuth;
  final double dni;
  final double dhi;
  final double ghi;

  SolarStep({
    required this.altitude,
    required this.azimuth,
    required this.dni,
    required this.dhi,
    required this.ghi,
  });
}

class SolarDataManager {
   List<SolarStep> solarData = [];
}

final solarManager = SolarDataManager();
//********************************************** */