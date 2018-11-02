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
Let <img src="/tex/8eebf91f3af703a9133af119c2c48ce9.svg?invert_in_darkmode&sanitize=true" align=middle width=96.641589pt height=14.611878600000017pt/> be the solution vectors of the SDP relaxation.
Each subset of size <img src="/tex/2103f85b8b1477f430fc407cad462224.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55596444999999pt height=22.831056599999986pt/> of these vectors forms a <img src="/tex/2103f85b8b1477f430fc407cad462224.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55596444999999pt height=22.831056599999986pt/>-dimensional spatial configuration.
Based on the problem that we want to solve, we are only interested in particular values of <img src="/tex/2103f85b8b1477f430fc407cad462224.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55596444999999pt height=22.831056599999986pt/>. For example, in all 
of the binary Max-2-CSP problems that we consider, we are interested in 3-dimensional configurations consisting of
<img src="/tex/e53bb0b68d306e5a270fe0f587e42ab8.svg?invert_in_darkmode&sanitize=true" align=middle width=16.529662049999992pt height=14.611878600000017pt/> and two other vectors.

The idea is that for a given configuration, we can find its contribution in the SDP relaxation (based on the objective of 
the relaxation).
Moreover, we are able to compute the expected value of the rounding procedure.
Thus, we determine the expected approximation ratio of the rounding for this specific configuration. 
By repeating this procedure on all of the feasible configurations for a problem of interest (e.g., Max-Cut), and taking 
their minimum, we will find the expected approximation factor of the rounding algorithm on this problem for all instances.

In order to enumerate all the configurations, we need to discretize the space of possible configurations.
The discretization can be done based on the representation that we choose for <img src="/tex/c4afd3f927cf5e7e191266f7350714e0.svg?invert_in_darkmode&sanitize=true" align=middle width=14.628015599999989pt height=14.611878600000017pt/>. 
As defined in the paper, we can write each vector <img src="/tex/c4afd3f927cf5e7e191266f7350714e0.svg?invert_in_darkmode&sanitize=true" align=middle width=14.628015599999989pt height=14.611878600000017pt/> as <img src="/tex/23aa6ff2687d438a348158229e09f895.svg?invert_in_darkmode&sanitize=true" align=middle width=107.98189049999998pt height=19.1781018pt/>. 
Based on this notation, each two vectors <img src="/tex/c4afd3f927cf5e7e191266f7350714e0.svg?invert_in_darkmode&sanitize=true" align=middle width=14.628015599999989pt height=14.611878600000017pt/> and <img src="/tex/96235a90d058ab0f9bc16c8a1a37aa49.svg?invert_in_darkmode&sanitize=true" align=middle width=16.08162434999999pt height=14.611878600000017pt/> can be realized by having <img src="/tex/9fc20fb1d3825674c6a279cb0d5ca636.svg?invert_in_darkmode&sanitize=true" align=middle width=14.045887349999989pt height=14.15524440000002pt/> and <img src="/tex/4d8443b72a1de913b4a3995119296c90.svg?invert_in_darkmode&sanitize=true" align=middle width=15.499497749999989pt height=14.15524440000002pt/> and 
also the angle between vectors <img src="/tex/e88edbf4c389f77c73137df563d51056.svg?invert_in_darkmode&sanitize=true" align=middle width=18.30379484999999pt height=14.611878600000017pt/> and <img src="/tex/607e620664d7cab446228b1147ec906e.svg?invert_in_darkmode&sanitize=true" align=middle width=19.75740524999999pt height=14.611878600000017pt/>, denoted by <img src="/tex/4b0c1c1a7f0970de2545973312f21072.svg?invert_in_darkmode&sanitize=true" align=middle width=18.472301099999992pt height=22.831056599999986pt/>. 
In other words, each configuration is of the form <img src="/tex/9b43195e4a51831d582b0cb8a47e76ed.svg?invert_in_darkmode&sanitize=true" align=middle width=144.3721818pt height=24.65753399999998pt/>, where <img src="/tex/39eeb375dd63994e249344baa2ae2eb4.svg?invert_in_darkmode&sanitize=true" align=middle width=91.46294685pt height=24.65753399999998pt/> and 
<img src="/tex/cda19f7637b915e58b1f45d3697c3b51.svg?invert_in_darkmode&sanitize=true" align=middle width=74.00294054999999pt height=24.65753399999998pt/>. 
Note that <img src="/tex/c2c1ffc64fafa0a3c1108be047c4c155.svg?invert_in_darkmode&sanitize=true" align=middle width=47.656260299999985pt height=22.831056599999986pt/> implicitly considers <img src="/tex/e53bb0b68d306e5a270fe0f587e42ab8.svg?invert_in_darkmode&sanitize=true" align=middle width=16.529662049999992pt height=14.611878600000017pt/> as well.
The whole process of finding the approximation factor of a given problem is described in Algorithm 1. 
In what follows, <img src="/tex/f19c5e6eb3a3636eb27cae3071665f74.svg?invert_in_darkmode&sanitize=true" align=middle width=110.72923784999999pt height=24.65753399999998pt/> is equivalent with <img src="/tex/d0f8ef7494681f6b5311e319113b1263.svg?invert_in_darkmode&sanitize=true" align=middle width=41.50739834999999pt height=24.65753399999998pt/> as defined in the preliminaries with a slight 
change that <img src="/tex/f19c5e6eb3a3636eb27cae3071665f74.svg?invert_in_darkmode&sanitize=true" align=middle width=110.72923784999999pt height=24.65753399999998pt/> explicitly states the objective of clause <img src="/tex/9b325b9e31e85137d1de765f43c0f8bc.svg?invert_in_darkmode&sanitize=true" align=middle width=12.92464304999999pt height=22.465723500000017pt/> in terms of its inputs 
(instead of <img src="/tex/b4186a7f11d640316d31f146ea79ef3f.svg?invert_in_darkmode&sanitize=true" align=middle width=37.67316464999999pt height=14.15524440000002pt/> and <img src="/tex/64f56542d8c96b6573f52b8e6135215f.svg?invert_in_darkmode&sanitize=true" align=middle width=20.15039564999999pt height=14.15524440000002pt/>).

