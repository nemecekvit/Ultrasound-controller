# Ultrasound-controller
## Team
+ [Vit Nemecek](https://github.com/nemecekvit)
+ [Jiri Kozarek](https://github.com/jir14)
+ [Dominik Nadvornik](https://github.com/nadvornikd)
## Abstract
Our goal was creating modular system for ultrasonic sensors on Nexys A7-50T platform. In our design we are using connectors (pins) on the board to connect the sensors. This solution can handle upto 15 connected senser at the same time. As a sensor it uses [Ultrasonic Ranging Module HC - SR04](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf). It can measure upto 4 meters at claimed accuracy of sensors of 3 mm.
**[Poster here](/docs/plakat2.png)**
## Hardware description
As said, this solution uses [Nexys A7-50T FPGA platform from Digilent](https://digilent.com/reference/programmable-logic/nexys-a7/start) and [Ultrasonic Ranging Module HC - SR04](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf). With this selection of parts we have built system, which can display the senser ID and display it's value on 7 segmnets display available on the board.

### Physical realization
Part of our job was to build the designed project from components available in the lab. This is a picture of functional version of our product.
The whole realization is displayed below.

![realization](/docs/photos/all.jpg)

#### Nexys A7-50T board
As you can see in the picture the 7 segments are diveded into two parts. Left part displays sensor number which is selected by switches under the segments. Display select doesn't work in binary but as input selector of individual input pins on the port as shown. You can select which sensor to yous by switching on the switch that represents the sensor number from the left to right. Only one sensor can be selected. Otherwise, it's considered as falls state and all zeroes are displayed.

![photo of functional Nexys board](/docs/photos/board.jpg)

#### Breadboard
This implementation is considering only four sensors, eventho software and hardware is ready to handle upto 15 sensors at once. There are four sensors located at the edges of the breadboard itself. Sensors are powered by power rail in the middle that is powered by arduino which can be seen at the right top [here](#physical-realization).

Data pins from sensors are connected through voltrage devider (5k and 10k respectivaly) to the Nexys board through wide paralel connection on the right top corner. Voltage devider lowers the output signal voltage to acceptable level for the board.

![photo of breadboard](/docs/photos/breadboard.jpg)

## Software description
As far as software goes, we settled that dividing software development to multiple parts, three to be exact, is the best way for us. Overyone is responsible for own code and its functionality. Thus, we established design shown below.
![top_level diagram](/Diagrams/Toplevel.svg)

### Sensor driver
<i>Responsible team members: [Vit Nemecek](https://github.com/nemecekvit)</i><br>
As name implays, it's purpose is to drive ultrasonic sensors and outputing binary that represents the distance from object in mms.
Sensor driver is responsible for creation and processing of signals used with [ HC - SR04](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf). As written in specification, for Ultrasound module to activate, it need to recieve at least 10 us high signal into trigger input. The manufactures also suggest that measurement cycle is no shorter then 60 ms. 
After activation the module will raise high level on echo which duration is in proportion of range measured. Total range can be calculated using formula:
`Range = (High Level Time * 340) / 2`

- High Level Time = time in seconds  
- Velocity = 340 m/s (speed of sound in air)
- Range = total range in meters

For this implementaiton, rather than working with with decimal numbers, it si better to essentially count have many milimeters the sound traveled. For this we use that 1 mm is proportionate to 5.8 us of round trip travel time.

Diagram shows internal implementation of this component.
![sensor_driver diagram](/Diagrams/sensor_driver.svg)

Simulation of [sensor driver](/test_benches/sensor_driver_tb.vhd) showing trigger signal and output signal derived from echo in.
![simulation of sensor driver](/docs/photos/sensor_driver_tb.png)

### Display driver
<i>Responsible team members: [Dominik Nadvornik](https://github.com/nadvornikd)</i><br>
Purpose of this part is to display distance values on 7 segment display array.
Display controller component takes 12-bit number provided by [Sensor select](#sensor-select) and converts it into 16-bit BCD number using [shift and add 3 algorithm]( https://en.wikipedia.org/wiki/Double_dabble). Next step is splitting the 16-bit number into four 4-bit values, each representing a single digit. These digits are then displayed on 7-segment displays 0, 1, 2 and 3, allowing us to display numbers up to 4095mm. Display controller also receives one more input representing which sensor is selected, which it converts to BCD number shown on 7-segment display 7. Each display is refreshed every 10 ms. Since there are 5 displays to update, the entire display system is refreshed every 50 ms, or 20 times per second.

Diagram shows internal implementation of this component.
![display_driver diagram](/Diagrams/display_controller.svg)
### Sensor select
<i>Responsible team members: [Jiri Kozarek](https://github.com/jir14)</i><br>
Purpose of this component is to switch imputs from connected [Sensor driver](#sensor-driver) to [Display driver](#display-driver). It's done by asynchronous sensor_select.vhd component which selects connected sensors based on combination set on switches SW[15-12]. Activated switch represents selected sensor (!not binary value of sensor!).


This component is so simple so it does not need it's own internal diagram. It's already displayed on Toplevel diagram mentioned [below](#top-level).

Simulation of [sensor select](/test_benches/sensor_select_tb.vhd).
![simulation of sensor select](/docs/photos/sensor_select_tb.png)

### Top level
<i>Responsible team members: [Jiri Kozarek](https://github.com/jir14)</i><br>
This component connects all the other componets together to the functional unit. It represents virtual connections between individual parts and real hardware I/O that's nessesarry to connect and interact with sensors.
![top level diagram](/Diagrams/Toplevel.svg)

### Documentation
<i>Responsible team members: [Jiri Kozarek](https://github.com/jir14)</i><br>
It was decided that the team member responsible for sensor_select component will be resposible for documentation as well as all diagrams and this README file.

## Sources
+ [Tomas Fryza's GitHub page](https://github.com/tomas-fryza/vhdl-labs)
+ [Nexys A7-50T FPGA platform from Digilent](https://digilent.com/reference/programmable-logic/nexys-a7/start)
+ [Ultrasonic Ranging Module HC - SR04](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf)
+ [Online VHDL Testbench Template Generator](https://vhdl.lapinoo.net/)
+ [OpenAI ChatGTP](https://openai.com/) - used for creation of testing data
