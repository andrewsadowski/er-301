#pragma once

// modulation configuration
#define MOD_VOLTAGE_MAX (10.24f)
#define MOD_CODE_MAX (0xFFFF / 2)
#define MOD_SAMPLE_RATE 60000

/*
 * Input ranges
 * 0000 = Input range is set to +/-2.5 x VREF (0dB)
 * 0001 = Input range is set to +/-1.25 x VREF (+6dB)
 * 0010 = Input range is set to +/-0.625 x VREF (+12dB)
 * 0101 = Input range is set to 0 to 2.5 x VREF
 * 0110 = Input range is set to 0 to 1.25 x VREF
 */
#define MOD_BIPOLAR_2500 0b0000
#define MOD_BIPOLAR_1250 0b0001
#define MOD_BIPOLAR_0625 0b0010
#define MOD_UNIPOLAR_2500 0b0101
#define MOD_UNIPOLAR_1250 0b0110

#define MOD_NUM_CHANNELS_PER_ADC 8
#define MOD_NUM_CHANNELS (2 * MOD_NUM_CHANNELS_PER_ADC)

#define MOD_P1_IC 0
#define MOD_P2_IC 0
#define MOD_P3_IC 0
#define MOD_P4_IC 0

#define MOD_A1_IC 0
#define MOD_B1_IC 0
#define MOD_C1_IC 0
#define MOD_D1_IC 0

#define MOD_A2_IC 1
#define MOD_B2_IC 1
#define MOD_C2_IC 1
#define MOD_D2_IC 1

#define MOD_A3_IC 1
#define MOD_B3_IC 1
#define MOD_C3_IC 1
#define MOD_D3_IC 1

#define MOD_P1_CHANNEL 5
#define MOD_P2_CHANNEL 4
#define MOD_P3_CHANNEL 3
#define MOD_P4_CHANNEL 2

#define MOD_A1_CHANNEL 6
#define MOD_B1_CHANNEL 7
#define MOD_C1_CHANNEL 0
#define MOD_D1_CHANNEL 1

#define MOD_A2_CHANNEL 5
#define MOD_B2_CHANNEL 4
#define MOD_C2_CHANNEL 3
#define MOD_D2_CHANNEL 2

#define MOD_A3_CHANNEL 6
#define MOD_B3_CHANNEL 7
#define MOD_C3_CHANNEL 0
#define MOD_D3_CHANNEL 1

// true for INPUT_IN1 to INPUT_IN4
#define IS_AUDIO_INPUT(x) (x > 1 && x < 6)

#define INPUT_IN1 (MOD_P1_CHANNEL + MOD_P1_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_IN2 (MOD_P2_CHANNEL + MOD_P2_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_IN3 (MOD_P3_CHANNEL + MOD_P3_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_IN4 (MOD_P4_CHANNEL + MOD_P4_IC * MOD_NUM_CHANNELS_PER_ADC)

#define INPUT_A1 (MOD_A1_CHANNEL + MOD_A1_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_B1 (MOD_B1_CHANNEL + MOD_B1_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_C1 (MOD_C1_CHANNEL + MOD_C1_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_D1 (MOD_D1_CHANNEL + MOD_D1_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_A2 (MOD_A2_CHANNEL + MOD_A2_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_B2 (MOD_B2_CHANNEL + MOD_B2_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_C2 (MOD_C2_CHANNEL + MOD_C2_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_D2 (MOD_D2_CHANNEL + MOD_D2_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_A3 (MOD_A3_CHANNEL + MOD_A3_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_B3 (MOD_B3_CHANNEL + MOD_B3_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_C3 (MOD_C3_CHANNEL + MOD_C3_IC * MOD_NUM_CHANNELS_PER_ADC)
#define INPUT_D3 (MOD_D3_CHANNEL + MOD_D3_IC * MOD_NUM_CHANNELS_PER_ADC)

#define INPUT_G1 (MOD_NUM_CHANNELS)
#define INPUT_G2 (MOD_NUM_CHANNELS + 1)
#define INPUT_G3 (MOD_NUM_CHANNELS + 2)
#define INPUT_G4 (MOD_NUM_CHANNELS + 3)

#define OUTPUT_1 0
#define OUTPUT_2 1
#define OUTPUT_3 2
#define OUTPUT_4 3