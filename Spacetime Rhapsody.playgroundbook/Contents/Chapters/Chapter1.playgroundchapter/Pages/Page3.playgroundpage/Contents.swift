/*:
 Now it’s your turn to become the **creator of the universe!**
 
 This playground has included many other objects like **Jupiter, Neptune, or even a [neutron](glossary://neutron) star.** Be mindful about which ones are stars and which ones are planets. They attract other astronomical objects very differently.
 
 Make as many planets or stars as you wish. Be creative, be bold.
 
 **Follow the coding example below to add your own planets or stars**

 */
// This is an array of all the planets and stars you'd like to add
var objectsOnScreen = [AstronomicalObject]()

// Add your choices of objects here
objectsOnScreen.append(AstronomicalObject(name: .sun, type: .star))
objectsOnScreen.append(AstronomicalObject(name: .venus, type: .planet))
objectsOnScreen.append(AstronomicalObject(name: .earth, type: .planet))
objectsOnScreen.append(AstronomicalObject(name: .mars, type: .planet))
objectsOnScreen.append(AstronomicalObject(name: .jupiter, type: .planet))
objectsOnScreen.append(AstronomicalObject(name: .neptune, type: .planet))

// Run code to have your planets and stars displayed

//#-hidden-code
import PlaygroundSupport

func convertObjectsToStringArray(_ obj: [AstronomicalObject]) -> [String]{
    var res = [String]()
    
    for n in obj {
        res.append(n.toString())
    }
    
    return res
}

let str = convertObjectsToStringArray(objectsOnScreen)

let page = PlaygroundPage.current

if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
    var array = [PlaygroundValue]()
    
    for s in str {
        let m: PlaygroundValue = .string(s)
        array.append(m)
    }
    
    let msg: PlaygroundValue = .array(array)
    
    proxy.send(msg)
}
//#-end-hidden-code
