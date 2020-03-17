# PasswordTestField
Pin Entry TextField example written in SWIFT 3.0 and updated to Swit 5.0


![Simulator Screen Shot - iPhone 11 Pro - 2020-03-17 at 17 01 34](https://user-images.githubusercontent.com/2304583/76869467-0a341500-6871-11ea-9147-1dd02692b3fb.png)



App written in *SWIFT* language. Demo app can be useful for password …
…specially in banking apps having pin entry authentication.

App written in *SWIFT 3.0* language. Demo app can be useful for
password entry, specially in banking apps having pin entry
authentication.

WORKING:


Open Main.Storyboard and add a UIStackView and make it as subclass of PinContainerStackView. Set added UIStackView layout. And Done.

For reading entered OTP in your view controller add delegate to self and register for RegisterSecondaryDevice delegate.

e.g

    @IBOutlet weak var pinFileldsContainerView: PinContainerStackView!
    
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        pinFileldsContainerView.registerDelegate = self
    }
    
    //for delegate
    extension ViewController: RegisterSecondaryDevice {
    func registerSecondaryDevice(with token: String) {
           /*
          send to server or process locally
        */
          print("token is :\(token)")
    }
}






