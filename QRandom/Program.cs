using Microsoft.Quantum.Simulation.Simulators;
using Quantum.QRandom.Quantum;
using System;
using System.Threading.Tasks;

namespace QRandom
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("Press enter to generate a number, esc to exit!");
            while (Console.ReadKey().Key != ConsoleKey.Escape)
            {
                using (var qsim = new QuantumSimulator())
                {
                    var number = await SampleRandomNumber.Run(qsim, 100);
                    Console.WriteLine(number);
                }
                Console.WriteLine("Press enter to generate a number, esc to exit!");
            }
        }
    }
}
