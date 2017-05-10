/*:
 Here is a **challenge**: can you make a simple solar system like the one from last page?
 
 The code for generating the sun and planets has been written. All you need to do is:
 
 1. place the sun some where on the spacetime fabric by dragging
 2. drag in planets one at a time (do not let go before the next step)
 3. flick the planet at the right angle and right speed towards the sun
 
 It might take a few tries to make a planet orbiting but you’ll get the hang of it.
 
 **We'll dive into coding in the next page but if want to play around with it please feel free
 to modify the code below**
*/
// This is an array of all the planets and stars you'd like to add
var objectsOnScreen = [AstronomicalObject]()

// Add your choices of objects here
objectsOnScreen.append(AstronomicalObject(name: .sun, type: .star))
objectsOnScreen.append(AstronomicalObject(name: .earth, type: .planet))
objectsOnScreen.append(AstronomicalObject(name: .mars, type: .planet))

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
