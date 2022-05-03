#include "IntegerNumber.hh"


IntegerNumber::IntegerNumber() : Number(INTEGER_NUMBER)
{
  // empty
}

IntegerNumber::IntegerNumber(int value) : Number(INTEGER_NUMBER), value(value)
{
  // empty
}

void IntegerNumber::print(std::ostream& os)
{
  os << value;
}

std::string IntegerNumber::codegen()
{
  return std::to_string(value);
}

std::ostream& operator<<(std::ostream& os, IntegerNumber& num)
{
  num.print(os);
  return os;
}
