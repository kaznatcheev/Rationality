Rationality
===========

<h3>Summary:</h3>
Code for working on the objective-subjective rationality project. The structure is heavily borrowed from an earlier development with <a href=http://home.uchicago.edu/kjbrown/>Kyler Brown</a> for the parental investment project.

Code for regular Random Graph generation (createRandRegGraph.m) is by Golan Pundak and available <a href=http://www.mathworks.com/matlabcentral/fileexchange/29786-random-regular-generator/content/randRegGraph/createRandRegGraph.m>here</a>.

<h3>Notes:</h3>
<ul>
<li>We use a death-birth updating scheme.</li>
</ul>

<h3>Files:</h3>
<ul>
<li>'batchRunConference' is the entry code for the CogSci 2013 conference paper we wrote. It loads a graph and then runs 'recStepRun' on it.</li>
<li>'recStepRun' is the main wrapper for running the simulation. The state of agents' minds and genotypes are not recorded at every time step, because this takes too much space. Rather, an array is passed (step_array) which indicates how many steps should pass before this data is recorded.</li>
<li>'subRat' is the main file for running the simulation. At each step, it calls 'playGame', potentially randomizes the world, applies an input update rule, and then collects data with 'collectData'.</li>
<li>'playGame' goes through all of the edges of the graph and simulates the interaction given that the agents use an inputted decisionRule.</li>
<li>'ratShaky' is a decisionRule that behaves rationally with a shaky hand. This means that on the top right and bottom left corners of the game space, it uses a probabilistic strategy.</li>
<li>'ratBayShaky' is a decisionRule that behaves rationally given its p and q values, which it infers from its mind using alpha-self-absorbed learning</li>
<li>'mind2pq' converts an agent's pseudocount to p and q, given its self-absorption alpha, as given in <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>this blog post</a>.</li>
</ul>

<h3>Relevant blog posts:</h3>
<ul>
<li>March 8, 2012: <a href=http://egtheory.wordpress.com/2012/03/08/objective-subjective/>Objective and subjective rationality</a>. Overview of the the motivation for and basic structure of the model, where agents' subjective representation of the game they are playing deviates from the real thing.</li>
<li>March 14, 2012: <a href=http://egtheory.wordpress.com/2012/03/14/uv-space/>Space of cooperate-defect games</a>. The UV game space, with graph of how it is divided up.</li>
<li>March 29, 2012: <a href=http://egtheory.wordpress.com/2012/03/29/random-regular-graphs/>Generating random k-regular graphs</a>. Generating random k-regular graphs.</li>
<li>October 25, 2012: <a href=http://egtheory.wordpress.com/2012/10/25/ohtsuki-nowak-transform/>Ohtsuki-Nowak transform for replicator dynamics on random graphs</a>. Converting payoff matrices so that you can derive analytic results for games played on random regular graphs.</li>
<li>January 23, 2013: <a href=http://egtheory.wordpress.com/2013/01/23/habitual-rationality/>Habitual selfish agents and rationality</a>. Review of Davies et al. (2011), where they consider a coordination/anti-coordination game. To maximize global rather than local utility, they change their agents' utility function from an objective to a subjective one, so that it includes habituation (preferring to be paired with those you were paired with previously).</li>
<li>January 28, 2013: <a href=http://egtheory.wordpress.com/2013/01/28/subjective-bayes/>Rationality for Bayesian agents</a>. Obtaining the MLE of a rational Bayesian agent faced with a coin toss environment, and how to make decisions on this basis.</li>
<li>January 31, 2013: <a href=http://egtheory.wordpress.com/2013/01/31/need-for-social/>Extra, Special Need for Social Connections</a>. Review of the various subjective factors that have been identified and studied in experimental work on human decision making in games.</li>
<li>May 12, 2013: <a href=http://egtheory.wordpress.com/2013/05/12/quasi-magical-thinking-and-the-public-good/>Quasi-magical thinking and the public good</a>. Review of a paper by Masel (2007) concerning a public goods game. To encourage cooperation, agents use a quasi-magical thinking update scheme (consider their own potential action as a data point) when estimating how much others will contribute.</li>
<li>May 13, 2013: <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>Quasi-magical thinking and superrationality for Bayesian agents</a>. Overview of how to implement quasi-magical thinking into the model, which biases learning so that an agent's own action is treated as a data point when estimating how others will act.</li>
</ul>
