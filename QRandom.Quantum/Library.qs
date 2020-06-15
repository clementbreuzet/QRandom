namespace Quantum.QRandom.Quantum {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    operation GenerateByte() : Result[]{
		mutable results = new Result[8];
        using(q0 = Qubit()){
            for(index in 0..7){
			    Set(q0, Zero);
                set results w/= index <- GetSuperpositionResult(q0);
                Reset(q0);
		    }
		}
        return results;
	}
	
    operation GetSuperpositionResult(qubit: Qubit) : Result{
		H(qubit);
        return M(qubit);
	}

    operation Set(qubit : Qubit, desiredResult: Result) : Unit {
        if (desiredResult != M(qubit)) {
            X(qubit);
        }
    }
}