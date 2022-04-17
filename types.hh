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

//###################### operator+ #########################################
IntegerNumber* operator+(const IntegerNumber& i, const IntegerNumber& i1)
{
  return new IntegerNumber(i.value + i1.value);
}

FloatNumber* operator+(const FloatNumber& f, const FloatNumber& f1)
{
  return new FloatNumber(f.value + f1.value);
}

/*FloatNumber* operator+(const FloatNumber& f, const IntegerNumber& i)
{
  return new FloatNumber(f.value + i.value);
}*/

FloatNumber* operator+(const IntegerNumber& i, const FloatNumber& f)
{
  return new FloatNumber(i.value + f.value);
}

//###################### operator- #########################################
IntegerNumber* operator-(const IntegerNumber& i, const IntegerNumber& i1)
{
  return new IntegerNumber(i.value - i1.value);
}

FloatNumber* operator-(const FloatNumber& f, const FloatNumber& f1)
{
  return new FloatNumber(f.value - f1.value);
}

/*FloatNumber* operator-(const FloatNumber& f, const IntegerNumber& i)
{
  return new FloatNumber(f.value - i.value);
}*/

FloatNumber* operator-(const IntegerNumber& i, const FloatNumber& f)
{
  return new FloatNumber(i.value - f.value);
}

//###################### operator* #########################################
IntegerNumber* operator*(const IntegerNumber& i, const IntegerNumber& i1)
{
  return new IntegerNumber(i.value * i1.value);
}

FloatNumber* operator*(const FloatNumber& f, const FloatNumber& f1)
{
  return new FloatNumber(f.value * f1.value);
}

/*FloatNumber* operator*(const FloatNumber& f, const IntegerNumber& i)
{
  return new FloatNumber(f.value * i.value);
}*/

FloatNumber* operator*(const IntegerNumber& i, const FloatNumber& f)
{
  return new FloatNumber(i.value * f.value);
}

//###################### operator/ #########################################
FloatNumber* operator/(const IntegerNumber& i, const IntegerNumber& i1)
{
  return new FloatNumber(i.value / i1.value);
}

FloatNumber* operator/(const FloatNumber& f, const FloatNumber& f1)
{
  return new FloatNumber(f.value / f1.value);
}

/*FloatNumber* operator/(const FloatNumber& f, const IntegerNumber& i)
{
  return new FloatNumber(f.value / i.value);
}*/

FloatNumber* operator/(const IntegerNumber& i, const FloatNumber& f)
{
  return new FloatNumber(i.value / f.value);
}

#endif // TYPES_HH