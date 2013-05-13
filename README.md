Rationality
===========

Summary:
Code for working on the objective-subjective rationality project. The structure is heavily borrowed from an earlier development with Kyler Brown for the parental investment project.

Code for regular Random Graph generation (createRandRegGraph.m) is by Golan Pundak and available <a href=http://www.mathworks.com/matlabcentral/fileexchange/29786-random-regular-generator/content/randRegGraph/createRandRegGraph.m>here</a>.

General Notes:
We use a death-birth updating scheme.

Files:
'batchRunConference' is the entry code for the CogSci 2013 conference paper we wrote. It loads a graph and then runs 'recStepRun' on it.

'recStepRun' is the main wrapper for running the simulation. The state of agents' minds and genotypes are not recorded at every time step, because this takes too much space. Rather, an array is passed (step_array) which indicates how many steps should pass before this data is recorded.

'subRat' is the main file for running the simulation. At each step, it calls 'playGame', potentially randomizes the world, applies an input update rule, and then collects data with 'collectData'

'playGame' goes through all of the edges of the graph and simulates the interaction given that the agents use an inputted decisionRule.

'ratShaky' is a decisionRule that behaves rationally with a shaky hand. This means that on the top right and bottom left corners of the game space, it uses a probabilistic strategy.

'ratBayShaky' is a decisionRule that behaves rationally given its p and q values, which it infers from its mind using alpha-self-absorbed learning

'mind2pq' converts an agent's pseudocount to p and q, given its self-absorption alpha, as given in <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>this blog post</a>.

Relevant blog posts:
March 8, 2012: <a href=http://egtheory.wordpress.com/2012/03/08/objective-subjective/>Objective and subjective rationality</a>. An overview of the the motivation for, and basic structure of, the model, where agents' subjective representation of the game they are playing deviates from the real thing.
January 23, 2013: <a href=http://egtheory.wordpress.com/2013/01/23/habitual-rationality/>Habitual selfish agents and rationality</a>. Review of a paper by Davies et al. (2011) where they consider a coordination/anti-coordination game. To maximize global rather than local utility, they change their agents' utility function from an objective to a subjective one, so that it includes habituation (preferring to be paired with those you were paired with previously).
January 28, 2013: <a href=http://egtheory.wordpress.com/2013/01/28/subjective-bayes/>Rationality for Bayesian agents</a>. Shows how to obtain the MLE of a rational Bayesian agent faced with a coin toss environment and how to make decisions on this basis.
January 31, 2013: <a href=http://egtheory.wordpress.com/2013/01/31/need-for-social/>Extra, Special Need for Social Connections</a>. A review of the various subjective factors that have been identified and studied in experimental work on human decision making in games.
May 12, 2013: <a href=http://egtheory.wordpress.com/2013/05/12/quasi-magical-thinking-and-the-public-good/>Quasi-magical thinking and the public good</a>. Review of a paper by Masel (2007) concerning a public goods game. To encourage cooperation, agents use a quasi-magical thinking update scheme (considering their own potential action as a data point) when using Bayes to determine how much others will contribute.
May 13, 2013: <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>Quasi-magical thinking and superrationality for Bayesian agents</a>. An overview of how to implement quasi-magical thinking into the model, which biases learning so that an agent's own action is treated as a data point.
