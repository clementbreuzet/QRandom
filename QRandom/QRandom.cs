using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Quantum.QRandom.Quantum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using QConvert = Microsoft.Quantum.Convert;

namespace QRandom
{
    public class QRandom
    {
        private uint _seed;
        private QuantumSimulator _qsim;

        public QRandom(uint seed)
        {
            Initialize(seed);
        }

        private void Initialize(uint seed)
        {
            _seed = seed;
            _qsim = new QuantumSimulator();
        }

        public async Task<uint> Next()
        {
            var arrayByte = await GenerateNumberAsByteArray();
            uint value = BitConverter.ToUInt32(arrayByte, 0) - 1;
            return Convert.ToUInt32((Convert.ToDouble(value) / Convert.ToDouble(uint.MaxValue)) * _seed);
        }

        private async Task<byte[]> GenerateNumberAsByteArray()
        {
            var numberAsByteArray = new byte[4];

            for (int i = 0; i < 4; i++)
            {
                var qArrayByte = await GenerateQArrayByte();
                var arrayBool = ConvertToArrayBool(qArrayByte);
                int index = 8 - arrayBool.Count();
                byte result = 0;
                foreach (bool b in arrayBool)
                {
                    if (b)
                    {
                        result |= (byte)(1 << (7 - index));
                    }
                    index++;
                }
                numberAsByteArray[i] = result;
            }
            return numberAsByteArray;
        }

        private async Task<IQArray<Result>> GenerateQArrayByte()
        {
            return await GenerateByte.Run(_qsim);
        }

        private IEnumerable<bool> ConvertToArrayBool(IQArray<Result> results)
        {
            foreach (var result in results)
            {
                yield return QConvert.ResultAsBool.Run(_qsim, result).Result;
            }
        }
    }
}
