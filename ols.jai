ols_fit :: (X: *Mat, y: *Vec) -> Vec {
    n := X.rows;
    p := X.cols;

    XtX := make_mat(p, p);
    Xty := make_vec(p);

    // XtX = XᵀX
    for i: 0..p-1 {
        for j: i..p-1 {
            s: f64 = 0;
            for k: 0..n-1 {
                s += *mat_at(X, k, i) * *mat_at(X, k, j);
            }
            *mat_at(&XtX, i, j) = s;
            *mat_at(&XtX, j, i) = s;
        }
    }

    // Xty = Xᵀy
    for i: 0..p-1 {
        s: f64 = 0;
        for k: 0..n-1 {
            s += *mat_at(X, k, i) * y.data[k];
        }
        Xty.data[i] = s;
    }

    ok := chol_inplace(&XtX);
    assert(ok); // v0.0: fail hard

    beta := make_vec(p);
    tmp  := make_vec(p);

    solve_lower(&XtX, &Xty, &tmp);
    solve_upper_transpose(&XtX, &tmp, &beta);

    free_mat(&XtX);
    free_vec(&Xty);
    free_vec(&tmp);

    return beta;
}
