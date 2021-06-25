import UIKit

class ViewController: UIViewController {
    
    let client = NetworkClient()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        client.getCharacterDetail()

        
        
    }


}

