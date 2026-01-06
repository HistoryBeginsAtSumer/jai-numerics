ols_fit :: (X: *Mat, y: *Vec) -> Vec {
    n := X.rows;
    p := X.cols;

    XtX := make_mat(p, p);
    Xty := make_vec(p);

    // XtX = XᵀX
    for i: 0..p - 1 {
        for j: i..p - 1 {
            s: float = 0.0;

            for k: 0..n - 1 {
                s += mat_get(X, k, i) * mat_get(X, k, j);
            }

            mat_set(*XtX, i, j, s);
            mat_set(*XtX, j, i, s);
        }
    }

    // Xty = Xᵀy
    for i: 0..p - 1 {
        s: float = 0.;

        for k: 0..n - 1 {
            s += mat_get(X, k, i) * vec_get(y, k);
        }

        vec_set(*Xty, i, s);
    }

    ok := chol_inplace(*XtX);
    assert(ok);  // v0.0: fail hard

    beta := make_vec(p);
    tmp  := make_vec(p);

    solve_lower(*XtX, *Xty, *tmp);
    solve_upper_transpose(*XtX, *tmp, *beta);

    return beta;
}
