main :: () {
    X := make_mat(5, 2);
    y := make_vec(5);

    // X = [1 x]
    for i: 0..4 {
        *mat_at(&X, i, 0) = 1;
        *mat_at(&X, i, 1) = cast(f64) i;
        y.data[i] = 1 + 2 * i;
    }

    beta := ols_fit(&X, &y);

    fmt.println("beta =", beta.data[0], beta.data[1]);

    free_mat(&X);
    free_vec(&y);
    free_vec(&beta);
}
