# FilterBank

A small Octave (should theoretically be Matlab compatible AFAIK but has only been tested against GNU Octave version 4.4.1) program for decomposing a signal (e.g. audio) into subbands using triangle filters.

Usage: Copy the .m file into your Octave path and run ```filterbank(filename, number of bands, mode)``` where `filename` is the name of the audio file (in any format compatible with `audioread`) you wish to decompose, `number of bands` is the number of bands (not including the residual, which will also be saved) you wish to decompose the signal into, and `mode` is one of the following:

```
0: Triangle filter.
1: Modified triangle filter.
```

Output will be saved to the same folder as the input file.

## Possible improvements

I think the code could be significantly sped up by rewriting it so each iteration first computes a filter kernel equivalent to all the arithmetic being done in the current version and then doing a single convolution of that and the input file.

Since the filter is based on triangle filters, it could theoretically be extended to any number of dimensions, so it could be used to decompose things like 2D images/video and 3D voxelmaps.
