namespace Quantum.QRandom.Quantum {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation SampleRandomNumber(max: Int) : Int {
        return SampleRandomNumberInRange(max);
    }

    operation SampleQuantumRandomNumberGenerator() : Result {
        borrowing (q = Qubit())  { 
            H(q);               
            return MResetZ(q);  
        }
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        mutable bits = new Result[0];
        for (idxBit in 1..BitSizeI(max)) {
            set bits += [SampleQuantumRandomNumberGenerator()];
        }
        let sample = ResultArrayAsInt(bits);
        return sample > max
               ? SampleRandomNumberInRange(max)
               | sample;
    }
}