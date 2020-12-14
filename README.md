# filter-design
Digital filter design using MATLAB

I prepared these scripts to help me with a course on Digital Signal Processing as a part of my UG degree. This GitHub repo was created only as an afterthought, to help me with version control.
The scripts have been prepared in such a way that all intermediate steps in the process of designing the filters are also calculated which are otherwise only found through hand calculations. This works brilliantly if the questions ask you to find those intermediate values, which was the case in my course.
Focus is mainly on IIR Filters, specifically Butterworth and Chebyshev Type-1 filters.

## Steps for IIR Filter Design
The standard procedure of designing digital filters has been use as described below:

<ul>
  <li>Prewarping given frequency specifications to adjust for bilinear transformation</li>
  <li>Calculating the analog lowpass filter prototype specs</li>
  <li>Designing analog LP prototype filter using Butterworth or Chebyshev filters</li>
  <li>Applying spectral transformations to generate analog filter of desired specifications</li>
  <li>Applying bilinear transformation to get the required filter</li>
</ul>

The `digitalLPFilter.m`, `digitalHPFilter.m`, `digitalBPFilter.m` are the 3 scripts which can be used to design a filter by executing the above process. They call the functions `analogButterworthParams()` and `analogCheby1Params()` for the LP prototype filter design and the `prewarp()` for the prewarping step. 
The `frequencySampling()` function can be used to make FIR filters using the frequency sampling method from the desired magnitude response.
All remaining files were prepared to help me with the course and can be deleted safely. I have kept them just for my own use and they would be of little use to anyone else.

The output of all these scripts and function have been kept extremely verbose to help me in solving problems quickly.

Regards</br>
Arunabh Kashyap
