  //to do
  //x add force-scaling so that it doesn't have to dampen-oscillate around a target value
  //  x force gets weaker as the vessel gets closer to the target
  //x add a proper pattern to the sensor corrector (a concept is already made)
  //x add random forces with a "noise level" variable
  //x add velocity detection
  //x add cruise control to increase the movement precision and to rely less on drag
  //x idea: sgn(x)*sqrt(abs(x)) instead of a linear function

  //B U G S
  //x the output of the induvidual sensor outputs (sensors[n]) oscillates with a +1, +3, +1, +3 pattern at the current velocity [the velocity^2 in drag caused the oscillations]
  //like [more vel -> more drag -> less acc -> less vel -> less drag -> more acc -> more vel]

  //B U G
  //passing any ball will put the master front detector off track
  //solutions:
  //x add wider front sensors (needs to be done anyway)
  //x make it less tolerant
  //- add a backup detector that detects when you're heading for a wall and triggers a resync function
  //x add a detector for when the sensor corrector gets no data and trigger a resync function
  //N trigger resync every time the mode changes (or not, could be risky)
  //x make a resync function that syncs sensor masters that are off
  //  x recalibrate
  //  - (perhaps) use the sensor data of other sensor masters to wiggle, until a proper calibration can be made
  //  - find some data which can be used as a reference to verify the new calibration 
  //    - if the calibration was really bad then this function would probably be called again
  //this is a concept, the reality will probably be very different
