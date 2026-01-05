chol_inplace :: (A: *Mat) -> bool {
    assert(A.rows == A.cols);
    n := A.rows;

    for k: 0..n-1 {
        sum: f64 = 0;
        for j: 0..k-1 {
            v := *mat_at(A, k, j);
            sum += v * v;
        }

        diag := *mat_at(A, k, k) - sum;
        if diag <= 0 {
            return false; // not SPD
        }

        Lkk := sqrt(diag);
        *mat_at(A, k, k) = Lkk;

        for i: k+1..n-1 {
            s: f64 = 0;
            for j: 0..k-1 {
                s += *mat_at(A, i, j) * *mat_at(A, k, j);
            }
            *mat_at(A, i, k) = (*mat_at(A, i, k) - s) / Lkk;
        }
    }

    // zero upper triangle (optional hygiene)
    for i: 0..n-1 {
        for j: i+1..n-1 {
            *mat_at(A, i, j) = 0;
        }
    }

    return true;
}
