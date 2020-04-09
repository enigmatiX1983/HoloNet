# HoloNet
Holographic Neural Network

Implementation of a Holographic Neural network as defined by J. G. Sutherland.  Included is a publicly accessible paper with its mathematical model: "Holographic Neural Networks" - R. Manger.

Holographic Neural Networks (also Holographic Associative Memory) have some interesting benefits over traditional Neural Networks.  Instead of a back-propagation algorithm which is achieved by modifying each neuron's weight in order to minimize a function, Holographic Neural networks learn by taking the dot product of a specially prepared stimulus vector's conjugate transpose (s(n) of a set S)  with a desired response vector (r(n) of set R), after each vector's components are mapped to the complex plane.  Taking the dot product, geometrically (in the complex plane) finds the phase difference between each component compared pair-wise.

It requires only one operation to return the "imprinted" response vector, multiplying the novel stimulus' conjugate transpose (ns(n) in set NS) with the size(m(n)) * size(r(n)) Holgraphic Matrix.

Thus, a stimulus size of 20, with a set of 3 orthogonal-response-bits, gives us a holographic matrix size of (20 * 3) = 60, in the form of a 20x3 matrix of complex valued numbers.

Some preprocessing needs to be done, namely taking the stimulus data and making sure that the stimuli are well-distributed around the complex plane, else errors can accrue, and the accuracy can be affected.

Also included are higher-order functions to achieve stimulus expansion (which allows more simulus/response vectors to be accurately stored), as a Hermetian matrix appended to the stimulus matrix.
