import numpy as np
from math import fabs, sqrt

"""
generates the covariance matrix of a given configuration
"""
def gen_matrix(txy,x,y):
    A = matrix(RDF, [[x-x*x, cos(txy)*sqrt(x-x*x)*sqrt(y-y*y)],
                     [cos(txy)*sqrt(x-x*x)*sqrt(y-y*y), y-y*y]])
    return A.numpy()

"""
finds the Cholesky factorization of the matrix
"""
def get_vectors(A):
    M = []
    #print(A)
    for eig in A.eigenvalues():
        print(eig)
        if (eig< -1e-5):
            return None
    U,D,V = (A.SVD())
    D2 = copy(D)
    for i in xrange(D.nrows()):
        if (D[i,i] < -1e-5):
            return None
        if (D[i,i] < 1e-5):
            D2[i,i]=0
        else:
            D2[i,i] = sqrt(D[i,i])
    M = U*D2
    return M


"""
gets the starting point and covariance matrix of a configuration
"""
def get_configuration(txy,x,y):
    cov_matrix = gen_matrix(txy,x,y)
    starting_point = np.array([x,y])
    return (starting_point, cov_matrix)

"""
starts a move with covariance matrix cov_matrix inside [0,1]^k from point "motion" until it hits a facet
"""
def move_till_hit(k, motion, cov_matrix):
    counter=0
    means = [0 for i in range(k)]
    while not near_boundary(k, motion):
        counter=counter+1
        motion = np.add(motion , sigma*np.random.multivariate_normal(means, cov_matrix)) 
    return motion

"""
returns (True, r, s) when the motion is close to the facet p_r = s (facets of [0,1]^k)  
"""
def near_boundary(k, motion):
    for i in range(k):
        if np.absolute(motion[i] - 1) < sigma:
            return (True, i, 1)
        if np.absolute(motion[i] - 0) < sigma:
            return (True, i, 0)
    return False

"""
runs the simulation on a given configuration of max-cut 
"""
def maxcut(cov_matrix, starting_point):
    k=2
    motion = starting_point
    motion = move_till_hit(k, motion, cov_matrix)
    b, hit_face_id, hit_face_at = near_boundary(k, motion)
    return motion[0] + motion[1] - 2*motion[0]*motion[1]
        
"""
here we run the simulation many times to find the expected value
"""
sigma = 0.01
k=2
iters = 10000
txy=pi/2
x=0.5
y=0.5
starting_point, cov_matrix = get_configuration(txy,x,y)
print(starting_point)
print(cov_matrix)
value = 0.0
for i in range(1,iters+1):
    new_val = maxcut(cov_matrix, starting_point)
    print(i)
    value = value + new_val
    print(new_val, value/i)