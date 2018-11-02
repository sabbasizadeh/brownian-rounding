# Sticky Brownian Rounding and its Applications to Constraint Satisfaction Problems
This is an implementation of the algorithms described in the paper "Sticky Brownian Rounding and its Applications 
to Constraint Satisfaction Problem" for getting the approximation factors.

## 1. Extensions of the Brownian Rounding
We consider the following extensions:
1.1. Brownian Rounding with Slowdown 
1.2. Higher-Dimension Brownian Rounding

### 1.1. Brownian Rounding with Slowdown
Here, we describe how we obtain the approximation factors of the introduced rounding algorithms, numerically.
First, let us define what a _configuration_ is. 
Let $\textbf{v}_0,\textbf{v}_1,\ldots, \textbf{v}_n$ be the solution vectors of the SDP relaxation.
Each subset of size $d$ of these vectors forms a $d$-dimensional spatial configuration.
Based on the problem that we want to solve, we are only interested in particular values of $d$. For example, in all 
of the binary Max-2-CSP problems that we consider, we are interested in 3-dimensional configurations consisting of
$\textbf{v}_0$ and two other vectors.

The idea is that for a given configuration, we can find its contribution in the SDP relaxation (based on the objective of 
the relaxation).
Moreover, we are able to compute the expected value of the rounding procedure.
Thus, we determine the expected approximation ratio of the rounding for this specific configuration. 
By repeating this procedure on all of the feasible configurations for a problem of interest (e.g., Max-Cut), and taking 
their minimum, we will find the expected approximation factor of the rounding algorithm on this problem for all instances.

In order to enumerate all the configurations, we need to discretize the space of possible configurations.
The discretization can be done based on the representation that we choose for $\textbf{v}_i$. 
As defined in the paper, we can write each vector $\textbf{v}_i$ as $\textbf{v}_i = x_i \textbf{v}_0+ \textbf{w}_i$. 
Based on this notation, each two vectors $\textbf{v}_i$ and $\textbf{v}_j$ can be realized by having $x_i$ and $x_j$ and 
also the angle between vectors $\textbf{w}_i$ and $\textbf{w}_j$, denoted by $\theta_{ij}$. 
In other words, each configuration is of the form $conf_{ij} = (x_i, x_j, \theta_{ij})$, where $x_i,x_j \in [0,1]$ and 
$\theta_{ij} \in [0, \pi]$. 
Note that $conf_{i,j}$ implicitly considers $\textbf{v}_0$ as well.
The whole process of finding the approximation factor of a given problem is described in Algorithm 1. 
In what follows, $obj_C(x_i,x_j, \theta_{ij})$ is equivalent with $p_C(x)$ as defined in the preliminaries with a slight 
change that $obj_C(x_i,x_j, \theta_{ij})$ explicitly states the objective of clause $C$ in terms of its inputs 
(instead of $x_i, x_j$ and $x_{ij}$).

![Algorithm 1](https://github.com/sabbasizadeh/brownian-rounding/blob/master/alg1.png "Algorithm 1")

Algorithm 1 discards all the configurations which violate the triangle inequalities as they cannot be appeared in the 
solution of the SDP.
Code `approximation_ratio_finder.sage` implements Algorithm 1.
However, Algorithm 1 uses subroutine ${\sc{Get-Rounding-Value($conf_{ij}$)}}$ that returns the expected value of the rounding algorithm
for $conf_{ij}$.
This value can be computed (in expectation) using two different approaches:
1. Directly simulating the algorithm's diffusion process and repeating it sufficiently many times to obtain the expected value of
the rounding with high probability.
`brownian_simulation.sage` is the Sage implementation of this approach.
2. Numerically solving the corresponding boundary value PDE of the process which is also equivalent to the expected rounded value. 
`brownian_probability_generator.m` is a Mathematica code which implements this approach.

We implemented both of these approaches for the walk with $\alpha=0$, and as we expected, we observed that the results of these 
two approaches are consistent.
Nonetheless, in all of the reported results, we employed the PDE approach for computing ${\sc{Get-Rounding-Value($conf_{ij}$)}}$. 
(I.e., in order to get the final approximation result, you should run `brownian_probability_generator.m` and then feed its 
output to `approximation_ratio_finder.sage`.)
Note that from the practical point of view, it is straightforward to extend this framework to higher dimensional configurations as
long as we have enough computational power.


### 1.2. Higher-Dimension Brownian Rounding
In order to find the approximation ratio of the Max-DiCut problem, we used the higher-dimension algorithm in the paper.
Code `dicut-ratio-finder.sage` is the Sage implementation of the mentioned problem which again uses the probabilities found with 
`brownian_probability_generator.m` to find the approximation ratio of Max-DiCut.

## 2. Sum of Squares Proofs 
In order to use the maximum principle for a proposed function $g$, we have used proofs using sum of squares methods 
to show that:  
(1) $\mathcal{L}[g] \geq 0$,  
(2) $g(x,y) \geq c SDP(x,y,\theta)$  
, where $c \in \mathbb{R}$ is a constant which is equal to the proved approximation factor.
The paper proposes three functions $g_1$, $g_2$, and $g_3$:  
$$g_1(x,y)=1-xy-\cos(\theta)\sqrt{x-x^2}\sqrt{y-y^2},$$  
$$g_2(x,y)=1-xy-2\cos(\theta)(x-x^2)(y-y^2),$$  
$$g_3(x,y)=1-xy-\frac12(1+5 \cos(\theta))(x-x^2)(y-y^2)(x+y)(2-x-y),$$  
and proves the results for $g_1$ analytically. Here, we have included the SoS proofs for the two mentioned criteria for both 
$g_2$ and $g_3$ and the codes are as follows:  
`g2_D.m`: a Matlab code which proves (1) for $g_2$.  
`g2_approax.m`: a Matlab code which proves (2) for $g_2$.  
`g3_D.m`: a Matlab code which proves (1) for $g_3$.  
`g3_approax.m`: a Matlab code which proves (2) for $g_3$.

