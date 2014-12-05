Rationality
===========
<h3>Abstract</h3>
<b>Evolving cooperation by useful delusions: subjective rationality and quasi-magical thinking</b>
<br />by Artem Kaznatcheev<sup>1,2</sup>, Marcel Montrey<sup>2</sup>, and Thomas R. Shultz<sup>2,1</sup>
<br /><sup>1</sup>School of Computer Science and <sup>2</sup>Department of Psychology, McGill University

The role of subjective experience in human decision-making has been often ignored, or assumed to be
too difficult to study. We combine ideas from biology, cognitive science, computational modeling,
dynamic systems, and economics to introduce an evolutionary game theoretic framework for studying
quasi-magical thinking and the distinction between objective and subjective rationality. The
evolutionary fitness payoffs of interactions are given by an objective game which the agents are not
aware of. Instead, each agent has a heritable subjective representation of what they think the game is on
which they base their decision-making. The agents' minds consist of two probabilities: “will an agent
cooperate with me if I cooperate/defect?” Since no agent can condition their behavior on the decision
of another, any disagreement in these two probabilities is a misrepresentation of the world. We consider
three different Bayesian updating techniques: purely rational, quasi-magical, and superrational. Given
the genetic conception of the game and learned probabilities of cooperation, the agents act rationally on
their beliefs (selecting the action that they believe to have the highest expected utility) .

We apply our framework to study the evolution of cooperation on k-regular random graphs. In this task,
agents populate the nodes of a graph and engage in a pair-wise prisoners' dilemma interaction with their
neighbors: an agent can maximize personal utility by defecting, but this decision minimizes social
welfare and the whole population would be better off if everyone cooperates. We show that in highly
specialized environments where cooperation incurs mild cost to the individual, the agents evolve
misrepresentations of objective reality that lead them to cooperate and maintain higher social welfare.
The agents act rationally on their delusions of the world but appear to behave irrationally when viewed
by an external observer. In environments where the cost of cooperating is high, the standard prediction
of universal defection is still achieved.

We consider two interpretations of the results. If the 'experimenter knows best' then evolution does not
necessarily lead to accurate internal representations of the world, and the resulting misrepresentations
are not always detrimental to individual or group performance. If 'evolution knows best' then pair-wise
payoffs are not necessarily accurate depictions of the real game being played, and an overly
reductionist account of the world can miss the social externalities inherent in decision-making. We
discuss the connection between the evolved internal representations and inclusive fitness. Our
simulations point out the importance of reasoning about internal representations and not just observed
behavior when looking at economics or biology. Finally, we argue that our framework is a good
foundation for combining evolution and learning since it captures the impossibility of defining an
objective utility/fitness of memes if imitation dynamics are considered at the level of behavior.


<h3>Notes</h3>
<ul>
<li>Some code structure is borrowed from an earlier code by <a href=http://home.uchicago.edu/kjbrown/>Kyler Brown</a> and Artem for the parental investment project.
<li>We use a death-birth updating scheme, which is implemented in <i>deathBirth</i></li>
<li>Code for regular Random Graph generation (createRandRegGraph.m) is by Golan Pundak and available <a href=http://www.mathworks.com/matlabcentral/fileexchange/29786-random-regular-generator/content/randRegGraph/createRandRegGraph.m>here</a>.</li>
<li>The current convention for storing data in '../RationalityData/' is 'U' + X + 'V' + Y + 'b' + s + f +  v + 'e' + b where:<ul>
<li>[X,Y] is the game,</li> 
<li>s = <i>no</i>, <i>2</i>, or <i>all</i> corresponding to if we allow no-alpha, or no-alpha and quasi-magical thinking, or all alpha from 0 to 1 respectively,</li>
<li>f = <i>i</i> or <i>v</i> depending on if the simulation is inviscid or viscous,</li>
<li>v is an integer corresponding the run number, and</li>
<li>b is a flag if evolution of internal representations is turned off (0) or on (1)</li>
</ul></li>
</ul>

