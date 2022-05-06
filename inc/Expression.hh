#ifndef EXPRESSIONS_HH
#define EXPRESSIONS_HH


struct Expression
{
  enum Type
  {
    EXPRESSION,
    FLOAT_NUMBER,
    INTEGER_NUMBER,
    STRING,
    IF_SEQUENCE,
    FOR_SEQUENCE
  };
  Type type;

  Expression();
  Expression(Type type);
  virtual ~Expression() = default;
};


#endif