![Algorithm 1](https://github.com/sabbasizadeh/brownian-rounding/blob/master/alg1.png "Algorithm 1")

Algorithm 1 discards all the configurations which violate the triangle inequalities as they cannot be appeared in the 
solution of the SDP.
Code `approximation_ratio_finder.sage` implements Algorithm 1.
However, Algorithm 1 uses subroutine <img src="/tex/f3778000bfc0ee846c972a558e10d161.svg?invert_in_darkmode&sanitize=true" align=middle width=189.68401319999998pt height=24.65753399999998pt/>conf_{ij}<img src="/tex/ee28c74bfb67b15c2001f65843f8c94a.svg?invert_in_darkmode&sanitize=true" align=middle width=6.39271709999999pt height=24.65753399999998pt/> that returns the expected value of the rounding algorithm
for <img src="/tex/3e7d30640ead2b8786a1d3fcfc827431.svg?invert_in_darkmode&sanitize=true" align=middle width=43.752127649999984pt height=22.831056599999986pt/>.
This value can be computed (in expectation) using two different approaches:
1. Directly simulating the algorithm's diffusion process and repeating it sufficiently many times to obtain the expected value of
the rounding with high probability.
`brownian_simulation.sage` is the Sage implementation of this approach.
2. Numerically solving the corresponding boundary value PDE of the process which is also equivalent to the expected rounded value. 
`brownian_probability_generator.m` is a Mathematica code which implements this approach.

We implemented both of these approaches for the walk with <img src="/tex/1924b0e737a1c5c085f6e7f1b0fa4840.svg?invert_in_darkmode&sanitize=true" align=middle width=40.713337499999994pt height=21.18721440000001pt/>, and as we expected, we observed that the results of these 
two approaches are consistent.
Nonetheless, in all of the reported results, we employed the PDE approach for computing <img src="/tex/f3778000bfc0ee846c972a558e10d161.svg?invert_in_darkmode&sanitize=true" align=middle width=189.68401319999998pt height=24.65753399999998pt/>conf_{ij}<img src="/tex/ee28c74bfb67b15c2001f65843f8c94a.svg?invert_in_darkmode&sanitize=true" align=middle width=6.39271709999999pt height=24.65753399999998pt/>. 
(I.e., in order to get the final approximation result, you should run `brownian_probability_generator.m` and then feed its 
output to `approximation_ratio_finder.sage`.)
Note that from the practical point of view, it is straightforward to extend this framework to higher dimensional configurations as
long as we have enough computational power.


### 1.2. Higher-Dimension Brownian Rounding
In order to find the approximation ratio of the Max-DiCut problem, we used the higher-dimension algorithm in the paper.
Code `dicut-ratio-finder.sage` is the Sage implementation of the mentioned problem which again uses the probabilities found with 
`brownian_probability_generator.m` to find the approximation ratio of Max-DiCut.

## 2. Sum of Squares Proofs 
In order to use the maximum principle for a proposed function <img src="/tex/3cf4fbd05970446973fc3d9fa3fe3c41.svg?invert_in_darkmode&sanitize=true" align=middle width=8.430376349999989pt height=14.15524440000002pt/>, we have used proofs using sum of squares methods 
to show that:  
(1) <img src="/tex/61df49547d4a5eea21a56dd1c368109c.svg?invert_in_darkmode&sanitize=true" align=middle width=59.03758904999999pt height=24.65753399999998pt/>,  
(2) <img src="/tex/a6bcb51f5330e091bc682b94229d5125.svg?invert_in_darkmode&sanitize=true" align=middle width=167.1426108pt height=24.65753399999998pt/>  
, where <img src="/tex/38078c5daea8c0c56efcfd83cf0afe4d.svg?invert_in_darkmode&sanitize=true" align=middle width=39.077121599999984pt height=22.648391699999998pt/> is a constant which is equal to the proved approximation factor.
The paper proposes three functions <img src="/tex/a50c3a6cce0c5b640cc5bef1d62b99bd.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>, <img src="/tex/3a0999540a345758e8259a30f523c1c9.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>, and <img src="/tex/216062a7dbe9fffb932503cbaf2b6fcc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>:  
<p align="center"><img src="/tex/4e439908eadd690a655edba5605a50a7.svg?invert_in_darkmode&sanitize=true" align=middle width=313.14469065pt height=20.91216765pt/></p>  
<p align="center"><img src="/tex/1ea7292e3e9cf1a3d9796f1e65eb291b.svg?invert_in_darkmode&sanitize=true" align=middle width=316.79773124999997pt height=18.312383099999998pt/></p>  
<p align="center"><img src="/tex/49e9b6e32c4d2a82903e7187c904df9b.svg?invert_in_darkmode&sanitize=true" align=middle width=500.21000204999996pt height=32.990165999999995pt/></p>  
and proves the results for <img src="/tex/a50c3a6cce0c5b640cc5bef1d62b99bd.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/> analytically. Here, we have included the SoS proofs for the two mentioned criteria for both 
<img src="/tex/3a0999540a345758e8259a30f523c1c9.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/> and <img src="/tex/216062a7dbe9fffb932503cbaf2b6fcc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/> and the codes are as follows:  
`g2_D.m`: a Matlab code which proves (1) for <img src="/tex/3a0999540a345758e8259a30f523c1c9.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>.  
`g2_approax.m`: a Matlab code which proves (2) for <img src="/tex/3a0999540a345758e8259a30f523c1c9.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>.  
`g3_D.m`: a Matlab code which proves (1) for <img src="/tex/216062a7dbe9fffb932503cbaf2b6fcc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>.  
`g3_approax.m`: a Matlab code which proves (2) for <img src="/tex/216062a7dbe9fffb932503cbaf2b6fcc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.393129849999989pt height=14.15524440000002pt/>.

