#include "String.hh"


String::String() : Expression(STRINGG)
{
  // empty
}

String::String(std::string value) : Expression(STRINGG), value(value)
{
  // empty
}

String* add(String &a, String &b)
{
  auto valueA = ((String*)&a)->value;
  auto valueB = ((String*)&b)->value;

  return new String(valueA + valueB);
}

void String::print(std::ostream& os)
{
  os << value;
}

std::ostream& operator<<(std::ostream& os, String& str)
{
  return os << *((String*)&str);
}