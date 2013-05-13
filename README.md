Rationality
===========

Summary:
Code for working on the objective-subjective rationality project. The structure is heavily borrowed from an earlier development with Kyler Brown for the parental investment project.

Code for regular Random Graph generation (createRandRegGraph.m) is by Golan Pundak and available here:
http://www.mathworks.com/matlabcentral/fileexchange/29786-random-regular-generator/content/randRegGraph/createRandRegGraph.m

General Notes:
We use a death-birth updating scheme.

Files:
batchRunConference is the entry code for the CogSci 2013 conference paper we wrote. It loads a graph and then runs recStepRun on it.

recStepRun is the main wrapper for running the simulation. The state of agents' minds and genotypes are not recorded at every time step, because this takes too much space. Rather, an array is passed (step_array) which indicates how many steps should pass before this data is recorded.

subRat actually runs the simulation.

Relevant blog posts:
March 8, 2012

http://egtheory.wordpress.com/2012/03/08/objective-subjective/
<a href=http://egtheory.wordpress.com/2012/03/08/objective-subjective/>testHTML</a>
[url=http://egtheory.wordpress.com/2012/03/08/objective-subjective/]testURL[/url]
