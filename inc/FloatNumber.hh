#ifndef FLOATNUMBER_HH
#define FLOATNUMBER_HH


#include "Number.hh"


struct FloatNumber : Number
{
  float value;
  void print(std::ostream& os);
  FloatNumber();
  FloatNumber(float value);
};

std::ostream& operator<<(std::ostream& os, FloatNumber& num);


#endif // FLOATNUMBER_HH
