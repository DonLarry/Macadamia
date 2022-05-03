#ifndef FLOATNUMBER_HH
#define FLOATNUMBER_HH


#include "Number.hh"


struct FloatNumber : Number
{
  float value;
  void print(std::ostream& os);
  std::string codegen();
  FloatNumber();
  FloatNumber(float value);
};

std::ostream& operator<<(std::ostream& os, FloatNumber& num);


#endif // FLOATNUMBER_HH
