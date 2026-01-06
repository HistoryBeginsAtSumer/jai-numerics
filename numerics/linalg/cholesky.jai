#import "Math";

chol_inplace :: (A: *Mat) -> bool {
    assert(A.rows == A.cols);
    n := A.rows;

    for k: 0..n - 1 {
        sum: float = 0.;

        for j: 0..k - 1 {
            v := mat_get(A, k, j);
            sum += v * v;
        }

        diag := mat_get(A, k, k) - sum;

        if diag <= 0 {
            return false;  // not SPD
        }

        Lkk := sqrt(diag);
        mat_set(A, k, k, Lkk);

        for i: k + 1..n - 1 {
            s: float = 0.;

            for j: 0..k - 1 {
                s += mat_get(A, i, j) * mat_get(A, k, j);
            }

            s = (mat_get(A, i, k) - s) / Lkk;
            mat_set(A, i, k, s);
        }
    }

    // zero upper triangle (optional hygiene)
    for i: 0..n - 1 {
        for j: i + 1..n - 1 {
            mat_set(A, i, j, 0.0);
        }
    }

    return true;
}

solve_lower :: (L: *Mat, b: *Vec, x: *Vec) {
    n := L.rows;

    for i: 0..n - 1 {
        s := vec_get(b, i);

        for j: 0..i - 1 {
            s -= mat_get(L, i, j) * vec_get(x, j);
        }

        s /= mat_get(L, i, i);
        vec_set(x, i, s);
    }
}

solve_upper_transpose :: (L: *Mat, y: *Vec, x: *Vec) {
    n := L.rows;

    for < i: 0..n - 1 {
        s := vec_get(y, i);

        for j: i + 1..n - 1 {
            s -= mat_get(L, j, i) * vec_get(x, j);
        }

        s /= mat_get(L, i, i);
        vec_set(x, i, s);
    }
}
