namespace Quantum.QRandom.App {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    // Pour lancer cette opération: ProjectFolder\dotnet run --max {value}
    @EntryPoint()
    operation SampleRandomNumber(max: Int) : Unit {
        let result = SampleRandomNumberInRange(max);
        Message($"random value: {result}");
	}

    operation SampleRandomNumberWithReturn(max: Int) : Int{
        return SampleRandomNumberInRange(max);
    }

    operation SampleQuantumRandomNumberGenerator() : Result {
        // On utilise un qubit 'jetable' avec le mot clé borrowing
        borrowing (q = Qubit())  { 

            // On met notre Qubit dans un état de superposition
            H(q);

            // On mesure notre Qubit puis on le remet dans un état initial |0>
            return MResetZ(q);  
        }
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        // On déclare un tableau altérable de Result
        mutable bits = new Result[0];

        // On itère sur le nombre bit necessaire à la creation de notre entier
        // On ajoute ces entiers à notre tableau de bits
        for (idxBit in 1..BitSizeI(max)) {
            set bits += [SampleQuantumRandomNumberGenerator()];
        }
        // On convertit notre tableau de Result en entier
        let sample = ResultArrayAsInt(bits);

        // Si notre entier est supérieur à la valeur désiré, on recommence l'opération, sinon on retourne la valeur
        return sample > max
               ? SampleRandomNumberInRange(max)
               | sample;
    }
}
