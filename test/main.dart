import 'package:flutter/material.dart';

void main() => runApp(CanteenApp());

class CanteenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Canteen Zubair',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Image.network(
                'https://fastly.4sqi.net/img/general/width960/60051395_yFfIdwzymGdwRWN-Zfwi7gQQ_CzHtyY1rCFJcbdWbfQ.jpg',
                width: 120,
                height: 120,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
