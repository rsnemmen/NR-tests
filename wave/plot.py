import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("output.dat")
phi,x = data.T[0],data.T[1]

auxp = []
auxx = []
k = 0
for i in range(len(phi)):
    if(x[i] < x[i-1]):
       plt.plot(auxx,auxp)
       plt.xlim(0,1)
       plt.ylim(-1,1)
       plt.savefig("img/fig."+str(k)+".png")
       k += 1
       plt.clf()
       auxp = []
       auxx = []
    else:
       auxp.append(phi[i])
       auxx.append(x[i])