<h3>Functions</h3>
<ul>
<li><i>batchRunConference</i> is the entry code for the CogSci 2013 conference paper we wrote. It loads a graph and then runs 'recStepRun' on it.</li>
<li><i>batchRunAlphaConf</i> is the code we used to generate data for the SwarmFest conference. It takes (1) a PD depth, (2) whether to allow U and V values to evolve, (3) a graph to load, (4) the number of runs, (5) whether to output data, and then runs 'recStepRun'. 
<li><i>recStepRun</i> is the main wrapper for running the simulation. The state of agents' minds and genotypes are not recorded at every time step, because this takes too much space. Rather, an array is passed (step_array) which indicates how many steps should pass before this data is recorded.</li>
<li><i>subRat</i> is the main file for running the simulation. At each step, it calls 'playGame', potentially randomizes the world, applies an input update rule, and then collects data with 'collectData'.</li>
<li><i>playGame</i> goes through all of the edges of the graph and simulates the interaction given that the agents use an inputted decisionRule.</li>
<li><i>ratShaky</i> is a (decisionRule) that behaves rationally with a shaky hand. This means that on the top right and bottom left corners of the game space, it uses a probabilistic strategy.</li>
<li><i>ratBayShaky</i> is a (decisionRule) that behaves rationally given its p and q values, which it infers from its mind using alpha-self-absorbed learning</li>
<li><i>mind2pq'</i> converts an agent's pseudocount to p and q, given its self-absorption alpha, as given in <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>this blog post</a>.</li>
<li><i>repLocalMutate</i> is a (reproduce) that mutates U,V with probability mutation_rate within [U +- mutation_size] and [V +- mutation_size].</li>
<li><i>repSetMutate</i> is a (reproduce) that mutates U,V with probability mutation_rate within a finte set of choices.</li>
<li><i>saveRegRandGraph</i> is used to generate a regular random graph and save the adjacency matrix</li>
<li><i>genoRantnit</i> created a random initial distribution of genotypes.</li>
<li><i>plotCoop</i> is used to make the nice proportion of cooperation plots.</li>
<li><i>alphaPDdepthPlot</i> generates plots of the average alpha value (or the average number of agents using alpha, if this is binary) across PD depths.</li>
<li><i>coopPDdepthPlot</i> generates plots of the average proportion of cooperation across PD depths.</li>
<li><i>densityPDdepthPlot</i> generates density plots of agent UV values across PD depths.</li>
</ul>

<h3>Relevant blog posts</h3>
<ul>
<li>
  March 8, 2012: <a href=http://egtheory.wordpress.com/2012/03/08/objective-subjective/>Objective and subjective rationality</a>. 
  Most work on the interaction of learning and evolution assumes that the representations learning acts on accurately reflect the same reality that generates fitness. 
  I question this assumption and introduce the general outline for a model that seperates subjective representations of the inter-agent interaction from their objective fitness effects.
</li><li>
  March 14, 2012: <a href=http://egtheory.wordpress.com/2012/03/14/uv-space/>Space of cooperate-defect games</a>. 
  By removing additive constants and renormalizing, it is possible to represent the payoffs of any two strategy two player cooperate-defect game with just two parameters U and V. 
  We can plot these parameters to visualize the U-V space of possible qualitatively distinct games.
</li><li>
  March 21, 2012: <a href="http://egtheory.wordpress.com/2012/03/21/spatial-structure/">Spatial structure</a>.
  Agents in evolution games seldom inhabit a purely mixed environment where they are equally likely to interact with any other agent.
  In a more general settings, you have to consider settings where agents only interact with a specific subset of other agents.
  This interaction structure can be represented as a network or graph, and the choice of graph which agents inhabit is very important for the resulting evolutionary dynamics.
</li><li>
  March 29, 2012: <a href=http://egtheory.wordpress.com/2012/03/29/random-regular-graphs/>Generating random k-regular graphs</a>. 
  One of the simplest structured environments are the random k-regular graphs.
  Being simple to describe, however, does not mean that they are easy to generate, so Marcel discusses some methods for creating these graphs.
</li><li>
  October 25, 2012: <a href=http://egtheory.wordpress.com/2012/10/25/ohtsuki-nowak-transform/>Ohtsuki-Nowak transform for replicator dynamics on random graphs</a>. 
  One of the biggest advantages of studying dynamics on random regular graphs, is that there exists a tool for solving their dynamics analytically. 
  The Ohtsuki-Nowak transform allows you to perturb the game's payoff matrix to incorporate the spatial structure and then study the modified game as if it was governed by inviscid replicator dynamics. 
</li><li>
  January 23, 2013: <a href=http://egtheory.wordpress.com/2013/01/23/habitual-rationality/>Habitual selfish agents and rationality</a>. 
  Marcel reviews Davies et al. (2011), where the authors consider a coordination/anti-coordination game. 
  To maximize global rather than local utility, the authors change their agents' utility function from an objective to a subjective one, so that it includes habituation: i.e. referring to be paired with those you were paired with previously.
</li><li>
  January 28, 2013: <a href=http://egtheory.wordpress.com/2013/01/28/subjective-bayes/>Rationality for Bayesian agents</a>. 
  I derive the maximum likelihood estimator for a rational Bayesian agent faced with a coin toss environment. 
  This allows the agent to make decisions when the rational choice is not the unique pure strategy of cooperation nor defection.
</li><li>
  January 31, 2013: <a href=http://egtheory.wordpress.com/2013/01/31/need-for-social/>Extra, Special Need for Social Connections</a>. 
  Tom provides a review of the various subjective factors that have been identified and studied in experimental work on human decision making in games based on Lee (2008).
