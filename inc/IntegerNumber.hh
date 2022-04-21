#ifndef INTEGERNUMBER_HH
#define INTEGERNUMBER_HH


#include "Number.hh"


struct IntegerNumber : Number
{
  int value;
  void print(std::ostream& os);
  IntegerNumber();
  IntegerNumber(int value);
};

std::ostream& operator<<(std::ostream& os, IntegerNumber& num);


#endif // INTEGERNUMBER_HH
