using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.IO;

namespace TestIdea
{
  class Program
  {
    static ArrayList УжеПроверен = new ArrayList();
    static void Main(string[] args)
    {
      bool[] use = new bool[6];
      bool[] states = { false, true };
      using (StreamWriter sw = new StreamWriter(File.Create("out.txt"), Encoding.GetEncoding("Windows-1251")))
      {
        foreach (bool i1 in states)
        {
          foreach (bool i2 in states)
          {
            foreach (bool i3 in states)
            {
              foreach (bool i4 in states)
              {
                foreach (bool i5 in states)
                {
                  foreach (bool i6 in states)
                  {
                    use[0] = i1;
                    use[1] = i2;
                    use[2] = i3;
                    use[3] = i4;
                    use[4] = i5;
                    use[5] = i6;

                  }
                }
              }
            }
          }
        }
      };
    }
  }
}
