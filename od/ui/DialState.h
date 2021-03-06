/*
 * DialState.h
 *
 *  Created on: Oct 9, 2016
 *      Author: clarkson
 */

#ifndef APP_UTILS_DIALSTATE_H_
#define APP_UTILS_DIALSTATE_H_

#include <od/ui/DialMap.h>
#include <od/ui/EncoderHysteresis.h>

namespace od
{

  class DialState
  {
  public:
    DialState();
    virtual ~DialState();

    void setMap(DialMap *map);
    DialMap *getMap()
    {
      return mpMap;
    }
    float getValue();
    float encoder(int change, bool shifted, bool fine);
    float zero();
    void save();
    float restore();
    void setWithValue(float value);

  private:
    EncoderHysteresis mEncoderHysteresis;
    DialMap *mpMap = 0;

    // Using mixed radix system with 3 digits.
    DialPosition mPosition;
    DialPosition mSavedPosition;
    float mValue = 0.0f;
    bool mSaved = false;

    float set(const DialPosition &dp);
  };

} /* namespace od */

#endif /* APP_UTILS_DIALSTATE_H_ */
