ols_fit :: (X: *Mat, y: *Vec, fit_intercept: bool = true) -> float, Vec {
    X_ := make_mat(X.rows, X.cols + ifx fit_intercept then 1 else 0);

    for i: 0..X.rows - 1 {
        for j: 0..X.cols - 1 {
            mat_set(*X_, i, j, mat_get(X, i, j));
        }
    }

    if fit_intercept {
        for i: 0..X.rows - 1 {
            mat_set(*X_, i, X.cols, 1.);
        }
    }

    n := X_.rows;
    p := X_.cols;

    XtX := make_mat(p, p);
    Xty := make_vec(p);

    // XtX = XᵀX
    for i: 0..p - 1 {
        for j: i..p - 1 {
            s := 0.;

            for k: 0..n - 1 {
                s += mat_get(*X_, k, i) * mat_get(*X_, k, j);
            }

            mat_set(*XtX, i, j, s);
            mat_set(*XtX, j, i, s);
        }
    }

    // Xty = Xᵀy
    for i: 0..p - 1 {
        s := 0.;

        for k: 0..n - 1 {
            s += mat_get(*X_, k, i) * vec_get(y, k);
        }

        vec_set(*Xty, i, s);
    }

    ok := chol_inplace(*XtX);
    assert(ok);  // v0.0: fail hard

    beta := make_vec(p);
    tmp  := make_vec(p);

    solve_lower(*XtX, *Xty, *tmp);
    solve_upper_transpose(*XtX, *tmp, *beta);

    intercept: float;
    coef: Vec;
    if fit_intercept {
        intercept = vec_get(*beta, p - 1);
        coef = make_vec(p - 1);

        for i: 0..p - 2 {
            vec_set(*coef, i, vec_get(*beta, i));
        }
    } else {
        intercept = 0.;
        coef = beta;
    }

    return intercept, coef;
}
