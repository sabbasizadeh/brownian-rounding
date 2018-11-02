from math import fabs

address = 'INPUT FILE ADDRESS (THE PROBABILITY TABLE)'

"""
This function parses the numbers from the probability table.
Mathematica outputs numbers less than 1e-6 in a format which 
contains "*" and for our computational precision it is enough
to consider these numbers as 0. 
"""
def parse( s):
    if (s.find('*') >=0):
        return 0 
    return float(s)


table = [{},{},{},{}]
best_max_cut_ratio = 2
best_max_sat_ratio = 2

best_max_cut_tuple = None
best_max_sat_tuple = None

"""
This function checks whether the triangle ineqaulities are 
satisfied for a given configuration or not.
"""
def satisfy_triangle(xi,xj,theta):
    wiwj = sqrt((xi-xi*xi)*(xj-xj*xj))*cos(theta)
    if (wiwj < -min((1-xi)*(1-xj),xi*xj)):
        return False
    if (wiwj > min(xi*(1-xj),xj*(1-xi))):
        return False
    return True

"""
Here we find the worst-case ratio
"""
with open(address,'r') as f:
    next(f)
    for line in f:
        [xi,xj,theta,p00,p01,p11,p10] = line.split(',')
        p00 = parse(p00)
        p01 = parse(p01)
        p11 = parse(p11)
        p10 = parse(p10)
        if (p00+p01+p11+p10 < 0.5):
            continue
        table[0][(float(xi),float(xj),float(theta))] = p00
        table[1][(float(xi),float(xj),float(theta))] = p01
        table[2][(float(xi),float(xj),float(theta))] = p11
        table[3][(float(xi),float(xj),float(theta))] = p10

        xi = float(xi)
        xj = float(xj)
        theta = float(theta)

        if (not satisfy_triangle(xi,xj,theta)):
            continue
        
        max_cut_sdp= xi + xj - 2*xi*xj - 2*cos(theta)*(xi*(1-xi)*xj*(1-xj))^(1/2) #MAXCUT
        max_sat_sdp= xi + xj - xi*xj - cos(theta)*(xi*(1-xi)*xj*(1-xj))^(1/2) #MAXSAT
        
        max_cut_brown = 1-p11-p00
        max_sat_brown = 1-p00
       
        max_cut_ratio = 1.1
        max_sat_ratio = 1.1
      
        if (fabs(max_cut_sdp)>1e-3):
            max_cut_ratio = max_cut_brown/max_cut_sdp

        if (fabs(max_sat_sdp)>1e-3):
            max_sat_ratio = max_sat_brown/max_sat_sdp

        if (best_max_cut_ratio > max_cut_ratio):
            best_max_cut_ratio = max_cut_ratio
            best_max_cut_tuple = (xi,xj,float(theta/pi),max_cut_sdp,max_cut_brown,max_cut_ratio)

        if (best_max_sat_ratio > max_sat_ratio):
            best_max_sat_ratio = max_sat_ratio
            best_max_sat_tuple = (xi,xj,float(theta/pi),max_sat_sdp,max_sat_brown,max_sat_ratio)

        #print(best_ratio, xi,xj, float(txi), float(txj),theta,brownian,sdpvalue)
print('MAX-CUT')
print('best_ratio',best_max_cut_ratio)
print('best_tuple',best_max_cut_tuple)

print('MAX-SAT')
print('best_ratio',best_max_sat_ratio)
print('best_tuple',best_max_sat_tuple)
