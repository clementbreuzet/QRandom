namespace Quantum.QRandom.SA {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Quantum.QRandom.Quantum;

    @EntryPoint()
    operation SampleRandomNumber (max: Int) : Unit {
        let result = SampleRandomNumberInRange(max);
        Message($"random value: {result}");
    }
}
