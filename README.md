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

<h3>Summary:</h3>
Code for working on the objective-subjective rationality project. The overall code structure is heavily borrowed from an earlier development with <a href=http://home.uchicago.edu/kjbrown/>Kyler Brown</a> for the parental investment project.

Code for regular Random Graph generation (createRandRegGraph.m) is by Golan Pundak and available <a href=http://www.mathworks.com/matlabcentral/fileexchange/29786-random-regular-generator/content/randRegGraph/createRandRegGraph.m>here</a>.

<h3>Notes:</h3>
<ul>
<li>We use a death-birth updating scheme, which is implemented in <i>'deathBirth'</i></li>
</ul>

<h3>Files:</h3>
<ul>
<li><i>'batchRunConference'</i> is the entry code for the CogSci 2013 conference paper we wrote. It loads a graph and then runs 'recStepRun' on it.</li>
<li><i>'recStepRun'</i> is the main wrapper for running the simulation. The state of agents' minds and genotypes are not recorded at every time step, because this takes too much space. Rather, an array is passed (step_array) which indicates how many steps should pass before this data is recorded.</li>
<li><i>'subRat'</i> is the main file for running the simulation. At each step, it calls 'playGame', potentially randomizes the world, applies an input update rule, and then collects data with 'collectData'.</li>
<li><i>'playGame'</i> goes through all of the edges of the graph and simulates the interaction given that the agents use an inputted decisionRule.</li>
<li><i>'ratShaky'</i> is a (decisionRule) that behaves rationally with a shaky hand. This means that on the top right and bottom left corners of the game space, it uses a probabilistic strategy.</li>
<li><i>'ratBayShaky'</i> is a (decisionRule) that behaves rationally given its p and q values, which it infers from its mind using alpha-self-absorbed learning</li>
<li><i>'mind2pq'</i> converts an agent's pseudocount to p and q, given its self-absorption alpha, as given in <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>this blog post</a>.</li>
<li><i>'repLocalMutate'</i> is a (reproduce) that mutates U,V with probability mutation_rate within [U +- mutation_size] and [V +- mutation_size].</li>
<li><i>'saveRegRandGraph'</i> is used to generate a regular random graph and save the adjacency matrix</li>
<li><i>'genoRantInit'</i> created a random initial distribution of genotypes.
</ul>

<h3>Relevant blog posts:</h3>
<ul>
<li>March 8, 2012: <a href=http://egtheory.wordpress.com/2012/03/08/objective-subjective/>Objective and subjective rationality</a>. Overview of the the motivation for and basic structure of the model, where agents' subjective representation of the game they are playing deviates from the real thing.</li>
<li>March 14, 2012: <a href=http://egtheory.wordpress.com/2012/03/14/uv-space/>Space of cooperate-defect games</a>. The U,V game space, with graph of how it is divided up.</li>
<li>March 29, 2012: <a href=http://egtheory.wordpress.com/2012/03/29/random-regular-graphs/>Generating random k-regular graphs</a>. Generating random k-regular graphs.</li>
<li>October 25, 2012: <a href=http://egtheory.wordpress.com/2012/10/25/ohtsuki-nowak-transform/>Ohtsuki-Nowak transform for replicator dynamics on random graphs</a>. Converting payoff matrices so that you can derive analytic results for games played on random regular graphs.</li>
<li>January 23, 2013: <a href=http://egtheory.wordpress.com/2013/01/23/habitual-rationality/>Habitual selfish agents and rationality</a>. Review of Davies et al. (2011), where they consider a coordination/anti-coordination game. To maximize global rather than local utility, they change their agents' utility function from an objective to a subjective one, so that it includes habituation (preferring to be paired with those you were paired with previously).</li>
<li>January 28, 2013: <a href=http://egtheory.wordpress.com/2013/01/28/subjective-bayes/>Rationality for Bayesian agents</a>. Obtaining the MLE of a rational Bayesian agent faced with a coin toss environment, and how to make decisions on this basis.</li>
<li>January 31, 2013: <a href=http://egtheory.wordpress.com/2013/01/31/need-for-social/>Extra, Special Need for Social Connections</a>. Review of the various subjective factors that have been identified and studied in experimental work on human decision making in games.</li>
<li>May 12, 2013: <a href=http://egtheory.wordpress.com/2013/05/12/quasi-magical-thinking-and-the-public-good/>Quasi-magical thinking and the public good</a>. Review of a paper by Masel (2007) concerning a public goods game. To encourage cooperation, agents use a quasi-magical thinking update scheme (consider their own potential action as a data point) when estimating how much others will contribute.</li>
<li>May 13, 2013: <a href=http://egtheory.wordpress.com/2013/05/13/quasi-magical-thinking-and-superrational-bayesian/>Quasi-magical thinking and superrationality for Bayesian agents</a>. Overview of how to implement quasi-magical thinking into the model, which biases learning so that an agent's own action is treated as a data point when estimating how others will act.</li>
</ul>
