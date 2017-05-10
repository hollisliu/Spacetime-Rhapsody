# Spacetime Rhapsody
![Swift Version](https://img.shields.io/badge/Swift-3.0-orange.svg)
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg)

A Swift Playground visualizing gravity based on Einstein's Theory of General Relativity

![intro](/intro.gif)

## Introduction

In Newtonian physics, gravity is molded as a force between masses. But the reason of gravitational pull was never explained until Albert Einstein published his theory of general relativity in 1915. According to Einstein: The planets orbit the sun because the mass of sun bends the 4D **spacetime** around it so the planets move towards the curvature of spacetime it creates.

It’s very hard for us humans to imagine geometries in 4D space. To help us more intuitively understand the effect of general relativity, I created this playground: It compresses and abstracts the 3D space component of 4D spacetime into a 2D sheet of fabric. The mass of objects curves the imaginary spacetime fabric on screen and the dent of spacetime (mass) attracts other objects nearby.

Learners using this playground can:
1. create their own astronomical objects through coding without breaking the interactive scene
2. easily reposition stars and planets by dragging objects on screen.
3. give planets velocity by flicking planets towards a direction. The right amount of velocity and angle can make planets move in orbit around a star.
4. The curvature of spacetime fabric is updated in real time to give learners better pictures of the distortion effect of masses.
5. can pitch, zoom in and out the camera at any time using conventional gestures.

Keep in mind that the accurate computation of the effect of general relativity on masses is overwhelmingly complex, therefore this playground is merely a simplified visualization. If you wish to learn more about general relativity, please refer to more resources online and in libraries.

## Origin
This is an playground is my WWDC 17 student scholarship submission and it has been ported into an app. Download for free [here](https://itunes.apple.com/us/app/spacetime-rhapsody/id1234128065?mt=8)

## Installation

Download the playground package and open it through the Swift Playgrounds app on iPad. Alternatively, you can explore the features using the ported [app](https://itunes.apple.com/us/app/spacetime-rhapsody/id1234128065?mt=8).

## Tutorial

Adjust the camera angle by a **2 finger swipe**. You can get a clearer view of the curvature if you align the camera underneath the plane of spacetime fabric.

**Zoom** in or out by pinching to get your desired field of view.

You can also move around any object in the scene by simply **dragging**.


Here is a challenge: can you make a simple solar system like the one from last page?

Choose the planets or stars you want to experiment from the planets menu by tapping the planet icon on the top left corner. After that, All you need to do is:

1. place the sun some where on the spacetime fabric by dragging

2. drag in planets one at a time (do not let go before the next step)

3. flick the planet at the right angle and right speed towards the sun

It might take a few tries to make a planet orbiting but you’ll get the hang of it.

## References

References

Visuals:
 Sun Texture
 Venus Texture
 Earth Texture
 Mars Texture
 Jupiter Texture
 Neptune Texture
 License: Creative Commons Attribution 3.0 Unported
 Source: http://www.solarsystemscope.com/nexus/textures/planet_textures/

 Neutron Star Texture (Not an actual neutron star texture but I used it for its color)
 Source and License: https://nasa3d.arc.nasa.gov/detail/sat5vss2

 Skybox
 Source and License: http://forum.kerbalspaceprogram.com/index.php?/topic/41369-0211universereplacer-dreamscape-skybox-pack/


Audio:
 Background Music (Ravel: String Quartet in F major)
 Players: Musicians from Marlboro (string quartet)
 Source: http://imslp.org/wiki/String_Quartet_in_F_major_(Ravel,_Maurice)
 License: Creative Commons Attribution Non-commercial No Derivatives 3.0


 Fabric Stretching sound:
 License: Creative Commons 0 License
 Source: https://www.freesound.org/people/Huminaatio/sounds/266979/
