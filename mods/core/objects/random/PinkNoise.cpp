/*
	Adapted from: http://www.firstpr.com.au/dsp/pink-noise/phil_burk_19990905_patest_pink.c

	patest_pink.c

	Generate Pink Noise using Gardner method.
	Optimization suggested by James McCartney uses a tree
	to select which random value to replace.

    x x x x x x x x x x x x x x x x
     x   x   x   x   x   x   x   x
       x       x       x       x
           x               x
                   x

    Tree is generated by counting trailing zeros in an increasing index.
	When the index is zero, no random number is selected.

    This program uses the Portable Audio library which is under development.
	For more information see:   http://www.audiomulch.com/portaudio/

    Author: Phil Burk, http://www.softsynth.com

	Revision History:

    Copyleft 1999 Phil Burk - No rights reserved.
*/

#include <core/objects/random/PinkNoise.h>
#include <od/extras/Random.h>
#include <od/config.h>
#include <hal/ops.h>

namespace od
{

#define PINK_RANDOM_BITS (24)
#define PINK_RANDOM_SHIFT ((sizeof(int) * 8) - PINK_RANDOM_BITS)

  PinkNoise::PinkNoise(int numRows)
  {
    addOutput(mOutput);

    numRows = MIN(MAX(0, numRows), PINK_MAX_RANDOM_ROWS);

    /* Setup PinkNoise structure for N rows of generators. */
    int i;
    int pmax;
    mIndex = 0;
    mIndexMask = (1 << numRows) - 1;
    /* Calculate maximum possible signed random value. Extra 1 for white noise always added. */
    pmax = (numRows + 1) * (1 << (PINK_RANDOM_BITS - 1));
    mScalar = 1.0f / pmax;
    /* Initialize rows. */
    for (i = 0; i < numRows; i++)
    {
      mRows[i] = 0;
    }
    mRunningSum = 0;
  }

  PinkNoise::~PinkNoise()
  {
  }

  void PinkNoise::process()
  {
    float *out = mOutput.buffer();
    float *end = out + globalConfig.frameLength;
    int newRandom;
    int sum;

    /* Generate Pink noise values between -1.0 and +1.0 */
    while (out < end)
    {
      /* Increment and mask index. */
      mIndex = (mIndex + 1) & mIndexMask;

      /* If index is zero, don't update any random values. */
      if (mIndex != 0)
      {
        /* Determine how many trailing zeros in PinkIndex. */
        /* This algorithm will hang if n==0 so test first. */
        int numZeros = 0;
        int n = mIndex;
        while ((n & 1) == 0)
        {
          n = n >> 1;
          numZeros++;
        }

        /* Replace the indexed ROWS random value.
			 * Subtract and add back to RunningSum instead of adding all the random
			 * values together. Only one changes each time.
			 */
        mRunningSum -= mRows[numZeros];
        newRandom = ((int)Random::generateUnsignedIntegerFast()) >> PINK_RANDOM_SHIFT;
        mRunningSum += newRandom;
        mRows[numZeros] = newRandom;
      }

      /* Add extra white noise value. */
      newRandom = ((int)Random::generateUnsignedIntegerFast()) >> PINK_RANDOM_SHIFT;
      sum = mRunningSum + newRandom;

      /* Scale to range of -1.0 to 0.9999. */
      *(out++) = mScalar * sum;
    }
  }

} /* namespace od */