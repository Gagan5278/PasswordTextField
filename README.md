# PasswordTestField
Pin Entry TextField Example in SWIFT 3.0


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
