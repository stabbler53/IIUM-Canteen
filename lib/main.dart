import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CanteenApp());
}

class CanteenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
        '/canteens': (context) => CanteensPage(),
      },
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String email = emailController.text;
                    String password = passwordController.text;

                    // Perform registration logic here using email and password
                    _performRegistration(email, password);

                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegistration(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Registration error: $error');
      // Handle the error as per your requirement
    }
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Login successful, proceed to the next screen or perform necessary actions
      Navigator.pushNamed(context, '/canteens');
    } catch (e) {
      // Handle login errors and exceptions
      String errorMessage = 'An error occurred during login.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _login();
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  Future<void> _performLogin(String password) async {
    try {
      // Perform login logic here using the password
      // You can use _auth.signInWithEmailAndPassword() method from FirebaseAuth
      
    } catch (error) {
      print('Login error: $error');
      // Handle the error as per your requirement
    }
  }




class CanteensPage extends StatefulWidget {
  @override
  _CanteensPageState createState() => _CanteensPageState();
}

class _CanteensPageState extends State<CanteensPage> {
  final Map<String, List<String>> canteens = {
    'Canteen Zubair': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Ali': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Siddiq': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Farouq': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Maryam': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Asia': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Hafsa': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ],
    'Canteen Halima': [
      'Arab Corner',
      'Banghali food',
      'Chinese restaurant',
      'Western food',
      'Malay Corner'
    ]
  };

  Map<String, String> canteenLogos = {};

  @override
  void initState() {
    super.initState();
    fetchCanteenLogos();
  }

  Future<void> fetchCanteenLogos() async {
    for (String canteenName in canteens.keys) {
      String logoUrl = await getLogoUrl(canteenName);
      setState(() {
        canteenLogos[canteenName] = logoUrl;
      });
    }
  }

  Future<String> getLogoUrl(String canteenName) async {
    switch (canteenName) {
      case 'Canteen Zubair':
        return 'https://isc.iium.edu.my/2019/wp-content/uploads/sites/2/2019/11/zubair1-1024x512.jpg';
      case 'Canteen Ali':
        return 'https://pbs.twimg.com/profile_images/1044780590334017536/oJOMLZHB_400x400.jpg';
      case 'Canteen Siddiq':
        return 'https://pbs.twimg.com/profile_images/918027182655422464/N4ThXJTg_400x400.jpg';
      case 'Canteen Farouq':
        return 'https://pbs.twimg.com/media/Ej91rt_VgAELOZf.jpg';
      case 'Canteen Maryam':
        return 'https://pbs.twimg.com/profile_images/983001626175725568/IPONa2bw_400x400.jpg';
      case 'Canteen Asia':
        return 'https://pbs.twimg.com/profile_images/1199275798303109121/7w8E70D4_400x400.jpg';
      case 'Canteen Hafsa':
        return 'https://pbs.twimg.com/profile_images/916955290792222720/5VpMYAkb_400x400.jpg';
      case 'Canteen Halima':
        return 'https://3.bp.blogspot.com/-bkrZIKj34Ic/T5bSlKr7uJI/AAAAAAAAAw8/RmuA_KLqrAw/s1600/9.+haleemah.jpg';
      default:
        return ''; // Return a default logo URL or empty string if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canteens')),
      body: ListView.builder(
        itemCount: canteens.length,
        itemBuilder: (context, index) {
          String canteenName = canteens.keys.elementAt(index);
          String? logoUrl = canteenLogos[canteenName];

          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: logoUrl != null
                  ? Image.network(
                      logoUrl,
                      width: 48.0,
                      height: 48.0,
                    )
                  : Container(), // Show an empty container if logoUrl is null
              title: Text(
                canteenName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${canteens[canteenName]!.length} restaurants',
                style: TextStyle(fontSize: 14.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantsPage(
                      canteenName: canteenName,
                      restaurants: canteens[canteenName]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class RestaurantsPage extends StatelessWidget {
  final String canteenName;
  final List<String> restaurants;

  RestaurantsPage({required this.canteenName, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurants')),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          String restaurantName = restaurants[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(
                restaurantName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DishesPage(
                      restaurantName: restaurantName,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DishesPage extends StatelessWidget {
  final String restaurantName;

  DishesPage({required this.restaurantName});

  final Map<String, List<MenuItem>> dishes = {
    'Arab Corner': [
      MenuItem(name: 'Shawarma RM 7', imageAsset: 'assets/pics/Shawarma.jpeg'),
      MenuItem(name: 'Mandi RM 9', imageAsset: 'assets/pics/Mandi.jpg'),
      MenuItem(name: 'Muqalql RM 8', imageAsset: 'assets/pics/Muqalql.jpg'),
      MenuItem(name: 'Shakshoka RM 6', imageAsset: 'assets/pics/Shakshoka.jpg'),
      MenuItem(name: 'Foul RM 5', imageAsset: 'assets/pics/Foul.jpeg'),
      MenuItem(name: 'Hummus RM 5', imageAsset: 'assets/pics/Hummus.png')
    ],
    'Banghali food': [
      MenuItem(
          name: 'Chicken tandoori RM 5.5',
          imageAsset: 'assets/pics/Chicken tandoori.png'),
      MenuItem(
          name: 'Roti tampal RM 3', imageAsset: 'assets/pics/Roti tampal.jpg'),
      MenuItem(
          name: 'Roti Canai RM 2', imageAsset: 'assets/pics/Roti Canai.png'),
      MenuItem(name: 'purtama RM 3.5', imageAsset: 'assets/pics/purtama.jpg'),
      MenuItem(
          name: 'Mix chicken RM 4.5', imageAsset: 'assets/pics/Mix chicken.jpg')
    ],
    'Chinese restaurant': [
      MenuItem(
          name: 'Chicken noodls RM 6',
          imageAsset: 'assets/pics/Chicken noodls.jpg'),
      MenuItem(
          name: 'Lamb noodls RM 7', imageAsset: 'assets/pics/Lamb noodls.png'),
      MenuItem(name: 'Dumblings RM 5', imageAsset: 'assets/pics/Dumblings.png'),
      MenuItem(
          name: 'chicken soup RM 5.5',
          imageAsset: 'assets/pics/chicken soup.png'),
      MenuItem(
          name: 'Lamp soup RM 6.5', imageAsset: 'assets/pics/Lamp soup.png')
    ],
    'Western food': [
      MenuItem(
          name: 'Chicken chop RM 7',
          imageAsset: 'assets/pics/Chicken chop.jpg'),
      MenuItem(name: 'Pizza RM 5', imageAsset: 'assets/pics/Pizza.png'),
      MenuItem(
          name: 'Chicken Burger RM 4',
          imageAsset: 'assets/pics/Chicken Burger.png'),
      MenuItem(
          name: 'Lamp burger RM 5', imageAsset: 'assets/pics/Lamp burger.jpeg'),
      MenuItem(
          name: 'susage sandwich RM 4',
          imageAsset: 'assets/pics/susage sandwich.png')
    ],
    'Malay Corner': [
      MenuItem(
          name: 'Nasi goreng RM 4', imageAsset: 'assets/pics/Nasi goreng.png'),
      MenuItem(
          name: 'Nasi ayam gepuk RM 5',
          imageAsset: 'assets/pics/Nasi ayam gepuk.jpg'),
      MenuItem(
          name: 'Nasi iskander RM 5.5',
          imageAsset: 'assets/pics/Nasi iskander.jpeg'),
      MenuItem(name: 'Nasi USA RM 5', imageAsset: 'assets/pics/Nasi USA.png'),
      MenuItem(
          name: 'Nasi karapu RM 4.5',
          imageAsset: 'assets/pics/Nasi karapu.jpeg')
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<MenuItem> restaurantDishes = dishes[restaurantName] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Dishes')),
      body: ListView.builder(
        itemCount: restaurantDishes.length,
        itemBuilder: (context, index) {
          MenuItem dish = restaurantDishes[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: Image.asset(
                dish.imageAsset,
                width: 48.0,
                height: 48.0,
                fit: BoxFit.cover,
              ),
              title: Text(
                dish.name,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String imageAsset;

  MenuItem({required this.name, required this.imageAsset});
}
