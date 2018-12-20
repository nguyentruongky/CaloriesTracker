import UIKit

public struct Config {
  public static var modifyInset: Bool = true
}


public struct ColorList {
    
    public struct Shout {
        public static var background = UIColor.white
        public static var dragIndicator = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1)
        public static var title = UIColor.black
        public static var subtitle = UIColor.black
    }
    
    public struct Whistle {
        public static var background = UIColor.white
        public static var title = UIColor.black
    }
}


public struct FontList {
    
    public struct Shout {
        public static var title = UIFont.boldSystemFont(ofSize: 15)
        public static var subtitle = UIFont.systemFont(ofSize: 13)
    }
    
    public struct Whistle {
        public static var title = UIFont.systemFont(ofSize: 12)
    }
}
