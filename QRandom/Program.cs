using System;
using System.Threading.Tasks;

namespace QRandom
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var rand = new QRandom(100);
            var number = await rand.Next();
            Console.WriteLine(number);
        }
    }
}
