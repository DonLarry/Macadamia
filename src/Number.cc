#include "Number.hh"
#include "FloatNumber.hh"
#include "IntegerNumber.hh"


Number::Number()
{
  // empty
}

Number::Number(Type type) : Expression(type)
{
  // empty
}

Number* add(Number &a, Number &b)
{
  auto valueA = (a.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&a)->value : ((IntegerNumber*)&a)->value;
  auto valueB = (b.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&b)->value : ((IntegerNumber*)&b)->value;
  if (a.type == Expression::FLOAT_NUMBER || b.type == Expression::FLOAT_NUMBER)
    return new FloatNumber(valueA + valueB);
  return new IntegerNumber(valueA + valueB);
}

Number* sub(Number &a, Number &b)
{
  auto valueA = (a.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&a)->value : ((IntegerNumber*)&a)->value;
  auto valueB = (b.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&b)->value : ((IntegerNumber*)&b)->value;
  if (a.type == Expression::FLOAT_NUMBER || b.type == Expression::FLOAT_NUMBER)
    return new FloatNumber(valueA - valueB);
  return new IntegerNumber(valueA - valueB);
}

Number* mul(Number &a, Number &b)
{
  auto valueA = (a.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&a)->value : ((IntegerNumber*)&a)->value;
  auto valueB = (b.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&b)->value : ((IntegerNumber*)&b)->value;
  if (a.type == Expression::FLOAT_NUMBER || b.type == Expression::FLOAT_NUMBER)
    return new FloatNumber(valueA * valueB);
  return new IntegerNumber(valueA * valueB);
}

Number* div(Number &a, Number &b)
{
  auto valueA = (a.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&a)->value : ((IntegerNumber*)&a)->value;
  auto valueB = (b.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&b)->value : ((IntegerNumber*)&b)->value;
  return new FloatNumber(valueA / valueB);
}

Number* div_floor(Number &a, Number &b)
{
  auto valueA = (a.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&a)->value : ((IntegerNumber*)&a)->value;
  auto valueB = (b.type == Expression::FLOAT_NUMBER) ? ((FloatNumber*)&b)->value : ((IntegerNumber*)&b)->value;
  return new IntegerNumber(valueA / valueB);
}

std::ostream& operator<<(std::ostream& os, Number& num)
{
  if (num.type == Expression::FLOAT_NUMBER)
    return os << *((FloatNumber*)&num);
  return os << *((IntegerNumber*)&num);
}