</li><li>
  May 12, 2013: <a href=http://egtheory.wordpress.com/2013/05/12/quasi-magical-thinking-and-the-public-good/>Quasi-magical thinking and the public good</a>. 
  Marcel reviews Masel's (2007) work on quasi-magical thinking in the public goods game. 
  To encourage cooperation, agents use a quasi-magical thinking update scheme (consider their own potential action as a data point) when estimating how much others will contribute.
</li><li>
  May 13, 2013: <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>Quasi-magical thinking and superrationality for Bayesian agents</a>. 
  Quasi-magical thinking can be implemented in the subjective-objective rationality model by biasing the learning of others reactions so that an agent's own action is treated as a data point when estimating how others will act.
  The strength of this bias can be varied by changing the weight an agent gives to their own action.
  In the extreme case of assigning full weight to your own action and none to the partner, the result is Hofstadter’s superrationality.
</li><li>
  May 23, 2013: <a href="http://egtheory.wordpress.com/2013/05/23/quasi-delusions-and-inequality-aversion/">Quasi-delusions and inequality aversion</a>. 
  Inequality aversion is a common bias believed to facilitate cooperation.
  Subjective rationality can be represented in terms of this bias and its interaction with objective reality can be understood in the broader framework of quasi-delusions.
</li><li>
  July 9, 2013: <a href="http://egtheory.wordpress.com/2013/07/09/evolving-useful-delusions-to-promote-cooperation/">Evolving useful delusions to promote cooperation</a>.  
  Transcript of my presentation from March 27th, also covering part of SWARMFEST presentation from July 9th. 
  I outline the subjective-objective rationality model and present results on the distribution of agent's subjective utilities.
  In highly competitive environments, agents evolve faithful representations of reality that lead them to defection.
  In less competitive but still Prisoner's dilemma environments, cooperation emerges from agents misrepresenting the objection payoff of the game.
</li><li>
  October 16, 2013: <a href="http://egtheory.wordpress.com/2013/10/16/qmt-and-su/">Cooperation through useful delusions: quasi-magical thinking and subjective utility</a>.
  A discussion and some results on how quasi-magical thinking and subjective rationality interact.
  Evolutionary control over subjective representations results in higher levels of cooperation than control over quasi-magical thinking.
  Althought allowing for both misrepresentations and quasi-magical thinking to exist together allows for more genotypic flexibility, the resulting dynamics lead to lower levels of cooperation.
</li><li>
  October 20, 2013: <a href="http://egtheory.wordpress.com/2013/10/20/enriching-egt/">Enriching evolutionary games with trust and trustworthiness</a>.
  Tom discusses McNamara's (2013) suggestion for incorporating richer decision making procedures and phenotypic effects into evolutionary game theoretic models.
  He draws special attention to models that incorporate truth and trusthworthiness, contrasting them with more common studied reputation effects.
</li><li>
  January 28, 2014: <a href="http://egtheory.wordpress.com/2014/01/28/interface-theory-of-perception/">Interface theory of perception can overcome the rationality fetish</a>.
  Hoffman's interface theory of perception questions the assumption that our perception fautfully reflects reality.
  Evolution does not select for the most accurate perception but for the most useful, so perception instead tunes itself to fitness.
  Mark, Marion, & Hoffman (2010) demonstrate this with a simple evolutionary model of resource spot selection, and I discuss how the subjective-objective rationality model can provide even further insights.
</li><li>
  May 4, 2014: <a href="http://egtheory.wordpress.com/2014/05/04/useful-delusions-interface-theory-of-perception-and-religion/">Useful delusions, interface theory of perception, and religion</a>.
  An explanation of how our model is a social extentsion of Hoffman's interface theory of perception, and a discussion of religion as a potential domain of application.
</li><li>
  November 1, 2014: <a href="https://egtheory.wordpress.com/2014/11/01/real-to-interface/">From realism to interfaces and rationality in evolutionary games</a>.
  A non-technical overview of the distinction between naive realism, critical realism, and interface theories of perception.
  I discuss Mark et al.'s (2010) evolutionary justification for interface theories, and how our work extends this to social interfaces.
</li><li>
  November 30, 2014: <a href="https://egtheory.wordpress.com/2014/11/30/interface-philosophy/">Realism and interfaces in philosophy of mind and metaphysics</a>.
  The distinction between naive realism, critical realism, and interfaces is of interest to more than just students of perception, it has a rich philosophical history.
  Various kinds of materialist realisms can be associated with Epicurus and Bertrand Russell, and a non-material critical realism with Plato.
  Interface theories can be traced back to Parmenides, and are well developed by medieval Muslim thinkers like Averroes, Ibn Arabi, and Rumi.
  The best modern treatment of interfaces was given by Kant, and we can apply it to better understand Bohr's interpretation of quantum mechanics.
</li>
</ul>
