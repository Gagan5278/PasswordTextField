# PasswordTestField
Pin Entry TextField Example in SWIFT 3.0 and updated to Swit 5.0


![Simulator Screen Shot - iPhone 11 Pro - 2020-03-17 at 17 01 34](https://user-images.githubusercontent.com/2304583/76869467-0a341500-6871-11ea-9147-1dd02692b3fb.png)



App written in *SWIFT* language. Demo app can be useful for password …
…specially in banking apps having pin entry authentication.

App written in *SWIFT 3.0* language. Demo app can be useful for
password entry, specially in banking apps having pin entry
authentication.

WORKING:

Just add GVTextField folder’s files in your project & paste below code
in yourViewController

 let pinView  = PinView(frame : CGRect(x: 0, y: 150, width:
UIScreen.main.bounds.size.width, height: 100))
        self.view.addSubview(pinView)

Please note that number of fields can be managed via
‘numberOfTextFields’ constant variable in your viewController.
