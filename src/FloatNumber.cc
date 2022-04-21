#include "FloatNumber.hh"


FloatNumber::FloatNumber() : Number(FLOAT_NUMBER)
{
  // empty
}

FloatNumber::FloatNumber(float value) : Number(FLOAT_NUMBER), value(value)
{
  // empty
}

void FloatNumber::print(std::ostream& os)
{
  os << value;
}

std::ostream& operator<<(std::ostream& os, FloatNumber& num)
{
  num.print(os);
  return os;
}
