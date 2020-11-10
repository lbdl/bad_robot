# BAD ROBOT

## This was a response to a problem that goes as follows:

### The scenario 

* A set of remote operated robots on the Martian surface need to be able to read and then execute a set of instructions.
* The surface of MARS is considered a FLATEARTH of dimention ` X by Y` and anything that goes over the edge is lost FOREVER. 
Well not quite because it speaks from the grave as it were given that if the robot falls off of the edge it leaves a scent marker to save other robots from its fate.
* There are `X` bots and each one take a an instruction string.
* The commands the bots understand are;
  * `L`,`R`,`F`
* The instructions come as a file of the follwing format:
  * The first line defines the upper right coordinate postion, lower left is assumed to be `0,0`
  * The rest of the file consist of robot instructions and positions (2 lines per bot), a position is specified by 2 space seperated integers and a direction indicator `[N,E,S,W]`
  and the next line consists of a sequence of move instructions i.e. `L`,`R`,`F` with no seperator
  * Bot instructions are sperated by a blank line.
* The file is processed sequentially, i.e. each bot is run and then the next and the next etc.
* The MAX of any coordinate is 50
* The max instruction set is 100 characters.

__NB__ Line endings not specified but assumed to be whatever native EOL indicator is

### Sample input

```
5 3
1 1 E
RFRFRFRFLLFFRFFFR

3 2 W
LLFFFRFLFLFFFRRFFL
```

No UI was specified and as such I just took the opportunity to mess about with tail recursion and file parsing etc. (because I'd still like to be able to LISP!) There are no tests nor is the `scent` task implemented though its simple to add.
It was in the final conclusion suppposed to be a quick test (and I'm never sure quite what that means)

So the project consists of a tail recursive file parser that creates the necessary data structures and a tail recursive `engine` that runs the `bots`.

### Thoughts

Swift is not a tail call recursion optimised language ergo were this was "real" then it's perhaps not the best solution but the specs do specify the limits so, you know, recurse away...
