// numerics/linalg/linalg.jai
// module numerics.linalg;

dot :: (x: *Vec, y: *Vec) -> float {
    assert(x.n == y.n);
    s := 0.;

    for i: 0..x.n - 1 {
        s += vec_get(x, i) * vec_get(y, i);
    }

    return s;
}

gemv :: (A: *Mat, x: *Vec, out: *Vec) {
    assert(A.cols == x.n);
    assert(A.rows == out.n);

    for i: 0..A.rows - 1 {
        s := 0.;

        for j: 0..A.cols - 1 {
            s += mat_get(A, i, j) * vec_get(x, j);
        }

        vec_set(out, i, s);
    }
}

vec_add :: (x: *Vec, y: float) {
    for i: 0..x.n - 1 {
        vec_set(x, i, vec_get(x, i) + y);
    }
}

vec_add :: (x: *Vec, y: *Vec) {
    assert(x.n == y.n);

    for i: 0..x.n - 1 {
        vec_set(x, i, vec_get(x, i) + vec_get(y, i));
    }
}

mat_mult :: (A: *Mat, B: *Mat) -> Mat {
    assert(A.cols == B.rows);

    n := A.cols;
    out := make_mat(A.rows, B.cols);

    for i: 0..A.rows - 1 {
        for j: 0..B.cols - 1 {
            s := 0.;

            for k: 0..n - 1 {
                s += mat_get(A, i, k) * mat_get(B, k, j);
            }

            mat_set(*out, i, j, s);
        }
    }

    return out;
}

mat_mult :: (A: *Mat, v: *Vec) -> Vec {
    B := make_mat(v.n, 1, v.*);
    return mat_get_col(*mat_mult(A, *B), 0);
}
