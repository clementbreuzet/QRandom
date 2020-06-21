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
            Console.WriteLine("Welcome to QRandom, please enter a range value");
            var range = Console.ReadLine();

            // On initialise un simulateur quantique dans un bloc using
            using (var qsim = new QuantumSimulator())
            {
                // On execute l'opération avec retour Int en asynchrone avec les paramètres demandés
                var result = await SampleRandomNumberWithReturn.Run(qsim, Convert.ToInt64(range));
                Console.WriteLine($"random value: {result}");

                //On execute l'opération en asynchrone avec les paramètres demandés
                //await SampleRandomNumber.Run(qsim, Convert.ToInt64(range));
            }
        }
    }
}
