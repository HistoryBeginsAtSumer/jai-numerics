// numerics/linalg/linalg.jai
// module numerics.linalg;

dot :: (x: *Vec, y: *Vec) -> float {
    assert(x.n == y.n);
    s: float = 0;

    for i: 0..x.n - 1 {
        s += vec_get(x, i) * vec_get(y, i);
    }

    return s;
}

gemv :: (A: *Mat, x: *Vec, out: *Vec) {
    assert(A.cols == x.n);
    assert(A.rows == out.n);

    for i: 0..A.rows - 1 {
        s: float = 0.;

        for j: 0..A.cols - 1 {
            s += mat_get(A, i, j) * vec_get(x, j);
        }

        vec_set(out, i, s);
    }
}

vec_add_vec :: (x: *Vec, y: *Vec) -> Vec {
    assert(x.n == y.n);

    n := x.n;
    out := make_vec(n);

    for i: 0..n - 1 {
        vec_set(*out, i, vec_get(x, i) + vec_get(y, i));
    }

    return out;
}
