#ifndef TYPES_HH
#define TYPES_HH

#include <iostream>

struct Expression
{
};

struct Number : Expression
{
  virtual void printValue() = 0;
};

struct IntegerNumber : Number
{
  int value;
  virtual void printValue()
  {
    std::cout << value;
  }
  IntegerNumber(int value) : value(value) {}
};

struct FloatNumber : Number
{
  float value;
  virtual void printValue()
  {
    std::cout << value;
  }
  FloatNumber(float value) : value(value) {}
};


#endif // TYPES_HH