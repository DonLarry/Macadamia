#ifndef NUMBER_HH
#define NUMBER_HH


#include "Expression.hh"
#include <ostream>


struct Number : Expression
{
  virtual void print(std::ostream& os) = 0;
  virtual std::string codegen() = 0;

  Number();
  Number(Type type);
  virtual ~Number() = default;
};

Number* add(Number &a, Number &b);
Number* sub(Number &a, Number &b);
Number* mul(Number &a, Number &b);
Number* div(Number &a, Number &b);
Number* div_floor(Number &a, Number &b);

std::ostream& operator<<(std::ostream& os, Number& num);

#endif // NUMBER_HH
